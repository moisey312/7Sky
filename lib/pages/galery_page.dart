import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shimmer/shimmer.dart';
import 'package:testproj/models/firestore.dart';
import 'package:testproj/models/storage.dart';
import 'package:testproj/pages/new_profile_page.dart';
import '../style.dart';
import 'package:testproj/list_of_gallery.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key key}) : super(key: key);

  @override
  createState() => new _GalleryPage();
}

class _GalleryPage extends State<GalleryPage> with WidgetsBindingObserver {
  static List<String> photographersAndStudios = new List();
  static List<Widget> cards;
  static List<Widget> images;

  loadInfo(BuildContext context) async {
    photographersAndStudios = await Database.getPhotographerAndStudioIds();
    await fillListOfCards(context);
  }
  void state(){
    setState(() {

    });
  }
  static Widget photo(String url) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 6, 0, 0),
      child: Container(
        width: 135.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(url),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget photosOrStudiosCard(BuildContext context, String name,
      double rating, String price, String id, String profileImageUrl) {
    bool favorite;
    List favorites = Database.myProfile['favorites'];
    favorites.indexOf(id) == null ? favorite = false : favorite = true;
    Color fav_col;
    if (favorite) {
      fav_col = Color.fromRGBO(255, 82, 42, 1);
    } else {
      fav_col = Colors.black38;
    }
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: InkWell(
        child: Container(
          height: 167.0,
          decoration: BoxDecoration(
              borderRadius: new BorderRadius.circular(10.0),
              color: Colors.white),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 97.0,
                child: new ListView(
                    scrollDirection: Axis.horizontal, children: images),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 5, 0),
                    child: Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 1.0),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(profileImageUrl))),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: Text(name),
                      ),
                      Container(
                        height: 20,
                        child: Row(
                          children: <Widget>[
                            Text(rating.toString()),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                  height: 20,
                                  child: RatingBar(
                                    initialRating: rating,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    ignoreGestures: true,
                                    itemCount: 5,
                                    itemSize: 20,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Text(price),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: IconButton(
                      icon: Icon(Icons.favorite, color: fav_col),
                      onPressed: () {
                        print('hello yopta');
                        setState(() {
                          favorite = !favorite;
                          List<dynamic> new_favorites = Database.myProfile['favorites'];
                          if (favorite) {
                            fav_col = Color.fromRGBO(255, 82, 42, 1);
                            new_favorites.add(id);
                          } else {
                            fav_col = Colors.black38;
                            new_favorites.remove(id);
                          }
                          print(favorite);
                          Database.myProfile['favorites'] = new_favorites;
                        });
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewProfilePage(
                        userId: id,
                      )));
        },
      ),
    );
  }
  fillListOfCards(BuildContext context) async {
    cards = List<Widget>();
    for (int i = 0; i < photographersAndStudios.length; i++) {
      images = List<Widget>();
      Map<String, Object> a =
          await Database.getUserProfile(photographersAndStudios[i]);
      List urls = a["portfolio_image_names"];
      if (urls.length == 0) {
        continue;
      }

      for (int j = 0; j < urls.length && j < 5; j++) {
        images.add(photo(await Storage.getUrlPortfolio(
            photographersAndStudios[i], urls[j])));
      }
      cards.add(photosOrStudiosCard(
          context,
          a["name"],
          a["rating"],
          a["price"],
          photographersAndStudios[i],
          await Storage.getUrlProfileImage(photographersAndStudios[i])));
    }
    print(cards.toString() + 'cards fill');
    print(photographersAndStudios.toString() + 'ids fill');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: AppBar(
            actions: <Widget>[

            ],
            title: Center(
                child: Text(
              "Галерея",
              style: TextStyle(fontSize: 17),
            )),
          ),
        ),
        body: cards == null
            ? FutureBuilder(
                future: loadInfo(context),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        debugPrint("Snapshot " + snapshot.toString());
                        return new Text('Error: ${snapshot.error}');
                      } else {
                        debugPrint("Snapshot " + snapshot.toString());
                        print(cards);
                        return RefreshIndicator(
                          child: ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            children: cards,
                          ),
                          onRefresh: () {
                            setState(() {
                              cards = null;
                            });
                          },
                        );
                      }
                      break;

                    default:
                      debugPrint("Snapshot " + snapshot.toString());
                      return Shimmer.fromColors(
                          child: Container(
                            height: 167.0,
                            decoration: BoxDecoration(
                                borderRadius: new BorderRadius.circular(10.0),
                                color: Colors.white),
                          ),
                          baseColor: Colors.black26,
                          highlightColor: Colors.white);
                  }
                })
            : RefreshIndicator(
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: cards,
                ),
                onRefresh: () {
                  setState(() {
                    cards = null;
                  });
                },
              ));
  }
}
