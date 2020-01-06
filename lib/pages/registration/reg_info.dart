import 'package:flutter/material.dart';
import 'package:testproj/models/firestore.dart';

class Reg_Info extends StatelessWidget {
  ListTile prise(){
    if(FireStoreFuns.typeId==0){
      return ListTile(
        title: Container(
          height: 0,
        ),
      );
    }else{
      return ListTile(
        title: TextFormField(
          maxLines: 1,
          decoration: InputDecoration(
            hintText: 'Цена от',
          ),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
              padding: EdgeInsets.only(left: 5, top: 10),
              child: FlatButton(
                child: Text(
                  "Отмена",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )),
          title: Text("Информация"),
          centerTitle: true,
        ),
        body: ListView(
            children: ListTile.divideTiles(tiles: [
          ListTile(
            title: Text("Город"),
          ),
          ListTile(
            title: TextFormField(
              maxLines: 1,
              decoration: InputDecoration(
                  hintText: 'Номер телефона',
                  hintStyle: TextStyle(color: Colors.black)),
            ),
          ),
          prise()

        ], context: context)
                .toList()));
  }
}
