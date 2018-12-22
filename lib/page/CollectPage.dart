import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wan_flutter/common/CommonValue.dart';
import 'package:wan_flutter/data/UserManager.dart';
import 'package:wan_flutter/data/bean/Collect.dart';
import 'package:wan_flutter/data/bean/CommonBean.dart';
import 'package:wan_flutter/data/bean/Article.dart';
import 'package:wan_flutter/model/HttpHelper.dart';
import 'package:wan_flutter/ui/view/CommonListItem.dart';
import 'package:wan_flutter/ui/view/CommonLoadMore.dart';
import 'package:wan_flutter/ui/view/CommonLoadingView.dart';

class CollectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new CollectPageState();
}

class CollectPageState extends State<CollectPage> {
  List<Collect> collects = new List();

  int collectPage = 0;
  bool isLogin = false;
  bool isLoading = false;
  bool hasNextPage = true;

  ScrollController _scrollController = new ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print("CollectPageState initState()");
    _scrollController.addListener(_loadMoreListener);
    isLogin = UserManager().isLogin;
    if (isLogin) {
      _refreshData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Collect'),
      ),
      body: !isLogin
          ? new Center(
              child: new Text('Please login first'),
            )
          : collects.isEmpty
              ? new CommonLoadingView(Theme.of(context).primaryColor)
              : new Container(
                  child: new RefreshIndicator(
                    onRefresh: _refreshData,
                    child: new ListView.builder(
                      //避免数据不足一屏时不能刷新
                      physics: new AlwaysScrollableScrollPhysics(),
                      controller: _scrollController,
                      itemBuilder: _indexedWidgetBuilder,
                      itemCount:
                          hasNextPage ? collects.length + 1 : collects.length,
                    ),
                  ),
                ),
    );
    // }
  }

  Widget _indexedWidgetBuilder(BuildContext context, int index) {
    return hasNextPage && index == collects.length
        ? CommonLoadMore(Theme.of(context).primaryColor)
        //右滑删除
        : new Dismissible(
            key: ObjectKey(collects[index].id),
            onDismissed: (direction) {
              _cancelCollect(
                  index, collects[index].id, collects[index].originId);
            },
            background: new Container(
              padding: EdgeInsets.symmetric(horizontal: d10),
              color: Theme.of(context).primaryColor,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Delete Collect",
                  style: TextStyle(color: Colors.white, fontSize: d16),
                ),
              ),
            ),
            child: CommonListItem(Article.fromCollect(collects[index])),
          );
  }

  _loadMoreListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMore();
    }
  }

  Future<void> _refreshData() async {
    collectPage = 0;
    HttpHelper.get(
        path: 'lg/collect/list/$collectPage/json',
        transform: (Map json) => CollectBean.fromJson(json),
        action: (collect) {
          setState(() {
            collects.clear();
            collects.addAll(collect.data.datas);
            hasNextPage = collect.data.total >= collects.length;
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
    collectPage++;
    await HttpHelper.get<CollectBean>(
        path: 'lg/collect/list/$collectPage/json',
        transform: (Map json) => CollectBean.fromJson(json),
        action: (newData) {
          setState(() {
            collects.addAll(newData.data.datas);
            isLoading = false;
            hasNextPage = newData.data.total >= collects.length;
          });
        });
  }

  void _cancelCollect(index, id, originId) async {
    await HttpHelper.post<CommonBean>(
        path: 'lg/uncollect/$id/json',
        data: {'originId': originId},
        transform: (Map json) => CommonBean.fromJson(json),
        action: (result) {
          if (result.errorCode == 0) {
            collects.removeAt(index);
          }
        });
  }
}
