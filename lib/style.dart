import 'package:flutter/material.dart';

BoxDecoration backgroundImage() {
  return BoxDecoration(
    image: DecorationImage(
      image: AssetImage("assets/background.jpg"),
      fit: BoxFit.cover,
    ),
  );
}

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
