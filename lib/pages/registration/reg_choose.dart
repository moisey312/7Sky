import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:testproj/style.dart';
import 'package:testproj/models/firestore.dart';
class RegChoose extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: Text(
                "Зарегестрироваться как:",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 70, left: 41, right: 41),
              child: Container(
                height: 50,
                child: FlatButton(
                  child: Text("Пользователь",
                      style: TextStyle(color: Colors.white, fontSize: 13)),
                  onPressed: () {
                    Database.myProfile['typeId'] = 0;
                    Navigator.pop(context, true);
                  },
                  color: Color.fromRGBO(255, 255, 255, 0.2),
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(100),
                      side: BorderSide(
                          color: Color.fromRGBO(255, 255, 255, 0.7))),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 41, right: 41, top: 20),
              child: Container(
                height: 50,
                child: FlatButton(
                  child: Text(
                    "Фотограф",
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                  onPressed: () {
                    Database.myProfile['typeId'] = 1;
                    Navigator.pop(context, true);
                  },
                  color: Color.fromRGBO(255, 255, 255, 0.2),
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(100),
                      side: BorderSide(
                          color: Color.fromRGBO(255, 255, 255, 0.7))),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 41, top: 20, right: 41),
              child: Container(
                height: 50,
                child: FlatButton(
                  child: Text("Студия",
                      style: TextStyle(color: Colors.white, fontSize: 13)),
                  onPressed: () {
                    Database.myProfile['typeId'] = 2;
                    Navigator.pop(context, true);
                  },
                  color: Color.fromRGBO(255, 255, 255, 0.2),
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(100),
                      side: BorderSide(
                          color: Color.fromRGBO(255, 255, 255, 0.7))),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 150),
                child: FlatButton(
                  child: Text(
                    "У меня уже есть аккаунт",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  onPressed: (){
                    Database.myProfile.remove('typeId');
                    Navigator.pop(context, false);
                  },
                ))
          ],
        ),
      ],
    ));
  }
}
