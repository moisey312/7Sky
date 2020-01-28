import 'models/firestore.dart';
class ListOfFavorites{
  List<String> favorites = Database.myProfile['favorites'];
  void addToFavorites(String id){
    favorites.add(id);
    Database.myProfile['favorites'] = favorites;
  }
  void removeFromFavorites(String id){
    favorites.remove(id);
    Database.myProfile['favorites'] = favorites;
  }

}

