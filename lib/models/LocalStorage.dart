import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<bool> addWatchlist(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    List<String> watchList = sharedPreferences.getStringList("watchlist") ?? [];
    watchList.add(id);

    return await sharedPreferences.setStringList("watchlist", watchList);
  }

  static Future<bool> removeWatchlist(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    List<String> watchList = sharedPreferences.getStringList("watchlist") ?? [];
    watchList.remove(id);

    return await sharedPreferences.setStringList("watchlist", watchList);
  }

  static Future<List<String>> fetchWatchList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getStringList("watchlist") ?? [];
  }
}
