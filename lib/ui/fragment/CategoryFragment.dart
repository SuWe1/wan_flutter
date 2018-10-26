import 'package:flutter/material.dart';

class CategoryFragment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CategoryFragmentState();
  }
}

class CategoryFragmentState extends State<CategoryFragment> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.purple,
      child: Center(
        child: Text('Content'),
      ),
    );
  }
}
