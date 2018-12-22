import 'package:flutter/material.dart';
import 'package:wan_flutter/common/CommonValue.dart';
import 'package:wan_flutter/common/SnackBarUtils.dart';
import 'package:wan_flutter/data/bean/Todo.dart';
import 'package:wan_flutter/event/Emitter.dart';
import 'package:wan_flutter/model/HttpHelper.dart';
import 'package:wan_flutter/ui/view/CommonLoadingView.dart';
import 'package:wan_flutter/ui/view/TodoItem.dart';
import 'dart:async';

class TodoFragment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TodoFragmentState();
  }
}

class TodoFragmentState extends State<TodoFragment>
    with AutomaticKeepAliveClientMixin {
  List<Todo> todoes = new List();

  int _page = 1;

  bool isLoading = true;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _refreshData();
    EventBus.on(LOGIN_EVENT, loginCallback);
    EventBus.on(REFRESH_TODO, refreshEvent);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    EventBus.off(LOGIN_EVENT, loginCallback);
    EventBus.off(REFRESH_TODO, refreshEvent);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: isLoading
          ? CommonLoadingView(Theme.of(context).primaryColor)
          : todoes.isEmpty
              ? new Center(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Icon(Icons.hourglass_empty),
                      new Padding(padding: EdgeInsets.only(bottom: d10)),
                      new Text('Empty'),
                    ],
                  ),
                )
              : new RefreshIndicator(
                  onRefresh: _refreshData,
                  child: new ListView.builder(
                    itemBuilder: (BuildContext context, int index) =>
                        new TodoItemView(todoes[index], _handleRemove),
                    itemCount: todoes.length,
                  ),
                ),
    );
  }

  Future<void> _refreshData() async {
    await HttpHelper.get(
        path: "lg/todo/v2/list/$_page/json",
        transform: (Map json) => TodoBean.fromJson(json),
        action: (todoBean) {
          if (todoBean.isSuccess()) {
            print('getTodoData : ${todoBean.data.datas}');
            setState(() {
              todoes.clear();
              todoes.addAll(todoBean.data.datas);
              isLoading = false;
            });
          } else {
            SnackBarUtils.show(context, todoBean.errorMsg);
            setState(() {
              todoes.clear();
              isLoading = false;
            });
          }
        });
  }

  _handleRemove(Todo todo) {
    setState(() {
      todoes.remove(todo);
    });
  }

  loginCallback(success) {
    if (success) {
      _refreshData();
    }
  }

  refreshEvent(success) {
    if (success) {
      _refreshData();
      SnackBarUtils.show(context, 'Save Success');
    }
  }
}
