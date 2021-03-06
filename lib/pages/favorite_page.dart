import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: AppBar(
            title: Center(
                child: Text(
              "Избранное",
              style: TextStyle(fontSize: 17),
            )),
          ),
        ),
        body: Container(
          height: 0,
        ));
  }
}
