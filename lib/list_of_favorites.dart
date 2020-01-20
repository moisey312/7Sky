import 'models/firestore.dart';
class ListOfFavorites{
  List<String> favorites = Database.favorites;
  void addToFavorites(String id){
    favorites.add(id);
    Database.favorites = favorites;
  }
  void removeFromFavorites(String id){
    favorites.remove(id);
    Database.favorites = favorites;
  }

}

