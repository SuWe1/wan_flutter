import 'package:json_annotation/json_annotation.dart';
import 'package:wan_flutter/data/bean/CommonBean.dart';

part 'Article.g.dart';

@JsonSerializable(nullable: false)
class ArticleBean extends CommonBean {
  ArticleBean(this.data, int errorCode, String errorMsg)
      : super(errorCode, errorMsg);

  ArticleData data;

  factory ArticleBean.fromJson(Map<String, dynamic> json) =>
      _$ArticleBeanFromJson(json);
}

@JsonSerializable()
class ArticleData {
  ArticleData(this.curPage, this.datas, this.offset, this.over, this.pageCount,
      this.size, this.total);

  int curPage;
  List<Article> datas;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;

  factory ArticleData.fromJson(Map<String, dynamic> json) =>
      _$ArticleDataFromJson(json);
}

@JsonSerializable()
class Article {
  final String title;
  final String author;
  final String niceDate;

  //一级分类
  final String superChapterName;

  //二级分类
  final String chapterName;
  final String link;

  final int id;
  final bool collect;
  final int visible;
  final int zan;

  factory Article.fromJson(Map<String, dynamic> json) =>
     _$ArticleFromJson(json);

  Article(
      this.title,
      this.author,
      this.niceDate,
      this.superChapterName,
      this.chapterName,
      this.link,
      this.id,
      this.collect,
      this.visible,
      this.zan);
}
