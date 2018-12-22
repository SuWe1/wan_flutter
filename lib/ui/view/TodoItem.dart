import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wan_flutter/common/CommonValue.dart';
import 'package:wan_flutter/common/SnackBarUtils.dart';
import 'package:wan_flutter/data/bean/CommonBean.dart';
import 'package:wan_flutter/data/bean/Todo.dart';
import 'package:wan_flutter/model/DioUtils.dart';
import 'package:wan_flutter/ui/view/TodoDialog.dart';

const key_select_edit = 'KEY_SELECT_EDIT';
const key_select_remove = 'KEY_SELECT_REMOVE';

typedef TodoCallback = void Function(Todo);

class TodoItemView extends StatefulWidget {
  Todo todo;

  final TodoCallback remove;

  @override
  State<StatefulWidget> createState() => TodoItemState();

  TodoItemView(this.todo, this.remove, {Key key}) : super(key: key);
}

class TodoItemState extends State<TodoItemView> {
  bool finish;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    finish = widget.todo.isFinish();
  }

  @override
  Widget build(BuildContext context) {
    return new Card(
      elevation: d02,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: new ListTile(
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
        ),
      ),
    );
  }

  popupMenuSelect(String type) {
    switch (type) {
      case key_select_edit:
        Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (BuildContext context) =>
                  new TodoDialog(false, todo: widget.todo),
              fullscreenDialog: true,
            ));
        break;
      case key_select_remove:
        showRemoveDialog();
        break;
    }
  }

  showRemoveDialog() {
    showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('Are you sure delete the todo?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('Cancle'),
              ),
              new FlatButton(
                  child: const Text('Sure'),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  })
            ],
          );
        }).then((bool value) {
      if (value != null && value) {
        _handlerRemoveTodo();
      }
    });
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
    if (bean.isSuccess()) {
      widget.remove(widget.todo);
    }
  }
}
