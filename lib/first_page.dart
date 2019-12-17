import 'package:flutter/material.dart';
import 'package:testproj/services/authentication.dart';
class FirstPage extends StatelessWidget {
  const FirstPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: new AppBar(
//        title: new Text('Flutter login demo'),
//        actions: <Widget>[
//          new FlatButton(
//              child: new Text('Logout',
//                  style: new TextStyle(fontSize: 17.0, color: Colors.white)),
//              onPressed: signOut)
//        ],
//      ),
    appBar: new AppBar(
      title: new Text('Профиль'),
    ),
      body: ListView.builder(itemBuilder: (context, index) {
        return ListTile(
          title: Text('Текст Отзыва'),
          subtitle: Text('$index'),
        );
      }),
    );
  }
}
