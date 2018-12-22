import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wan_flutter/data/bean/Project.dart';
import 'package:wan_flutter/model/DioUtils.dart';
import 'package:wan_flutter/model/HttpHelper.dart';
import 'package:wan_flutter/ui/view/CommonLoadMore.dart';
import 'package:wan_flutter/ui/view/CommonLoadingView.dart';
import 'package:wan_flutter/ui/view/ListImageItem.dart';

class ProjectFragment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProjectFragmentState();
  }
}

class ProjectFragmentState extends State<ProjectFragment>
    with AutomaticKeepAliveClientMixin {
  List<Project> projects = new List();

  int _currentPage = 0;

  bool isLoading = false;

  bool hasNextPage = true;

  ScrollController _scrollController = new ScrollController();

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });
    refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return projects.isEmpty
        ? new CommonLoadingView(Theme.of(context).primaryColor)
        : new Container(
            child: new RefreshIndicator(
                child: new ListView.builder(
                  itemBuilder: _indexedWidgetBuilder,
                  itemCount:
                      hasNextPage ? projects.length + 1 : projects.length,
                  controller: _scrollController,
                  physics: AlwaysScrollableScrollPhysics(),
                ),
                onRefresh: refreshData),
          );
  }

  Widget _indexedWidgetBuilder(BuildContext context, int index) {
    return hasNextPage && index == projects.length
        ? CommonLoadMore(Theme.of(context).primaryColor)
        : new ListImageItem(projects[index]);
  }

  Future<void> refreshData() async {
    _currentPage = 0;
    await HttpHelper.get(
        path: 'article/listproject/$_currentPage/json',
        transform: (Map json) => ProjectBean.fromJson(json),
        action: (projectBean){
          setState(() {
            projects.clear();
            projects.addAll(projectBean.data.datas);
          });
        }
    );
  }

  loadMore() async {
    if (isLoading) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    _currentPage++;
    await HttpHelper.get(
      path: 'article/listproject/$_currentPage/json',
      transform: (Map json) => ProjectBean.fromJson(json),
      action: (projectBean){
        setState(() {
          projects.addAll(projectBean.data.datas);
          isLoading = false;
          hasNextPage = projectBean.data.total >= projects.length;
        });
      }
    );
  }
}
