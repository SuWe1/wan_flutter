import 'package:flutter/material.dart';
import 'package:wan_flutter/data/bean/Article.dart';
import 'package:wan_flutter/model/DioUtils.dart';
import 'package:wan_flutter/ui/fragment/CategoryFragment.dart';
import 'package:wan_flutter/ui/fragment/HomeFragment.dart';
import 'package:wan_flutter/ui/fragment/OtherFragment.dart';

var titles = ["Home", "Category", "Other"];

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  int _currentIndex = 0;

  List<Widget> _children = [
    HomeFragment(),
    CategoryFragment(),
    OtherFragment(),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        elevation: Theme
            .of(context)
            .platform == TargetPlatform.iOS ? 0.0 : 4.0,
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: new BottomNavigationBar(
        onTap: onTabChanged,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
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

  void onTabChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  /*
   * 通过监听手势达到滑动切换tab的效果
   * 生效具体单位为pixels 这里选150为最小滑动距离
   * 行是行 就是不太准=。=
   */
  void onHorizontalDrag(DragEndDetails details) {
    if (details.velocity.pixelsPerSecond.dy > 50) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() > 150) {
      setState(() {
        if (details.velocity.pixelsPerSecond.dx > 0) {
          _currentIndex =
          _currentIndex == _children.length - 1 ? 0 : _currentIndex + 1;
        } else {
          _currentIndex =
          _currentIndex == 0 ? _children.length - 1 : _currentIndex - 1;
        }
      });
    }
  }
}
