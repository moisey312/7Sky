import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'models/firestore.dart';
import 'package:testproj/services/authentication.dart';
class ProfilePage extends StatefulWidget{
  const ProfilePage({Key key}) : super(key: key);
  @override
  createState() => new _ProfilePage();
}
class _ProfilePage extends State<ProfilePage> with
SingleTickerProviderStateMixin{
  TabController controller;
  @override
  void initState(){
    if(FireStoreFuns.typeId==0){
      controller = new TabController(length: 2, vsync: this);
    }else{
      controller = new TabController(length: 3, vsync: this);
    }
    super.initState();
  }
  TabBar tabBar(){
    if(FireStoreFuns.typeId==0){
      return TabBar(
        labelColor: Colors.black54,
        controller: controller,
        tabs: [
          new Tab(
            text: 'Инфо',
          ),
          new Tab(
            text: 'Мои комментарии',
          )
        ],
      );
    }
    else{
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
  }
  TabBarView tabBarView(){
    if(FireStoreFuns.typeId==0){
      return new TabBarView(
        controller: controller,
        children: <Widget>[
          new Container(
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Icon(Icons.phone_android),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(FireStoreFuns.number,
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold
                    ),),
                )
              ],
            ),
          ),
          Container(
            child: Center(
              child: Text('Вы пока не оставляли комментариев'),
            ),
          )
        ],
      );
    }else{
      return new TabBarView(
        controller: controller,
        children: <Widget>[
          new Container(
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Icon(Icons.phone_android),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(FireStoreFuns.number,
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold
                    ),),
                )
              ],
            ),
          ),
          Container(
              child: Text('У вас пока нет загруженных фотографий'),
          ),
          Container(
              child: Center(
                child: Text(
                  'Вам пока не оставляли отзывы'
                ),
              ),
          ),
        ],
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left:8, top: 8),
              child: new FlatButton(
                  child: new Text('Logout',
                      style: new TextStyle(fontSize: 17.0, color: Colors.white)),
                  onPressed: (){}),
            ),
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
                              FireStoreFuns.name,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 19),
                            )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            FireStoreFuns.rating.toString(),
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
                child: Stack(
                  children: <Widget>[
                    new Container(
                      decoration: new BoxDecoration(color: Colors.white),
                      child: tabBar()
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 50, 0,0),
                      child: new Container(
                        height: 80.0,
                        child: tabBarView()
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}