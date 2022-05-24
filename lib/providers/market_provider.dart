import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:watchlist/models/Cryptocurrency.dart';
import 'package:watchlist/models/LocalStorage.dart';
import '../models/API.dart';

class MarketProvider with ChangeNotifier {
  bool isLoading = true;
  List<CryptoCurrency> markets = [];

  MarketProvider() {
    fetchData();
  }

  void fetchData() async {
    List<dynamic> _markets = await API.getMarkets();
    List<String> watchList = await LocalStorage.fetchWatchList();

    List<CryptoCurrency> temp = [];
    for (var market in _markets) {
      CryptoCurrency newCrypto = CryptoCurrency.fromJSON(market);

      if (watchList.contains(newCrypto.id)) {
        newCrypto.isFavorite = true;
      }
      temp.add(newCrypto);
    }

    markets = temp;
    isLoading = false;
    notifyListeners();

    Timer(const Duration(seconds: 2), () {
      fetchData();
      //print("Updated" + DateTime.now().toString());
    });
  }

  CryptoCurrency fetchCryptoById(String id) {
    CryptoCurrency crypto =
        markets.where((element) => element.id == id).toList()[0];
    return crypto;
  }

  void addWatchlist(CryptoCurrency crypto) async {
    int indexofCrypto = markets.indexOf(crypto);
    markets[indexofCrypto].isFavorite = true;
    await LocalStorage.addWatchlist(crypto.id!);
    notifyListeners();
  }

  void removeWatchlist(CryptoCurrency crypto) async {
    int indexofCrypto = markets.indexOf(crypto);
    markets[indexofCrypto].isFavorite = false;
    await LocalStorage.removeWatchlist(crypto.id!);
    notifyListeners();
  }
}
