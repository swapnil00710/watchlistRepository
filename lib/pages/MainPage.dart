import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/pages/Account.dart';
import 'package:watchlist/pages/Orders.dart';
import 'package:watchlist/pages/Portfolio.dart';
import 'package:watchlist/providers/theme_provider.dart';

import 'HomePage.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List _pages = [
    HomePage(),
    Orders(),
    Portfolio(),
    Account(),
  ];

  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.black,
      body: _pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTap,
        currentIndex: currentIndex,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        elevation: 0,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        items: [
          BottomNavigationBarItem(label: "Market", icon: Icon(Icons.apps)),
          BottomNavigationBarItem(label: "Orders", icon: Icon(Icons.bar_chart)),
          BottomNavigationBarItem(
              label: "Portfolio", icon: Icon(Icons.luggage)),
          BottomNavigationBarItem(label: "Account", icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}
