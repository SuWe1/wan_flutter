import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wan_flutter/data/bean/Article.dart';
import 'package:wan_flutter/event/Emitter.dart';
import 'package:wan_flutter/model/HttpHelper.dart';
import 'package:wan_flutter/ui/view/CommonListItem.dart';
import 'package:wan_flutter/ui/view/CommonLoadMore.dart';
import 'package:wan_flutter/ui/view/CommonLoadingView.dart';

class ArticleFragment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ArticleFragmentState();
  }
}

class ArticleFragmentState extends State<ArticleFragment>
    with AutomaticKeepAliveClientMixin {
  List<Article> articles = new List();

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
    print("ArticleFragmentState initState()");
    _refreshData();
    _scrollController.addListener(_loadMoreListener);
    EventBus.on(LOGIN_EVENT, loginCallback);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    EventBus.off(LOGIN_EVENT, loginCallback);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    commonColor = Theme.of(context).primaryColor;
    return articles.isEmpty
        ? new CommonLoadingView(commonColor)
        : new Container(
            child: new RefreshIndicator(
              onRefresh: _refreshData,
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

  Future<void> _refreshData() async {
    _articlePage = 0;
    await HttpHelper.get<ArticleBean>(
        path: "article/list/$_articlePage/json",
        transform: (Map json) => ArticleBean.fromJson(json),
        action: (article) {
          setState(() {
            articles.clear();
            articles.addAll(article.data.datas);
            hasNextPage = article.data.total >= articles.length;
          });
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
    await HttpHelper.get<ArticleBean>(
        path: "article/list/$_articlePage/json",
        transform: (Map json) => ArticleBean.fromJson(json),
        action: (newData) {
          setState(() {
            articles.addAll(newData.data.datas);
            isLoading = false;
            hasNextPage = newData.data.total >= articles.length;
          });
        });
  }

  loginCallback(success) {
    if (success) {
      _refreshData();
    }
  }
}
