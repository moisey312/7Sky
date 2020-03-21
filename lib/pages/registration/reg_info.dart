import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testproj/models/firestore.dart';

// ignore: must_be_immutable
class RegistrationInfo extends StatefulWidget{
  _RegistrationInfo createState() => new _RegistrationInfo();
}
class _RegistrationInfo extends State<RegistrationInfo> {
  TextEditingController startphone = new TextEditingController(text: '8(9');
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  TextEditingController _phone_ctr = new TextEditingController(text: '8(9');
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            FlatButton(
              child: Icon(
                Icons.check,
                color: Colors.white,
              ),
              onPressed: () {
                var form = _formKey.currentState;
                if(form.validate()){
                  form.save();
                }
                Navigator.pop(context, true);
              },
            )
          ],
          leading: Padding(
              padding: EdgeInsets.only(left: 5, top: 10),
              child: FlatButton(
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              )),
          title: Center(child:Text("Информация")),
        ),
        body: Container(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: <Widget>[
                  TextFormField(
                    controller: _phone_ctr,
                    inputFormatters: [PhoneTextFormatter()],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Номер телефона', hintText: '8(999)999-99-99', counterText: '',),
                    maxLength: 15,
                    validator: (value) {
                      if (value.length == 15) {
                        return null;
                      } else {
                        return 'Некорректный номер телефона';
                      }
                    },
                    onSaved: (value) {
                      Database.myProfile['number'] = value;
                    },
                  ),
                  SimpleAutoCompleteTextField(
                    key: key,
                    decoration: InputDecoration(labelText: 'Город'),
                    suggestions: city,
                    clearOnSubmit: false,
                    textSubmitted: (value) {
                      Database.myProfile['city'] = value;
                    },
                    submitOnSuggestionTap: true,
                  ),
                  Database.myProfile['typeId'] != 0
                      ? TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Цена от',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Цена не может быть пустой';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            Database.myProfile['price'] = value;
                          },
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ));
  }

  List<String> city = ['Иннополис', 'Казань', 'Москва'];
}
class PhoneTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    //this fixes backspace bug
    if (oldValue.text.length >= newValue.text.length) {
      if(oldValue.text.length<=3 || newValue.text.length<=3){
        return newValue.copyWith(text: '8(9',selection: updateCursorPosition('8(9'));
      }
      else{
        return newValue;
      }
    }

    var dateText = _addSeperators(newValue.text, '(', ')', '-');
    return newValue.copyWith(
        text: dateText, selection: updateCursorPosition(dateText));
  }

  String _addSeperators(String value, String seperator1, String seperator2, String seperator3) {
    value = value.replaceAll('(', '');
    value = value.replaceAll(')', '');
    value = value.replaceAll('-', '');
    var newString = '';
    for (int i = 0; i < value.length; i++) {
      newString += value[i];
      if (i == 0) {
        newString += seperator1;
      }
      if (i == 3) {
        newString += seperator2;
      }
      if(i == 6 || i==8){
        newString +=seperator3;
      }
    }
    return newString;
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}