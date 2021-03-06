import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:testproj/models/firestore.dart';

class NewProfilePage extends StatefulWidget {
  const NewProfilePage({this.userId});

  final String userId;

  @override
  createState() => new _NewProfilePage();
}

class _NewProfilePage extends State<NewProfilePage>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    controller = new TabController(length: 3, vsync: this);
    super.initState();
  }

  TabBar tabBar() {
    return TabBar(
      labelColor: Colors.black54,
      controller: controller,
      tabs: [
        new Tab(
          text: 'Инфо',
        ),
        new Tab(
          text: 'Портфолио',
        ),
        new Tab(
          text: 'Отзывы',
        )
      ],
    );
  }

  Widget tabBarView() {
    return new TabBarView(
      controller: controller,
      children: <Widget>[
        new Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Icon(Icons.phone_android,
                        color: Color.fromRGBO(255, 82, 42, 1)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'number',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 10),
                    child: Icon(
                      Icons.email,
                      color: Color.fromRGBO(255, 82, 42, 1),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, top: 10),
                    child: Text(
                      'email',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              Expanded(
                  child: GridView.count(
                physics: new NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        "Город:",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      'city',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        "Цена от:",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      'price',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              )),
            ],
          ),
        ),
        Container(
          child: Center(
              child: Text('У пользователя пока нет загруженных фотографий')),
        ),
        Container(
          child: Center(
            child: Text('Пользователю пока не оставляли отзывы'),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                            'name',
                            style: TextStyle(color: Colors.white, fontSize: 19),
                          )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'rating',
                          style: TextStyle(color: Colors.white, fontSize: 17),
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
              child: Stack(
                children: <Widget>[
                  new Container(
                      decoration: new BoxDecoration(color: Colors.white),
                      child: tabBar()),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: new Container(child: tabBarView()),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
