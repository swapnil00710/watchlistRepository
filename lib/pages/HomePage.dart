import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/models/Cryptocurrency.dart';
import 'package:watchlist/pages/Account.dart';
import 'package:watchlist/pages/DetailsPage.dart';
import 'package:watchlist/pages/Markets.dart';
import 'package:watchlist/pages/Orders.dart';
import 'package:watchlist/pages/Portfolio.dart';
import 'package:watchlist/pages/Watchlist.dart';
import 'package:watchlist/providers/market_provider.dart';
import 'package:watchlist/providers/theme_provider.dart';

import 'MainPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

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
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(child: const _searchField()
                  // child: Center(
                  //   child: SizedBox(
                  //     height: 40,
                  //     child: TextField(
                  //       decoration: InputDecoration(
                  //           contentPadding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                  //           hintStyle: TextStyle(color: Colors.grey[500]),
                  //           hintText: "Search",
                  //           prefix: Icon(Icons.search),
                  //           fillColor: Colors.grey[800],
                  //           filled: true,
                  //           border: OutlineInputBorder(
                  //               borderSide: BorderSide(
                  //                 width: 0,
                  //                 style: BorderStyle.none,
                  //               ),
                  //               borderRadius:
                  //                   BorderRadius.all(Radius.circular(16)))),
                  //     ),
                  //   ),
                  // ),
                  ),
            ),

            TabBar(
              controller: tabController,
              tabs: [
                Tab(
                  child: Text("Markets",
                      style: Theme.of(context).textTheme.bodyText1),
                ),
                Tab(
                  child: Text("Watchlist",
                      style: Theme.of(context).textTheme.bodyText1),
                ),
              ],
            ),

            Expanded(
              child: TabBarView(
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                controller: tabController,
                children: [
                  Markets(),
                  Watchlist(),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class _searchField extends StatelessWidget {
  const _searchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: Colors.white.withOpacity(0.5),
              width: 1,
            )),
        child: Row(
          children: [
            const SizedBox(width: 8.0),
            Icon(
              Icons.search,
              color: Colors.white.withOpacity(0.5),
            ),
            const SizedBox(width: 8.0),
            Expanded(
                child: TextField(
              controller: TextEditingController(),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search",
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ))
          ],
        ),
      ),
    );
  }
}
