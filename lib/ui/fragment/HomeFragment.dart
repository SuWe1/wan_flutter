import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wan_flutter/data/bean/Article.dart';
import 'package:wan_flutter/data/bean/CommonBean.dart';
import 'package:wan_flutter/model/DioUtils.dart';
import 'package:wan_flutter/ui/view/CommonListItem.dart';
import 'package:wan_flutter/ui/view/CommonLoadMore.dart';
import 'package:wan_flutter/ui/view/CommonLoadingView.dart';

class HomeFragment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeFragmentState();
  }
}

class HomeFragmentState extends State<HomeFragment> {
  List<ArticleItem> articles = new List();

  int _articlePage = 0;

  bool isLoading = false;

  bool hasNextPage = true;

  Color commonColor;

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    //每次重新显示view 都会走一次initState
    print("HomeFragmentState initState()");
    _refreshCallback();
    _scrollController.addListener(_loadMoreListener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    commonColor = Theme.of(context).primaryColor;
    // TODO: implement build
    return articles.isEmpty
        ? new CommonLoadingView(commonColor)
        : new Container(
            child: new RefreshIndicator(
              onRefresh: _refreshCallback,
              child: new ListView.builder(
                //避免数据不足一屏时不能刷新
                physics: new AlwaysScrollableScrollPhysics(),
                controller: _scrollController,
                itemBuilder: _indexedWidgetBuilder,
                itemCount: hasNextPage ? articles.length + 1 : articles.length,
              ),
            ),
          );
  }

  Widget _indexedWidgetBuilder(BuildContext context, int index) {
    return hasNextPage && index == articles.length
        ? CommonLoadMore(commonColor)
        : new CommonListItem(articles[index]);
    //右滑删除
//    new Dismissible(
//      key: ObjectKey(articles[index]),
//      onDismissed: (direction) {
//        _collectArticle(articles[index].id);
//      },
//      background: new Container(
//        color: Theme.of(context).primaryColor,
//        child: Text(
//          "Collect this Article",
//          style: TextStyle(color: Colors.white),
//        ),
//      ),
//      child: CommonListItem(articles[index]),
//    );
  }

  _loadMoreListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMore();
    }
  }

  Future<void> _refreshCallback() async {
    _articlePage = 0;
    Map<String, dynamic> json =
        await DioUtils.getInstance().get("article/list/$_articlePage/json");
    Article article = Article.fromJson(json);
    setState(() {
      articles.clear();
      articles.addAll(article.data.datas);
    });
  }

  Future<void> _collectArticle(int id) async {
    Map<String, dynamic> json =
        await DioUtils.getInstance().post("lg/uncollect_originId/$id/json");
    CommonBean commonBean = CommonBean.fromJson(json);
    bool successful = commonBean.errorCode == 0;
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text(successful ? 'Collect Success' : 'Collect Fail'),
    ));
  }

  void _loadMore() async {
    if (isLoading) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    _articlePage++;
    Map<String, dynamic> json =
        await DioUtils.getInstance().get("article/list/$_articlePage/json");
    Article newData = Article.fromJson(json);
    setState(() {
      articles.addAll(newData.data.datas);
      isLoading = false;
      hasNextPage = newData.data.total >= articles.length;
    });
  }
}
