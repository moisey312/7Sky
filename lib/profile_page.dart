import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:testproj/services/authentication.dart';
class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key}) : super(key: key);

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
      body: Scrollbar(
        child: Stack(
          children: <Widget>[
            Container(
              height: 298,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/people_photo.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: new BackdropFilter(
                      filter: new ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                      child: new Container(
                        decoration: new BoxDecoration(
                            color: Color.fromRGBO(0, 13, 25, 0.75)),
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 58,
                              width: 58,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Color.fromRGBO(255, 82, 42, 1),
                                    width: 1.0),
                                image: DecorationImage(
                                  image: AssetImage("assets/people_photo.jpg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: 24,
                            child: Text(
                              'Michal Jordon',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 19),
                            )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '4.8',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17
                            ),
                          ),
                          RatingBar(
                            initialRating: 4.8,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 20,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 250, 0, 0),
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
            ),
            /*new Container(
              decoration: new BoxDecoration(color: Colors.white),
              child: new TabBar(
                controller: _controller,
                tabs: [
                  new Tab(
                    text: 'Address',
                  ),
                  new Tab(
                    text: 'Location',
                  ),
                ],
              ),
            ),
            new Container(
              height: 80.0,
              child: new TabBarView(
                controller: _controller,
                children: <Widget>[
                  new Card(
                    child: new ListTile(
                      leading: const Icon(Icons.home),
                      title: new TextField(
                        decoration: const InputDecoration(hintText: 'Search for address...'),
                      ),
                    ),
                  ),
                  new Card(
                    child: new ListTile(
                      leading: const Icon(Icons.location_on),
                      title: new Text('Latitude: 48.09342\nLongitude: 11.23403'),
                      trailing: new IconButton(icon: const Icon(Icons.my_location), onPressed: () {}),
                    ),
                  ),
                ],
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
