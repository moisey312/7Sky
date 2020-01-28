import 'package:flutter/material.dart';
import 'package:testproj/models/firestore.dart';


// ignore: must_be_immutable
class RegistrationInfo extends StatelessWidget {
  ListTile price() {
    if (Database.myProfile['typeId'] == 0) {
      return ListTile(
        title: Container(
          height: 0,
        ),
      );
    } else {
      return ListTile(
        title: TextField(
          maxLines: 1,
          decoration: InputDecoration(
            hintText: 'Цена от',
          ),
            keyboardType: TextInputType.number,
          onChanged: (value){
            Database.myProfile['price'] = value;
          },
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
              child: Icon(Icons.check,
              color: Colors.white,),
              onPressed: () {
                Navigator.pop(context, true);
              },
            )
          ],
          leading: Padding(
              padding: EdgeInsets.only(left: 5, top: 10),
              child: FlatButton(
                child: Icon(Icons.arrow_back, color: Colors.white,
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
            title: Text(Database.myProfile.containsKey('city')?"Город" + "   " + Database.myProfile['city']:"Город"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChooseCity()));
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
                Database.myProfile['number'] = value.trim();
              },
            ),
          ),
          price()
        ], context: context)
                .toList()));
  }
}

class ChooseCity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: FlatButton(
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white, onPressed: () {},
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
              Database.myProfile['city'] = 'Казань';
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Иннополис'),
            onTap: () {
              Database.myProfile['city'] = 'Иннополис';
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Москва'),
            onTap: () {
              Database.myProfile['city'] = 'Москва';
              Navigator.pop(context);
            },
          ),
        ], context: context)
            .toList(),
      ),
    );
  }
}
