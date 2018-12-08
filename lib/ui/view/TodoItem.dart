import 'package:flutter/material.dart';
import 'package:wan_flutter/data/bean/Todo.dart';
import 'package:wan_flutter/common/CommonValue.dart';

const key_select_edit = 'KEY_SELECT_EDIT';
const key_select_remove = 'KEY_SELECT_REMOVE';

class TodoView extends StatefulWidget {
  Todo todo;

  @override
  State<StatefulWidget> createState() => TodoItemState();

  TodoView(this.todo, {Key key}) : super(key: key);
}

class TodoItemState extends State<TodoView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
      trailing: new Checkbox(value: widget.todo.status == 0, onChanged: (bool) {
        
      }),
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
        break;
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
    // TODO: implement build
    return new Scaffold(
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
