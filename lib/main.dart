import 'package:flutter/material.dart';
import 'package:testproj/services/authentication.dart';
import 'package:testproj/pages/root_page.dart';
import 'style.dart';
import 'package:testproj/pages/registration/reg_info.dart';
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
          primarySwatch: colorCustom,
        ),
        home:  new RootPage(auth: new Auth()));
  }
}