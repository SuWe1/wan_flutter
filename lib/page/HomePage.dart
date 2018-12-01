import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wan_flutter/fonts/IconW.dart';
import 'package:wan_flutter/page/CollectPage.dart';
import 'package:wan_flutter/page/LgRgPage.dart';
import 'package:wan_flutter/page/SearchPage.dart';
import 'package:wan_flutter/ui/fragment/CategoryFragment.dart';
import 'package:wan_flutter/ui/fragment/ArticleFragment.dart';
import 'package:wan_flutter/ui/fragment/OtherFragment.dart';
import 'package:wan_flutter/common/CommonValue.dart';
import 'package:wan_flutter/ui/view/DrawerMenuItem.dart';

class _Fragment {
  const _Fragment({this.icon, this.text});

  final IconData icon;
  final String text;
}

const List<_Fragment> _allPages = <_Fragment>[
  _Fragment(icon: IconW.stream_line, text: 'Articles'),
  _Fragment(icon: IconW.discover_line, text: 'Category'),
  _Fragment(icon: IconW.market_line, text: 'Other'),
];

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  _Fragment _currentFragment = _allPages[0];

  List<Widget> _pages = [
    ArticleFragment(),
    CategoryFragment(),
    OtherFragment(),
  ];
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(length: _pages.length, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        actions: <Widget>[
          new IconButton(
            icon: new Icon(
              Icons.search,
              color: Color(c101),
            ),
            onPressed: _goSearchPage,
          ),
        ],
      ),
      body: new Stack(
        children: _allPages
            .map((item) => new Offstage(
                  offstage: _currentFragment != item,
                  child: _pages[_allPages.indexOf(item)],
                ))
            .toList(),
      ),
      drawer: new Drawer(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new DrawerHeader(
              child: null,
              decoration: new BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
            ),
            new DrawerMenuItem(
              label: 'Login',
              icon: Icons.person,
              onPress: gotoLogin,
            ),
            new DrawerMenuItem(
              label: 'Collect',
              icon: Icons.collections,
              onPress: gotoCollect,
            ),
            new DrawerMenuItem(
              label: 'Project',
              icon: Icons.attach_file,
              onPress: gotoProject,
            ),
            new DrawerMenuItem(
              label: 'Record',
              icon: Icons.change_history,
              onPress: gotoRecord,
            ),
          ],
        ),
      ),
      bottomNavigationBar: new BottomNavigationBar(
        onTap: onTabChanged,
        currentIndex: _allPages.indexOf(_currentFragment),
        type: BottomNavigationBarType.fixed,
        items: _allPages
            .map((item) => new BottomNavigationBarItem(
                icon: new Icon(
                  item.icon,
                  size: ts20,
                ),
                title: new Text(
                  item.text,
                  style: TextStyle(fontSize: ts14,fontFamily: 'iconfont'),
                )))
            .toList(),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: addTodo,
        tooltip: 'AddTodo',
        child: new Icon(Icons.add),
      ),
    );
  }

  void onTabChanged(int index) {
    if (_allPages.indexOf(_currentFragment) == index) {
      return;
    }
    setState(() {
      _currentFragment = _allPages[index];
    });
  }

  void gotoLogin() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) => LgRgPage()));
  }

  void gotoCollect() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => CollectPage()));
  }

  void gotoProject() {}

  void gotoRecord() {}

  void addTodo() {}

  void _goSearchPage() {
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) {
      return new SearchPage();
    }));
  }
}
