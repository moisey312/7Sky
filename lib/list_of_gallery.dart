import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
class ListOfGallery {
  static List<String> PhotographersAndStudios = [];
  Widget photographer_or_studio(String name, double rating, String prise){
    return Container(
      height: 167.0,
      decoration: BoxDecoration(
          borderRadius: new BorderRadius.circular(10.0),
          color: Colors.white),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 97.0,
            child: new ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 6, 0, 0),
                  child: Container(
                    width: 135.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/examples_photos/example_1.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(6, 6, 0, 0),
                  child: Container(
                    width: 135.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/examples_photos/example_2.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(6, 6, 0, 0),
                  child: Container(
                    width: 135.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/examples_photos/example_3.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(6, 6, 0, 0),
                  child: Container(
                    width: 135.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/examples_photos/example_4.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(6, 6, 10, 0),
                  child: Container(
                    width: 135.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/examples_photos/example_5.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
                      border:
                      Border.all(color: Colors.black, width: 1.0),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image:
                          AssetImage("assets/people_photo.jpg"))),
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
                        Text('4.8'),
                        Container(
                          height: 20,
                          child: RatingBar(
                            initialRating: rating,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
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
                        Padding(
                          padding:
                          const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(prise),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                child: IconButton(
                  icon: Icon(Icons.favorite),
                  onPressed: () {},
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
