import 'dart:async';
import 'package:flutter/material.dart';

class CategoryFragment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CategoryFragmentState();
  }
}

class CategoryFragmentState extends State<CategoryFragment> with AutomaticKeepAliveClientMixin{

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Center(child: new Text('Category')),
    );
  }
}
