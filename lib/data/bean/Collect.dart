import 'package:wan_flutter/data/bean/CommonBean.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Collect.g.dart';

@JsonSerializable()
class CollectBean extends CommonBean {
  CollectData data;

  CollectBean(this.data, int errorCode, String errorMsg)
      : super(errorCode, errorMsg);

  factory CollectBean.fromJson(Map<String, dynamic> json) =>
      _$CollectBeanFromJson(json);
}

@JsonSerializable()
class CollectData {
  int curPage;
  List<Collect> datas;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;

  CollectData(this.curPage, this.datas, this.offset, this.over, this.pageCount,
      this.size, this.total);

  factory CollectData.fromJson(Map<String, dynamic> json) =>
      _$CollectDataFromJson(json);
}

@JsonSerializable()
class Collect {
  String author;
  int chapterId;
  String chapterName;
  int courseId;
  String desc;
  String envelopePic;
  int id;
  String link;
  String niceDate;
  String origin;
  int originId;
  int publishTime;
  String title;
  int userId;
  int visible;
  int zan;

  Collect(
      this.author,
      this.chapterId,
      this.chapterName,
      this.courseId,
      this.desc,
      this.envelopePic,
      this.id,
      this.link,
      this.niceDate,
      this.origin,
      this.originId,
      this.publishTime,
      this.title,
      this.userId,
      this.visible,
      this.zan);

  factory Collect.fromJson(Map<String, dynamic> json) =>
      _$CollectFromJson(json);
}
