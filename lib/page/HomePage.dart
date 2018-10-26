import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wan_flutter/page/SearchPage.dart';
import 'package:wan_flutter/ui/fragment/CategoryFragment.dart';
import 'package:wan_flutter/ui/fragment/HomeFragment.dart';
import 'package:wan_flutter/ui/fragment/OtherFragment.dart';
import 'package:wan_flutter/common/ColorValue.dart';

var titles = ["Home", "Category", "Other"];

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Color(c101),
            ),
            onPressed: _goSearchPage,
          ),
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabChanged,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), title: Text(titles[0])),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), title: Text(titles[1])),
          BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz), title: Text(titles[2])),
        ],
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
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

  void _goSearchPage() {
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) {
      return SearchPage();
    }));
  }

  PageController _pageController = PageController();

  /*
   * 支持左右滑动的主页 不过我不喜欢这种效果
   */
  Widget _scrollMainPage() {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
      ),
      body: PageView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _children[index];
        },
        itemCount: _children.length,
        controller: _pageController,
        onPageChanged: onTabChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          _pageController.jumpToPage(index);
          onTabChanged(index);
        },
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), title: Text(titles[0])),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), title: Text(titles[1])),
          BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz), title: Text(titles[2])),
        ],
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ),
    );
  }
}
