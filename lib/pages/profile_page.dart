import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shimmer/shimmer.dart';
import 'package:testproj/pages/root_page.dart';
import '../choose_photo_for_portfolio.dart';
import '../models/firestore.dart';
import 'package:testproj/services/authentication.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:multi_image_picker/src/asset.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  createState() => new _ProfilePage();
}

class _ProfilePage extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  TabController controller;
  List<Asset> images = List<Asset>();

  void _popupDialog(BuildContext context, int index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Удалить?'),
            content: Text('Удалить выбранную фотографию?'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Нет')),
              FlatButton(
                  onPressed: () {
                    setState(() {
                      images.removeAt(index);
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text('Да')),
            ],
          );
        });
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      padding: EdgeInsets.all(1),
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return InkWell(
          child: Container(
            child: AssetThumb(
              asset: asset,
              width: 300,
              height: 300,
            ),
          ),
          onTap: () {
            _popupDialog(context, index);
          },
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      for (int i = 0; i < resultList.length; i++) {
        images.add(resultList[i]);
      }
    });
  }

  @override
  void initState() {
    if (Database.myProfile['typeId'] == 0) {
      controller = new TabController(
        length: 2,
        vsync: this,
      );
    } else {
      controller = new TabController(length: 3, vsync: this);
    }
    controller.animateTo(0, duration: Duration(milliseconds: 0));
    super.initState();
  }

  TabBar tabBar() {
    if (Database.myProfile['typeId'] == 0) {
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
    } else {
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

  Widget tabBarView() {
    if (Database.myProfile['typeId'] == 0) {
      return TabBarView(
        controller: controller,
        children: <Widget>[
          new Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 16, top: 10),
                      child: Icon(Icons.phone_android,
                          color: Color.fromRGBO(255, 82, 42, 1)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, top: 10),
                      child: Text(
                        Database.myProfile['number'],
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
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
                        Database.myProfile['email'],
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
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
                        Database.myProfile['city'],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    )
                  ],
                )),
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
    } else {
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
                        Database.myProfile['number'],
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
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
                        Database.myProfile['email'],
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                Row(children: <Widget>[
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
                      Database.myProfile['city'],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ]),
                Row(
                  children: <Widget>[
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
                        Database.myProfile['price'],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: Stack(children: <Widget>[
              images == []
                  ? Padding(
                      padding: const EdgeInsets.only(top: 42),
                      child: Align(
                        child: Text(
                          'Загрузите ваши фотографии',
                        ),
                        alignment: Alignment.topCenter,
                      ),
                    )
                  : buildGridView(),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      onPressed: () {
                        loadAssets();
                      },
                      child: Icon(Icons.add),
                      backgroundColor: Color.fromRGBO(255, 82, 42, 1),
                    )),
              )
            ]),
          ),
          Container(
            child: Center(
              child: Text('Вам пока не оставляли отзывы'),
            ),
          ),
        ],
      );
    }
  }

  Widget all() {
    return Stack(
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
                    padding: const EdgeInsets.all(10.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                          icon: Icon(
                            Icons.exit_to_app,
                            size: 40,
                          ),
                          // ignore: unnecessary_statements
                          color: Colors.white,
                          onPressed: () {
                            Auth().signOut();
                            Navigator.pop(context);
                            var push = Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        new RootPage(auth: Auth())));
                          }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
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
                          Database.myProfile['name'],
                          style: TextStyle(color: Colors.white, fontSize: 19),
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        Database.myProfile['rating'].toString(),
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                      RatingBar(
                        initialRating: Database.myProfile['rating'],
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        ignoreGestures: true,
                        itemCount: 5,
                        itemSize: 25,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Database.myProfile.containsKey('name')?all():FutureBuilder<bool>(
        future: Database.getMyProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return all();
          } else {
            return Shimmer.fromColors(
                child: Container(
                  height: 298,
                ),
                baseColor: Colors.black26,
                highlightColor: Colors.white);
          }
        },
      ),
    );
  }
}
