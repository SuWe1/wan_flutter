import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wan_flutter/data/bean/Article.dart';
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
  List<ArticleItem> articles = List();

  int _articlePage = 0;

  bool isLoading = false;

  bool hasNextPage = true;

  Color commonColor;

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    //每次重新显示view 都会走一次initState
//    print("HomeFragmentState initState()");
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
        ? CommonLoadingView(commonColor)
        : Container(
            child: RefreshIndicator(
              onRefresh: _refreshCallback,
              child: ListView.builder(
                //避免数据不足一屏时不能刷新
                physics: AlwaysScrollableScrollPhysics(),
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
        : CommonListItem(articles[index]);
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
