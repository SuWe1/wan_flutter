import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wan_flutter/common/Router.dart';
import 'package:wan_flutter/common/SnackBarUtils.dart';
import 'package:wan_flutter/data/bean/CommonBean.dart';
import 'package:wan_flutter/data/bean/Todo.dart';
import 'package:wan_flutter/common/CommonValue.dart';
import 'package:wan_flutter/event/Emitter.dart';
import 'package:wan_flutter/model/DioUtils.dart';

class TodoDialog extends StatefulWidget {
  Todo todo;
  final bool isAddTodo;

  @override
  State<StatefulWidget> createState() => TodoDialogState();

  TodoDialog(this.isAddTodo, {this.todo, Key key}) : super(key: key);
}

class TodoDialogState extends State<TodoDialog> {
  String title;
  String content;
  String dateTime;
  final TextEditingController _titleEditController =
  new TextEditingController();
  final TextEditingController _contentEditController =
  new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.todo != null) {
      title = widget.todo.title;
      content = widget.todo.content;
      dateTime = widget.todo.dateStr;
      _titleEditController.text = title;
      _contentEditController.text = content;
    } else {
      dateTime = DateTime.now().toString().substring(0, 10);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text(widget.isAddTodo ? 'Add Todo' : 'Edit Todo'),
        actions: <Widget>[
          new FlatButton(
              onPressed: _handleSave,
              child: new Text('Save'),
              textColor: Colors.white),
        ],
      ),
      body: new Form(
        child: new ListView(
          padding: const EdgeInsets.all(10.0),
          children: <Widget>[
            new Container(
              padding: EdgeInsets.symmetric(vertical: d10),
              alignment: Alignment.bottomLeft,
              child: new TextField(
                controller: _titleEditController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  filled: true,
                ),
                style: Theme.of(context).textTheme.title,
                onChanged: (str) {
                  if (str.isNotEmpty) {
                    title = str;
                  }
                },
              ),
            ),
            new Container(
              padding: EdgeInsets.only(top: d10, bottom: d30),
              alignment: Alignment.bottomLeft,
              child: new TextField(
                controller: _contentEditController,
                decoration: const InputDecoration(
                  labelText: 'Content',
                  filled: true,
                ),
                style: Theme.of(context).textTheme.body1,
                onChanged: (str) {
                  if (str.isNotEmpty) {
                    content = str;
                  }
                },
              ),
            ),
            new Container(
              margin: const EdgeInsets.only(left: 8.0),
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: new BoxDecoration(
                  border: new Border(
                      bottom: new BorderSide(
                          color: Theme.of(context).dividerColor))),
              child: new InkWell(
                onTap: () {
                  DateTime data = dateTime == null
                      ? DateTime.now()
                      : DateTime.parse(dateTime);
                  showDatePicker(
                      context: context,
                      initialDate: data,
                      firstDate: data.subtract(new Duration(days: 90)),
                      lastDate: data.add(new Duration(days: 90)))
                      .then((DateTime value) {
                    setState(() {
                      dateTime =
                      '${value.year.toString()}-${value.month.toString()}-${value.day.toString()}';
                    });
                  });
                },
                child: new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(dateTime == null
                        ? DateTime.now().toString().substring(0, 10)
                        : dateTime),
                    const Icon(Icons.arrow_drop_down, color: Colors.black54),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _handleSave() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    if (title == null || title.isEmpty) {
      SnackBarUtils.show(context, "Title can't empty");
    }
    if (content == null || content.isEmpty) {
      SnackBarUtils.show(context, "Content can't empty");
    }
    widget.isAddTodo ? _addTodo() : _updateTodo();
  }

  _updateTodo() async {
    if (widget.todo != null) {
      Map<String, dynamic> json = await DioUtils.getInstance().post(
          'lg/todo/update/${widget.todo.id}/json',
          data: {
            'title': title,
            'content': content,
            'date': dateTime,
            'status': widget.todo.status,
          },
          options: new Options(
            contentType: ContentType.parse("application/x-www-form-urlencoded"),
          ));
      CommonBean commonBean = CommonBean.fromJson(json);
      if (commonBean.errorCode == 0) {
        Router.finish(context);
      } else {
        SnackBarUtils.show(context, commonBean.errorMsg);
      }
      EventBus.emit(REFRESH_TODO, true);
    }
  }

  _addTodo() async {
    print('title: $title contet:$content');
    Map<String, dynamic> json =
    await DioUtils.getInstance().post('lg/todo/add/json',
        data: {
          'title': title,
          'content': content,
          'date': dateTime,
        },
        options: new Options(
          contentType:
          ContentType.parse("application/x-www-form-urlencoded"),
        ));
    CommonBean commonBean = CommonBean.fromJson(json);
    if (commonBean.errorCode == 0) {
      Router.finish(context);
    } else {
      SnackBarUtils.show(context, commonBean.errorMsg);
    }
    EventBus.emit(REFRESH_TODO, true);
  }
}