import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wan_flutter/data/bean/Article.dart';
import 'package:wan_flutter/model/DioUtils.dart';
import 'package:wan_flutter/data/bean/WxBean.dart';
import 'package:wan_flutter/ui/view/CommonListItem.dart';
import 'package:wan_flutter/ui/view/CommonLoadingView.dart';

class WxPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WxPageState();
  }
}

class WxPageState extends State<WxPage> with SingleTickerProviderStateMixin {
  List<WxTabItem> _pages = new List();

  TabController _tabController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    print("CategoryFragmentState initState()");
    _tabController = TabController(length: _pages.length, vsync: this);
    _tabController.addListener((){
      _currentPage = _tabController.index;
    });
    _getWXArticleTabs();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('WeChart'),
        bottom: new TabBar(
          tabs: _pages.map(
            (item) {
              return new Tab(
                text: item.name,
              );
            },
          )?.toList(),
          indicator: UnderlineTabIndicator(),
          controller: _tabController,
          isScrollable: true,
        ),
      ),
      body: new TabBarView(
        children: _pages
            .map((item) => new Container(
                  child: new WxTabView(item.id, true),
                ))
            ?.toList(),
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

class WxTabView extends StatefulWidget {
  WxTabView(this._categoryId, this.keepAlive);

  final int _categoryId;
  final bool keepAlive;
  int _page = 0;

  @override
  State<StatefulWidget> createState() => new WxTabViewState();
}

class WxTabViewState extends State<WxTabView>
    with AutomaticKeepAliveClientMixin {
  List<Article> articles = new List();

  @override
  void initState() {
    super.initState();
    _refreshListNetData();
  }

  // TODO: implement wantKeepAlive
  @override
  bool get wantKeepAlive => widget.keepAlive;

  @override
  Widget build(BuildContext context) {
    return articles.isEmpty
        ? new CommonLoadingView(Theme.of(context).primaryColor)
        : new RefreshIndicator(
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
    ArticleBean article = ArticleBean.fromJson(json);
    setState(() {
      articles.clear();
      articles.addAll(article.data.datas);
    });
  }
}
