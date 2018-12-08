import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wan_flutter/data/bean/Article.dart';
import 'package:wan_flutter/data/bean/CommonBean.dart';
import 'package:wan_flutter/model/DioUtils.dart';
import 'package:wan_flutter/ui/view/CommonListItem.dart';
import 'package:wan_flutter/ui/view/CommonLoadMore.dart';
import 'package:wan_flutter/ui/view/CommonLoadingView.dart';

class ArticleFragment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ArticleFragmentState();
  }
}

class ArticleFragmentState extends State<ArticleFragment> with AutomaticKeepAliveClientMixin{
  List<ArticleItem> articles = new List();

  int _articlePage = 0;

  bool isLoading = false;

  bool hasNextPage = true;

  Color commonColor;

  ScrollController _scrollController = new ScrollController();

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

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
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    commonColor = Theme.of(context).primaryColor;
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
