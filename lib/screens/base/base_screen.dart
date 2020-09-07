import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlomobx/screens/create/create_screen.dart';
import 'package:xlomobx/screens/home/home_screen.dart';
import 'package:xlomobx/stores/page_store.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  PageController pageController = PageController();

  final PageStore pageStore = GetIt.I<PageStore>();

  @override
  void initState() {
    super.initState();

    reaction((_) => pageStore.page, (page) => pageController.jumpToPage(page));
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
          Container(
            color: Colors.brown,
          ),
          Container(
            color: Colors.deepOrangeAccent,
          ),
        ],
      ),
    );
  }
}
