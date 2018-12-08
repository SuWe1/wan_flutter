import 'package:json_annotation/json_annotation.dart';

part 'Article.g.dart';

@JsonSerializable(nullable: false)
class Article {
  Article(this.data, this.errorCode, this.errorMsg);

  ArticleData data;
  int errorCode;
  String errorMsg;

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
}

@JsonSerializable()
class ArticleData {
  ArticleData(this.curPage, this.datas, this.offset, this.over, this.pageCount,
      this.size, this.total);

  int curPage;
  List<ArticleItem> datas;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;

  factory ArticleData.fromJson(Map<String, dynamic> json) =>
      _$ArticleDataFromJson(json);
}

@JsonSerializable()
class ArticleItem {
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

  factory ArticleItem.fromJson(Map<String, dynamic> json) =>
      _$ArticleItemFromJson(json);

  ArticleItem(
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
