import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/models/Cryptocurrency.dart';
import 'package:watchlist/providers/market_provider.dart';
import 'package:watchlist/providers/theme_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.only(top: 20, left: 20, bottom: 0, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // ignore: prefer_const_constructors
            Text(
              "Crypto Today",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),

            IconButton(
                onPressed: () {
                  themeProvider.toggleTheme();
                },
                padding: EdgeInsets.all(0),
                icon: (themeProvider.themeMode == ThemeMode.light)
                    ? Icon(Icons.dark_mode)
                    : (Icon(Icons.light_mode))),

            //SizedBox(height: 20),

            Expanded(child: Consumer<MarketProvider>(
                builder: (context, marketProvider, child) {
              if (marketProvider.isLoading == true) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (marketProvider.markets.length > 0) {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    itemCount: marketProvider.markets.length,
                    itemBuilder: (context, index) {
                      CryptoCurrency currentCrypto =
                          marketProvider.markets[index];

                      return ListTile(
                        contentPadding: EdgeInsets.all(0),
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(currentCrypto.image!),
                        ),
                        title: Text(currentCrypto.name!),
                        subtitle: Text(currentCrypto.symbol!.toUpperCase()),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "₹ " +
                                  currentCrypto.currentPrice!
                                      .toStringAsFixed(4),
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Builder(
                              builder: (context) {
                                double priceChange =
                                    currentCrypto.priceChange24!;
                                double priceChangePercent =
                                    currentCrypto.priceChangePercent24!;

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
                    },
                  );
                } else {
                  return Text("data not found");
                }
              }
            })),
          ],
        ),
      )),
    );
  }
}
