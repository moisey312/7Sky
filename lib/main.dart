import 'package:flutter/material.dart';
import 'package:testproj/services/authentication.dart';
import 'package:testproj/pages/root_page.dart';
import 'package:testproj/navigation_bar_controller.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: '7 sky',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        home: new RootPage(auth: new Auth()));
  }
}