import 'package:flutter/material.dart';
import 'package:testproj/models/firestore.dart';

class Reg_Info extends StatelessWidget {
  ListTile prise() {
    if (FireStoreFuns.typeId == 0) {
      return ListTile(
        title: Container(
          height: 0,
        ),
      );
    } else {
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
  TextEditingController startphone = new TextEditingController(text: '+7');
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Готово',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.pop(context, true);
              },
            )
          ],
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
                  Navigator.pop(context, false);
                },
              )),
          title: Text("Информация"),
          centerTitle: true,
        ),
        body: ListView(
            children: ListTile.divideTiles(tiles: [
          ListTile(
            title: Text("Город" + "   " + FireStoreFuns.city),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Choose_City()));
            },
          ),
          ListTile(
            title: TextField(
              maxLines: 1,
              maxLength: 12,
              controller: startphone,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: 'Номер телефона',
                  hintStyle: TextStyle(color: Colors.black)),
              onChanged: (value) {
                FireStoreFuns.number = value.trim();
              },
            ),
          ),
          prise()
        ], context: context)
                .toList()));
  }
}

class Choose_City extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: FlatButton(
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        title: Text("Город"),
        centerTitle: true,
      ),
      body: ListView(
        children: ListTile.divideTiles(tiles: [
          ListTile(
            title: Text('Казань'),
            onTap: () {
              FireStoreFuns.city = 'Казань';
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Иннополис'),
            onTap: () {
              FireStoreFuns.city = 'Иннополис';
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Москва'),
            onTap: () {
              FireStoreFuns.city = 'Москва';
              Navigator.pop(context);
            },
          ),
        ], context: context)
            .toList(),
      ),
    );
  }
}
