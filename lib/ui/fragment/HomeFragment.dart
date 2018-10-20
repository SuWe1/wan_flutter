import 'package:flutter/material.dart';
import 'package:wan_flutter/data/bean/Article.dart';
import 'package:wan_flutter/model/DioUtils.dart';
import 'package:wan_flutter/ui/view/CommonListItem.dart';

class HomeFragment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeFragmentState();
  }
}

class HomeFragmentState extends State<HomeFragment> {
  HomeFragmentState() {
    getArticleListData();
  }

  List<ArticleItem> articles = new List();

  int _articlePage = 0;

  getArticleListData() async {
    Map<String, dynamic> json =
        await DioUtils.getInstance().get("article/list/$_articlePage/json");
    Article article = Article.fromJson(json);
    setState(() {
      articles.addAll(article.data.datas);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: new ListView.builder(
        itemBuilder: _indexedWidgetBuilder,
        itemCount: articles.length,
      ),
    );
  }

  List<Widget> _buildList() {
    return new List.generate(articles.length, (index) {
      return new CommonListItem(articles[index]);
    });
  }

  Widget _indexedWidgetBuilder(BuildContext context, int index) {
    return new CommonListItem(articles[index]);
  }
}
