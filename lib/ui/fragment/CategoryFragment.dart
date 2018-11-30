import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wan_flutter/data/bean/Article.dart';
import 'package:wan_flutter/model/DioUtils.dart';
import 'package:wan_flutter/data/bean/WxBean.dart';
import 'package:wan_flutter/ui/view/CommonListItem.dart';

class CategoryFragment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CategoryFragmentState();
  }
}

class CategoryFragmentState extends State<CategoryFragment>
    with SingleTickerProviderStateMixin {
  List<WxTabItem> _pages = [];

  TabController _tabController;

  int _currentPage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("CategoryFragmentState initState()");
    _tabController = TabController(length: _pages.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentPage = _tabController.index;
      });
    });
    _currentPage = 0;
//    _getWXArticleTabs();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: new Text('content')
    );
    return new Scaffold(
      appBar: new AppBar(
        bottom: TabBar(
          tabs: _pages.map(
            (item) {
              return new Tab(
                text: item.name,
              );
            },
          ).toList(),
          labelColor: Colors.black,
          indicatorColor: Colors.black,
          indicator: UnderlineTabIndicator(),
          controller: _tabController,
          isScrollable: true,
        ),
      ),
      body: new TabBarView(
        children: _pages
            .map((item) => new Container(
                  child: new CategoryTabView(item.id),
                ))
            .toList(),
        controller: _tabController,
      ),
    );
  }

  _getWXArticleTabs() async {
    Map<String, dynamic> json =
        await DioUtils.getInstance().get('wxarticle/chapters/json');
    WxTabs wxTabs = WxTabs.fromJson(json);
    setState(() {
      _pages.clear();
      _pages.addAll(wxTabs.data);
    });
  }
}

class CategoryTabView extends StatefulWidget {
  CategoryTabView(this._categoryId);

  final int _categoryId;
  int _page;

  @override
  State<StatefulWidget> createState() => new CategoryTabViewState();
}

class CategoryTabViewState extends State<CategoryTabView> {
  List<ArticleItem> articles = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshListNetData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new RefreshIndicator(
      onRefresh: _refreshListNetData,
      child: new ListView.builder(
        //避免数据不足一屏时不能刷新
        physics: new AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return new CommonListItem(articles[index]);
        },
        itemCount: articles.length,
      ),
    );
  }

  Future<void> _refreshListNetData() async {
    Map<String, String> json = await DioUtils.getInstance()
        .get('wxarticle/list/${widget._categoryId}/${widget._page}/json');
    Article article = Article.fromJson(json);
    setState(() {
      articles.clear();
      articles.addAll(article.data.datas);
    });
  }
}
