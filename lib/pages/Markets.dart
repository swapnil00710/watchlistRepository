import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/Widgets/CryptoListTile.dart';

import '../models/Cryptocurrency.dart';
import '../providers/market_provider.dart';
import 'DetailsPage.dart';

class Markets extends StatefulWidget {
  const Markets({Key? key}) : super(key: key);

  @override
  State<Markets> createState() => _MarketsState();
}

class _MarketsState extends State<Markets> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(builder: (context, marketProvider, child) {
      if (marketProvider.isLoading == true) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        if (marketProvider.markets.length > 0) {
          return ListView.builder(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            itemCount: marketProvider.markets.length,
            itemBuilder: (context, index) {
              CryptoCurrency currentCrypto = marketProvider.markets[index];

              return CryptoListTile(currentCrypto: currentCrypto);
            },
          );
        } else {
          return Text("data not found");
        }
      }
    });
  }
}
