import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/models/Cryptocurrency.dart';
import 'package:watchlist/providers/market_provider.dart';

import '../pages/DetailsPage.dart';

class CryptoListTile extends StatelessWidget {
  final CryptoCurrency currentCrypto;

  const CryptoListTile({Key? key, required this.currentCrypto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MarketProvider marketProvider =
        Provider.of<MarketProvider>(context, listen: false);
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailsPage(
                    id: currentCrypto.id!,
                  )),
        );
      },
      contentPadding: EdgeInsets.all(0),
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(currentCrypto.image!),
      ),
      title: Row(
        children: [
          Flexible(
              child: Text(
            currentCrypto.name!,
            overflow: TextOverflow.ellipsis,
          )),
          SizedBox(
            width: 10,
          ),
          (currentCrypto.isFavorite == false)
              ? GestureDetector(
                  onTap: () {
                    marketProvider.addWatchlist(currentCrypto);
                  },
                  child: Icon(
                    CupertinoIcons.eye,
                    size: 15,
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    marketProvider.removeWatchlist(currentCrypto);
                  },
                  child: Icon(
                    CupertinoIcons.eye_fill,
                    size: 15,
                  )),
        ],
      ),
      subtitle: Text(currentCrypto.symbol!.toUpperCase()),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "₹ " + currentCrypto.currentPrice!.toStringAsFixed(4),
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Builder(
            builder: (context) {
              double priceChange = currentCrypto.priceChange24!;
              double priceChangePercent = currentCrypto.priceChangePercent24!;

              if (priceChange < 0) {
                //negative
                return Text(
                  "${priceChangePercent.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(4)})",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                );
              } else {
                //positive
                return Text(
                  "+${priceChangePercent.toStringAsFixed(2)}% (+${priceChange.toStringAsFixed(4)})",
                  style: TextStyle(
                    color: Colors.green,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
