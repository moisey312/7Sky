import 'package:flutter/material.dart';

BoxDecoration backgroundImageSignIn() {
  return BoxDecoration(
    image: DecorationImage(
      image: AssetImage("assets/background.jpg"),
      fit: BoxFit.cover,
    ),
  );
}
Color backgroundColor(){
  return Color.fromARGB(100, 240, 240, 240);
}
MaterialColor colorCustom = MaterialColor(0xFF000D19, color);
Map<int, Color> color =
{
  50:Color.fromRGBO(0,13,25, .1),
  100:Color.fromRGBO(0,13,25, .2),
  200:Color.fromRGBO(0,13,25, .3),
  300:Color.fromRGBO(0,13,25, .4),
  400:Color.fromRGBO(0,13,25, .5),
  500:Color.fromRGBO(0,13,25, .6),
  600:Color.fromRGBO(0,13,25, .7),
  700:Color.fromRGBO(0,13,25, .8),
  800:Color.fromRGBO(0,13,25, .9),
  900:Color.fromRGBO(0,13,25, 1),
};

InputDecoration inputDecoration(String textHint) {
  return InputDecoration(
    hintText: textHint,
    fillColor: Color.fromRGBO(255, 255, 255, 0.2),
    filled: true,
    hintStyle: TextStyle(color: Colors.white),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromRGBO(255, 255, 255, 0.5)),
        borderRadius: BorderRadius.circular(100.0)),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromRGBO(255, 255, 255, 0.7)),
        borderRadius: BorderRadius.circular(100.0)),
    errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(100.0)),
    focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(100.0)),
  );
}
TextStyle textStyle(){
  return TextStyle(
    color: Colors.white
  );
}

Map<int, Color> colorTheme =
{
  50:Color.fromRGBO(0,13,25, .1),
  100:Color.fromRGBO(0,13,25, .2),
  200:Color.fromRGBO(0,13,25, .3),
  300:Color.fromRGBO(0,13,25, .4),
  400:Color.fromRGBO(0,13,25, .5),
  500:Color.fromRGBO(0,13,25, .6),
  600:Color.fromRGBO(0,13,25, .7),
  700:Color.fromRGBO(0,13,25, .8),
  800:Color.fromRGBO(0,13,25, .9),
  900:Color.fromRGBO(0,13,25, 1),
};
