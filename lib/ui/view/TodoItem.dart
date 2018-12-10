import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wan_flutter/common/SnackBarUtils.dart';
import 'package:wan_flutter/data/bean/CommonBean.dart';
import 'package:wan_flutter/data/bean/Todo.dart';
import 'package:wan_flutter/common/CommonValue.dart';
import 'package:wan_flutter/model/DioUtils.dart';

const key_select_edit = 'KEY_SELECT_EDIT';
const key_select_remove = 'KEY_SELECT_REMOVE';

typedef TodoCallback = void Function(Todo);

class TodoView extends StatefulWidget {
  Todo todo;

  final TodoCallback remove;

  @override
  State<StatefulWidget> createState() => TodoItemState();

  TodoView(this.todo, this.remove, {Key key}) : super(key: key);
}

class TodoItemState extends State<TodoView> {
  bool finish;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    finish = widget.todo.isFinish();
  }

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      leading: new PopupMenuButton(
          onSelected: popupMenuSelect,
          itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                new PopupMenuItem<String>(
                    value: key_select_edit, child: const Text('Edit')),
                new PopupMenuItem<String>(
                    value: key_select_remove, child: const Text('Remove')),
              ]),
      title: new Text(widget.todo.title),
      subtitle: new Text(
        widget.todo.content,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: new Checkbox(value: finish, onChanged: _handleCheck),
    );
  }

  popupMenuSelect(String type) {
    switch (type) {
      case key_select_edit:
        Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (BuildContext context) => new TodoDialog(widget.todo),
              fullscreenDialog: true,
            ));
        break;
      case key_select_remove:
        _handlerRemoveTodo();
        break;
    }
  }

  _handleCheck(bool value) async {
    Map<String, dynamic> json = await DioUtils.getInstance().post(
        "lg/todo/done/${widget.todo.id}/json",
        data: {
          'status': value ? 1 : 0,
        },
        options: new Options(
            contentType:
                ContentType.parse('application/x-www-form-urlencoded')));
    CommonBean bean = CommonBean.fromJson(json);
    if (bean.errorCode == 0) {
      setState(() {
        finish = value;
      });
      SnackBarUtils.show(context, 'Success');
    }
  }

  _handlerRemoveTodo() async {
    Map<String, dynamic> json = await DioUtils.getInstance().post(
        "lg/todo/delete/${widget.todo.id}/json",
        data: {},
        options: new Options(contentType: ContentType.json));
    CommonBean bean = CommonBean.fromJson(json);
    if(bean.isSuccess()){
      widget.remove(widget.todo);
    }
  }
}

class TodoDialog extends StatefulWidget {
  Todo todo;

  @override
  State<StatefulWidget> createState() => TodoDialogState();

  TodoDialog(this.todo, {Key key}) : super(key: key);
}

class TodoDialogState extends State<TodoDialog> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
      ),
      body: new Form(
        child: new ListView(
          padding: const EdgeInsets.all(10.0),
          children: <Widget>[
            new InkWell(
              onTap: () {
                DateTime data = DateTime.parse(widget.todo.dateStr);
                showDatePicker(
                    context: context,
                    initialDate: data,
                    firstDate: data.subtract(new Duration(days: 90)),
                    lastDate: data.add(new Duration(days: 90)));
              },
            )
          ],
        ),
      ),
    );
  }
}
