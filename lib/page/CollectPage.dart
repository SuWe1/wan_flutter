import 'package:flutter/material.dart';

class CollectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new CollectPageState();
}

class CollectPageState extends State<CollectPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Collect'),
      ),
      body: new Center(child: new Text('Collect')),
    );
  }
}
