import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wan_flutter/model/DioUtils.dart';
import 'package:wan_flutter/data/bean/Article.dart';
import 'package:wan_flutter/ui/view/CommonListItem.dart';
import 'package:wan_flutter/ui/view/CommonLoadMore.dart';
import 'package:wan_flutter/ui/view/CommonLoadingView.dart';
import 'package:wan_flutter/common/PreferenceUtils.dart';
import 'package:wan_flutter/common/PreferenceUtils.dart';

class CollectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new CollectPageState();
}

class CollectPageState extends State<CollectPage> {
  List<Article> collects = new List();

  int collectPage = 0;
  bool isLogin = false;
  bool isLoading = false;
  bool hasNextPage = true;

  Color commonColor;

  ScrollController _scrollController = new ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    hasLogin();
    print("CollectPageState initState()");
    print(isLogin);
    // _scrollController
  }

  @override
  Widget build(BuildContext context) {
    commonColor = Theme.of(context).primaryColor;
    print(isLogin);
    // if(isLogin) {
    //   return collects.isEmpty
    //     ? new CommonLoadingView(commonColor)
    //     : new Container(
    //         child: new RefreshIndicator(
    //           onRefresh: _refreshCallback,
    //           child: new ListView.builder(
    //             //避免数据不足一屏时不能刷新
    //             physics: new AlwaysScrollableScrollPhysics(),
    //             controller: _scrollController,
    //             itemBuilder: _indexedWidgetBuilder,
    //             itemCount: hasNextPage ? collects.length + 1 : collects.length,
    //           ),
    //         ),
    //       );
    // } else {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Collect'),
      ),
      body: new Center(
          child: new Row(children: [
        new Row(children: [new Text('登录查看收藏内容')]),
        new Text(
          'wewe',
          style: new TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        )
      ])),
    );
    // }
  }

  Widget _indexedWidgetBuilder(BuildContext context, int index) {
    return hasNextPage && index == collects.length
        ? CommonLoadMore(commonColor)
        : new CommonListItem(collects[index]);
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

  Future<void> _refreshCallback() async {
    collectPage = 0;
    Map<String, dynamic> json =
        await DioUtils.getInstance().get("article/list/$collectPage/json");
    ArticleBean collect = ArticleBean.fromJson(json);
    setState(() {
      collects.clear();
      collects.addAll(collect.data.datas);
    });
  }

  Future<void> hasLogin() async {
    await PreferenceUtils.getBool(USER_IS_LOGIN, (value) {
      print(value);
      isLogin = value ? true : false;
    });
  }
}
