import 'package:flutter/material.dart';
import 'package:wan_flutter/data/bean/HotSearch.dart';
import 'package:wan_flutter/model/DioUtils.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  List<Widget> hotWidgets = [];

  bool isInput = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new TextField(),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.clear), onPressed: null),
          new IconButton(icon: new Icon(Icons.search), onPressed: null),
        ],
      ),
      body: new Center(),
    );
  }

  _generateHotSearch() async {
    Map<String, dynamic> json =
        await DioUtils.getInstance().post('hotkey/json');
    List<HotSearchItem> datas = HotSearch.fromJson(json).data;
    List<Widget> widgets = [];
    for (var data in datas) {
      Widget hsItem = new ActionChip(
          label: new Text(data.name),
          backgroundColor: Colors.blueGrey,
          onPressed: () {
            _search(data.name);
          });
      widgets.add(hsItem);
    }
    setState(() {
      hotWidgets = widgets;
    });
  }

  _search(String k) {}
}
