import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
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
    if (_currentIndex == index) {
      return;
    }
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

  PageController _pageController = new PageController();

  /*
   * 支持左右滑动的主页 不过我不喜欢这种效果
   */
  Widget _scrollMainPage() {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
      ),
      body: new PageView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _children[index];
        },
        itemCount: _children.length,
        controller: _pageController,
        onPageChanged: onTabChanged,
      ),
      bottomNavigationBar: new BottomNavigationBar(
        onTap: (int index) {
          _pageController.jumpToPage(index);
          onTabChanged(index);
        },
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
}
