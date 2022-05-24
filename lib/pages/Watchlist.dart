import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/Widgets/CryptoListTile.dart';
import 'package:watchlist/models/Cryptocurrency.dart';
import 'package:watchlist/providers/market_provider.dart';

class Watchlist extends StatefulWidget {
  const Watchlist({Key? key}) : super(key: key);

  @override
  State<Watchlist> createState() => _WatchlistState();
}

class _WatchlistState extends State<Watchlist> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(
      builder: (context, marketProvider, child) {
        List<CryptoCurrency> watchlist = marketProvider.markets
            .where((element) => element.isFavorite == true)
            .toList();

        if (watchlist.length > 0) {
          return ListView.builder(
            itemCount: watchlist.length,
            itemBuilder: (context, index) {
              CryptoCurrency currentCrypto = watchlist[index];
              return CryptoListTile(currentCrypto: currentCrypto);
            },
          );
        } else {
          return Center(
            child: Text(
              "No Records Yet",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
          );
        }
      },
    );
  }
}
