import 'package:flutter/material.dart';
import 'package:wan_flutter/page/LgRgPage.dart';
import 'package:wan_flutter/common/CommonValue.dart';

class TodoFragment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TodoFragmentState();
  }
}

class TodoFragmentState extends State<TodoFragment> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: new Center(child: new Text('Todo')),
    );
  }
}
