import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlomobx/screens/account/account_screen.dart';
import 'package:xlomobx/screens/create/create_screen.dart';
import 'package:xlomobx/screens/favorites/favorites_screen.dart';
import 'package:xlomobx/screens/home/home_screen.dart';
import 'package:xlomobx/screens/offline/offline_screen.dart';
import 'package:xlomobx/stores/connectivity_store.dart';
import 'package:xlomobx/stores/page_store.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  PageController pageController = PageController();

  final PageStore pageStore = GetIt.I<PageStore>();

  final ConnectivityStore connectivityStore = GetIt.I<ConnectivityStore>();

  @override
  void initState() {
    super.initState();

    reaction((_) => pageStore.page, (page) => pageController.jumpToPage(page));

    autorun((_) {
      if (!connectivityStore.connected) {
        Future.delayed(
            Duration(milliseconds: 5),
            () => {
                  showDialog(context: context, builder: (_) => OfflineScreen())
                });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          //Container(color: Colors.amber, child: RaisedButton( child:Text("Jump tpo page 2"), onPressed: () {pageController.jumpTo(1);},),),
          HomeScreen(),
          CreateScreen(),
          Container(
            color: Colors.blue,
          ),
          FavoritesScreen(),
          AccountScreen(),
        ],
      ),
    );
  }
}
