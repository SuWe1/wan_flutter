import 'package:flutter/material.dart';
import 'package:wan_flutter/fragment/CategoryFragment.dart';
import 'package:wan_flutter/fragment/HomeFragment.dart';
import 'package:wan_flutter/fragment/OtherFragment.dart';

var titles = ["Home", "Category", "Other"];

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeFragment(),
    CategoryFragment(),
    OtherFragment(),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: new BottomNavigationBar(
        onTap: onTabChanged,
        currentIndex: _currentIndex,
        items: [
          new BottomNavigationBarItem(
              icon: new Icon(Icons.home), title: new Text(titles[0])),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.category), title: new Text(titles[1])),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.more_horiz), title: new Text(titles[2])),
        ],
      ),
//      floatingActionButton: new FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: new Icon(Icons.add),
//      ),
    );
  }

  void onTabChanged(int index){
    setState(() {
      _currentIndex = index;
    });
  }

}
