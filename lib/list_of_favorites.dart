import 'package:flutter/material.dart';
import 'models/firestore.dart';
class ListOfFavorites{
  List<String> favorites = FireStoreFuns.favorites;
  void add_to_favorites(String id){
    favorites.add(id);
    FireStoreFuns.favorites = favorites;
  }
  void remove_from_favorites(String id){
    favorites.remove(id);
    FireStoreFuns.favorites = favorites;
  }

}

