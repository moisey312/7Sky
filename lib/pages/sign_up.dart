import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:testproj/services/authentication.dart';
import 'package:testproj/style.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({this.auth, this.loginCallback});
  static String _name;
  final BaseAuth auth;
  final VoidCallback loginCallback;
  // ignore: non_constant_identifier_names
  String return_name(){
    return _name;
  }
  @override
  State<StatefulWidget> createState() => new _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = new GlobalKey<FormState>();

  String _email; //локальная переменная мыла
  String _password; //локальная переменная пароля
  String _errorMessage;

  bool _isLoginForm;
  bool _isLoading;

  // Check if form is valid before perform login or signup
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Perform login or signup
  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (validateAndSave()) {
      String userId = "";
      try {
        if (_isLoginForm) {
          userId = await widget.auth.signIn(_email, _password);
          print('Signed in: $userId');
        } else {
          userId = await widget.auth.signUp(_email, _password);
          //widget.auth.sendEmailVerification();
          //_showVerifyEmailSentDialog();
          print('Signed up user: $userId');
        }
        setState(() {
          _isLoading = false;
        });

        if (userId.length > 0 && userId != null && _isLoginForm) {
          widget.loginCallback();
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _errorMessage = e.message;
          _formKey.currentState.reset();
        });
      }
    }
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    _isLoginForm = true;
    super.initState();
  }

  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  void toggleFormMode() {
    resetForm();
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
  }

  //виджет общего экрана
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          decoration: backgroundImageSignIn(),
          child: new BackdropFilter(
            filter: new ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
            child: new Container(
              decoration:
                  new BoxDecoration(color: Color.fromRGBO(0, 13, 25, 0.75)),
            ),
          ),
        ),
         _showForm(),
        _showCircularProgress(),
      ],
    ));
  }

  // виджет крутяшки типа загрузки, хочу поменять на горизонтальную прогресс фигню
  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  //виджет самого контейнера, который отображается
  Widget _showForm() {
    return new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: _formKey,
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              showNameInput(),
              showEmailInput(),
              showPasswordInput(),
              showPrimaryButton(),
              showSecondaryButton(),
              showErrorMessage(),
            ],
          ),
        ));
  }

  //виджет ошибки
  Widget showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget showNameInput() {
    if (_isLoginForm) {
      return Container(
        height: 0.0,
      );
    } else {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
        child: new TextFormField(
          maxLines: 1,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
          autofocus: false,
          decoration: inputDecoration('Имя'),
          validator: (value) =>
              value.isEmpty ? 'Имя не может быть пустым' : null,
          onSaved: (value) => SignUpPage._name = value.trim(),
        ),
      );
    }
  }

  //виджет поля мыла
  Widget showEmailInput() {
    return Padding(
      padding: _isLoginForm
          ? const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0)
          : const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: inputDecoration('E-mail'),
        validator: (value) =>
            value.isEmpty ? 'Email не может быть пустым' : null,
        onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  //виджет поля пароля
  Widget showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
        autofocus: false,
        decoration: inputDecoration('Пароль'),
        validator: (value) =>
            value.isEmpty ? 'Пароль не может быть пустым' : null,
        onSaved: (value) => _password = value.trim(),
      ),
    );
  }

  //нестатический виджет текст-кнопки, меняется в зависимости от формы
  Widget showSecondaryButton() {
    return new FlatButton(
        child: new Text(
            _isLoginForm ? 'Зарегестрироваться' : 'Уже есть аккаунт',
            style: TextStyle(color: Colors.white, fontSize: 18.0)),
        onPressed: toggleFormMode);
  }

  //тоже нестатическая кнопка, меняется по тому же принципу
  Widget showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Color.fromRGBO(255, 82, 42, 1),
            child: new Text(_isLoginForm ? 'Войти' : 'Зарегестрироваться',
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: validateAndSubmit,
          ),
        ));
  }
}
