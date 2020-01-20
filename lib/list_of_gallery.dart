import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'models/firestore.dart';
import 'models/storage.dart';

class ListOfGallery {
  static List<String> photographersAndStudios;
  static List<Widget> cards;
  static List<Widget> images;

  static loadInfo() async {
    Database.getPhotographerAndStudioIds();
    fillListOfCards();
  }

  static Widget getListOfGallery(var context) {
    return FutureBuilder(
        future: loadInfo(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasError) {
                debugPrint("Snapshot " + snapshot.toString());
                return new Text('Error: ${snapshot.error}');
              } else {
                debugPrint("Snapshot " + snapshot.toString());
                print(cards);
                return ListView(
                  children: cards,
                );
              }
              break;

            default:
              debugPrint("Snapshot " + snapshot.toString());
              return Text('Waiting');
          }
        });
  }

  static fillListOfCards() async {
    cards = List<Widget>();
    for (int i = 0; i < photographersAndStudios.length; i++) {
      images = List<Widget>();
      Map<String, Object> a =
          await Database.getUserProfile(photographersAndStudios[i]);
      List urls = a["portfolio_image_names"];

      for (int j = 0; j < urls.length && j < 5; j++) {
        images.add(photo(await Storage.getUrlPortfolio(
            photographersAndStudios[i], urls[j])));
      }
      cards.add(photosOrStudiosCard(
          a["name"],
          a["rating"],
          a["price"],
          photographersAndStudios[i],
          await Storage.getUrlProfileImage(photographersAndStudios[i])));
    }
    print(cards.toString() + 'cards fill');
    print(photographersAndStudios.toString() + 'ids fill');
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

  static Widget photosOrStudiosCard(String name, double rating, String price,
      String id, String profileImageUrl) {
    bool favorite = false;
    for(int i = 0; i < Database.favorites.length; i++){
      if(Database.favorites[i]==id){
        favorite = true;
      }
    }
    Color fav_col;
    if(favorite){
      fav_col = Color.fromRGBO(255, 82, 42, 1);
    }else{
      fav_col = Colors.black38;
    }
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Container(
        height: 167.0,
        decoration: BoxDecoration(
            borderRadius: new BorderRadius.circular(10.0), color: Colors.white),
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
                  padding: const EdgeInsets.fromLTRB(17, 17, 17, 0),
                  child: Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 1.0),
                        image: DecorationImage(
                            fit: BoxFit.cover, image: NetworkImage(profileImageUrl))),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                      child: Text(name),
                    ),
                    Container(
                      height: 20,
                      child: Row(
                        children: <Widget>[
                          Text(rating.toString()),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
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
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Text(price),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                  child: IconButton(
                    icon: Icon(Icons.favorite, color: fav_col),
                    onPressed: (){if(favorite){
                      fav_col = Colors.black38;
                      Database.favorites.remove(id);
                    }else{
                      fav_col = Color.fromRGBO(255, 82, 42, 1);
                      Database.favorites.add(id);
                    }
                    favorite = !favorite;
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
