import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
class Review extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 240, 240, 1),
      appBar: AppBar(
        title: Text('Отзыв'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: RatingBar(
              initialRating: 4.8,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 20,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) =>
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              fillColor: Colors.white,
              focusColor: Colors.white,
              hoverColor: Colors.white
            ),
          )

        ],
      ),
    );
  }
}