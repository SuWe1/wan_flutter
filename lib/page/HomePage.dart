import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wan_flutter/common/PreferenceUtils.dart';
import 'package:wan_flutter/common/Router.dart';
import 'package:wan_flutter/data/UserManager.dart';
import 'package:wan_flutter/event/Emitter.dart';
import 'package:wan_flutter/fonts/IconW.dart';
import 'package:wan_flutter/page/SearchPage.dart';
import 'package:wan_flutter/ui/fragment/ProjectFragment.dart';
import 'package:wan_flutter/ui/fragment/ArticleFragment.dart';
import 'package:wan_flutter/ui/fragment/TodoFragment.dart';
import 'package:wan_flutter/common/CommonValue.dart';
import 'package:wan_flutter/ui/view/DrawerMenuItem.dart';
import 'package:wan_flutter/ui/view/TodoDialog.dart';

class _Fragment {
  const _Fragment({this.icon, this.text});

  final IconData icon;
  final String text;
}

const List<_Fragment> _allPages = <_Fragment>[
  _Fragment(icon: IconW.stream_line, text: 'Articles'),
  _Fragment(icon: IconW.discover_line, text: 'Category'),
  _Fragment(icon: IconW.market_line, text: 'Todo'),
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
    ProjectFragment(),
    TodoFragment(),
  ];
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
    //TODO 在App启动的时候从SP获取登录状态 这里并不是App初始化的时候
    UserManager().initLoginStatus();
    EventBus.on(LOGIN_EVENT, checkLoginStatus);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
    tryUpdateCookie();
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
      body: new PageView(
        physics: NeverScrollableScrollPhysics(),
        children: _pages,
        onPageChanged: onTabChanged,
        controller: _pageController,
      ),
      drawer: _buildDrawer(),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: _buildFloatingBtn(),
    );
  }

  Widget _buildDrawer() => new Drawer(
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
              label: 'Theme',
              icon: Icons.attach_file,
              onPress: gotoProject,
            ),
            new DrawerMenuItem(
              label: 'Collect',
              icon: Icons.collections,
              onPress: gotoCollect,
            ),
            new DrawerMenuItem(
              label: 'Weixin',
              icon: Icons.code,
              onPress: gotoWx,
            ),
            new DrawerMenuItem(
              label: 'Record',
              icon: Icons.change_history,
              onPress: gotoRecord,
            ),
          ],
        ),
  );

  Widget _buildBottomNavigationBar() => new BottomNavigationBar(
        onTap: onBottomTab,
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
                  style: TextStyle(fontSize: ts14, fontFamily: 'iconfont'),
                )))
            .toList(),
  );

  Widget _buildFloatingBtn() => new FloatingActionButton(
        onPressed: addTodo,
        tooltip: 'AddTodo',
        child: new Icon(Icons.add),
  );

  void onBottomTab(int index) {
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
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
    Navigator.pop(context); // Dismiss the drawer.
    Router.gotoLogin(context);
  }

  void gotoCollect() {
    Navigator.pop(context); // Dismiss the drawer.
    Router.gotoCollect(context);
  }

  void gotoWx() {
    Navigator.pop(context); // Dismiss the drawer.
    Router.gotoWx(context);
  }

  void gotoProject() {
    Navigator.pop(context); // Dismiss the drawer.
  }

  void gotoRecord() {
    Navigator.pop(context); // Dismiss the drawer.
  }

  void addTodo() {
    Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) => new TodoDialog(true),
          fullscreenDialog: true,
        ));
  }

  void _goSearchPage() {
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) {
      return new SearchPage();
    }));
  }

  void tryUpdateCookie() {
    PreferenceUtils.getStr(LAST_SAVE_TIME, (lastTime) {
      //超过三天更新cookie
      if (DateTime.parse(lastTime)
          .isAfter(DateTime.now().subtract(Duration(days: 3)))) {
        autoLogin();
      }
    });
  }

  void autoLogin() {
    PreferenceUtils.getStr(USER_NAME, (str) {
      UserManager().username = str;
      UserManager().tryAutoLogin();
    });
    PreferenceUtils.getStr(USER_PASSWORD, (str) {
      UserManager().userPass = str;
      UserManager().tryAutoLogin();
    });
  }

  checkLoginStatus(success) {
    UserManager().initLoginStatus();
  }
}
