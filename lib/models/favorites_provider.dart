import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider with ChangeNotifier {
  List<String> _favorites = [];

  List<String> get favorites => _favorites;

  void addFavorite(String joke) {
    if (!_favorites.contains(joke)) {
      _favorites.add(joke);
      notifyListeners();
    }
  }

  void removeFavorite(String joke) {
    _favorites.remove(joke);
    notifyListeners();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    _favorites = prefs.getStringList("favorites") ?? [];
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("favorites", _favorites);
  }
}