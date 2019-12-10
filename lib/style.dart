import 'package:flutter/material.dart';
BoxDecoration backgroundImage() {
  return BoxDecoration(
    image: DecorationImage(
      image: AssetImage("assets/background.jpg"),
      fit: BoxFit.cover,
    ),
  );
}