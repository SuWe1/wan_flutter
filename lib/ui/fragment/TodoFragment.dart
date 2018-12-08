import 'package:flutter/material.dart';
import 'package:wan_flutter/common/CommonValue.dart';
import 'package:wan_flutter/common/SnackBarUtils.dart';
import 'package:wan_flutter/data/bean/Todo.dart';
import 'package:wan_flutter/model/DioUtils.dart';
import 'package:wan_flutter/ui/view/TodoItem.dart';
import 'dart:async';

class TodoFragment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TodoFragmentState();
  }
}

class TodoFragmentState extends State<TodoFragment> with AutomaticKeepAliveClientMixin{
  List<Todo> todoes = new List();

  int _page = 1;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    getTodoData();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new RefreshIndicator(
        onRefresh: _refresh,
        child: new ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              new TodoView(todoes[index]),
          itemCount: todoes.length,
        ),
      ),
    );
  }

  Future<void> getTodoData() async {
    Map<String, dynamic> json =
        await DioUtils.getInstance().get("lg/todo/v2/list/$_page/json");
    TodoBean todoBean = TodoBean.fromJson(json);
    if(todoBean.errorCode == 0){
      print('getTodoData : ${todoBean.data.datas}');
      setState(() {
        todoes.clear();
        todoes.addAll(todoBean.data.datas);
      });
    } else {
      SnackBarUtils .show(context, todoBean.errorMsg);
    }
  }

  Future<void> _refresh() async {
    await getTodoData();
  }
}
