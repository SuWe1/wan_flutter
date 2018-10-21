import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wan_flutter/data/bean/Article.dart';
import 'package:wan_flutter/model/DioUtils.dart';
import 'package:wan_flutter/ui/view/CommonListItem.dart';
import 'package:wan_flutter/ui/view/CommonLoadMore.dart';

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

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    getArticleListData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: new RefreshIndicator(
        onRefresh: _refreshCallback,
        child: new ListView.builder(
          controller: _scrollController,
          itemBuilder: _indexedWidgetBuilder,
          itemCount: articles.length + 1,
        ),
      ),
    );
  }

  Widget _indexedWidgetBuilder(BuildContext context, int index) {
    return index == articles.length
        ? CommonLoadMore(Theme.of(context).primaryColor)
        : new CommonListItem(articles[index]);
  }

  getArticleListData() async {
    Map<String, dynamic> json =
        await DioUtils.getInstance().get("article/list/$_articlePage/json");
    Article article = Article.fromJson(json);
    setState(() {
      articles.addAll(article.data.datas);
    });
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
    });
  }
}
