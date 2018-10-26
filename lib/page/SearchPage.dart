import 'package:flutter/material.dart';
import 'package:wan_flutter/data/bean/Article.dart';
import 'package:wan_flutter/data/bean/HotSearch.dart';
import 'package:wan_flutter/model/DioUtils.dart';
import 'package:wan_flutter/common/ColorValue.dart';
import 'package:wan_flutter/ui/view/CommonListItem.dart';
import 'package:wan_flutter/ui/view/CommonLoadMore.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  final TextEditingController _textEditController = new TextEditingController();
  final ScrollController _scrollController = new ScrollController();
  List<Widget> _hotWidgets = [];

  List<ArticleItem> articles = new List();

  bool showSearchList = false;

  int _currentPage = 0;

  bool isLoading = false;

  bool hasNextPage = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _buildHotSearch();
    _scrollController.addListener(_loadMoreListener);
  }

  _loadMoreListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMore();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new TextField(
          controller: _textEditController,
          onSubmitted: _handleSearchSubmit,
          onChanged: (String str) {},
          maxLines: 1,
          textAlign: TextAlign.start,
//          inputFormatters: [],
          cursorColor: Theme.of(context).primaryColor,
          style: new TextStyle(color: Color(c101), fontSize: ts16),
          decoration: new InputDecoration.collapsed(
            hintText: 'Input keywords',
            hintStyle: new TextStyle(color: Color(c101), fontSize: ts16),
          ),
        ),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(
                Icons.clear,
                color: Color(c101),
                size: d18,
              ),
              onPressed: _handleSearchClear),
          new IconButton(
              icon: new Icon(
                Icons.search,
                color: Color(c101),
              ),
              onPressed: _handleSearchSubmit(_textEditController.text)),
        ],
      ),
      body: showSearchList
          ? new Container(
              child: new ListView.builder(
                itemBuilder: _indexedWidgetBuilder,
                itemCount: hasNextPage ? articles.length + 1 : articles.length,
              ),
            )
          : new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(d10),
                  child: new Text(
                    'Hot Search',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
                new Padding(
                  padding: EdgeInsets.only(bottom: d10),
                ),
                new Container(
                  padding: EdgeInsets.only(left: d10, right: d10),
                  child: new Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.start,
                    spacing: d10,
                    runSpacing: d10,
                    children: _hotWidgets,
                  ),
                ),
              ],
            ),
    );
  }

  Widget _indexedWidgetBuilder(BuildContext context, int index) {
    return hasNextPage && index == articles.length
        ? CommonLoadMore(Theme.of(context).primaryColor)
        : new CommonListItem(articles[index]);
  }

  _buildHotSearch() async {
    Map<String, dynamic> json = await DioUtils.getInstance().get('hotkey/json');
    List<HotSearchItem> datas = HotSearch.fromJson(json).data;
    List<Widget> widgets = [];
    for (var data in datas) {
      Widget hsItem = new ActionChip(
          padding: EdgeInsets.all(d05),
          label: new Text(data.name),
          onPressed: () {
            _handleHotClick(data.name);
          });
      widgets.add(hsItem);
    }
    setState(() {
      _hotWidgets = widgets;
    });
  }

  _handleSearchSubmit(String str) {
    _handleSearch(str);
  }

  _handleSearchChange(String str) {
    setState(() {
      showSearchList = str.length == 0;
      if (showSearchList) {
        articles.clear();
        _currentPage = 0;
      }
    });
  }

  _handleSearchClear() {
    _textEditController.clear();
    setState(() {
      articles.clear();
      _currentPage = 0;
      showSearchList = false;
    });
  }

  _handleSearch(String k) async {
    if (k.isEmpty) {
      return;
    }
//    Map<String, dynamic> json = await DioUtils.getInstance().post(
//      'article/query/$_currentPage/json',
//      data: {'k': k},
//      options: new Options(
//          contentType: ContentType.parse("application/x-www-form-urlencoded")),
//    );
//    Article newData = Article.fromJson(json);
//    setState(() {
//      articles.addAll(newData.data.datas);
//      hasNextPage = newData.data.total >= articles.length;
//      showSearchList = true;
//    });
  }

  _handleHotClick(String str) {
    _textEditController.text = str;
    _handleSearch(str);
  }

  _loadMore() async {
    if (isLoading) {
      return;
    }
    isLoading = true;
    _currentPage++;
    await _handleSearch(_textEditController.text);
    isLoading = false;
  }
}
