import 'package:flutter/material.dart';

class OtherFragment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return OtherFragmentState();
  }
}

class OtherFragmentState extends State<OtherFragment> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.blue,
      child: Center(
        child: Text('Content'),
      ),
    );
  }
}
