import 'package:json_annotation/json_annotation.dart';
import 'package:wan_flutter/data/bean/Collect.dart';
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
  String title;
  String author;
  String niceDate;

  //一级分类
  String superChapterName;

  //二级分类
  String chapterName;
  String link;

  int id;
  bool collect;
  int visible;
  int zan;

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  Article.fromCollect(Collect collect) {
    title = collect.title;
    author = collect.author;
    niceDate = collect.niceDate;
    superChapterName = null;
    chapterName = collect.chapterName;
    link = collect.link;
    id = collect.id;
    this.collect = true;
    visible = collect.visible;
    zan = collect.zan;
  }

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
