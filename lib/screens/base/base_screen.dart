import 'package:flutter/material.dart';
import 'package:xlomobx/screens/home/home_screen.dart';
import 'package:xlomobx/stores/page_store.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  PageController pageController = PageController();

  final PageStore pageStore = PageStore();

  @override
  void initState() {
    super.initState();
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
          Container(
            color: Colors.black,
          ),
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
