import 'package:wan_flutter/data/bean/CommonBean.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Project.g.dart';

@JsonSerializable()
class ProjectBean extends CommonBean {
  ProjectData data;

  ProjectBean(this.data, int errorCode, String errorMsg)
      : super(errorCode, errorMsg);

  factory ProjectBean.fromJson(Map<String, dynamic> json) =>
      _$ProjectBeanFromJson(json);
}

@JsonSerializable()
class ProjectData {
  int curPage;
  List<Project> datas;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;

  ProjectData(this.curPage, this.datas, this.offset, this.over, this.pageCount,
      this.size, this.total);

  factory ProjectData.fromJson(Map<String, dynamic> json) =>
      _$ProjectDataFromJson(json);
}

@JsonSerializable()
class Project {
  String apkLink;
  String author;
  int chapterId;
  String chapterName;
  bool collect;
  int courseId;
  String desc;
  String envelopePic;
  bool fresh;
  int id;
  String link;
  String niceDate;
  String origin;
  String projectLink;
  int publishTime;
  int superChapterId;
  String superChapterName;
  List<Tag> tags;
  String title;
  int type;
  int userId;
  int visible;
  int zan;

  Project(
      this.apkLink,
      this.author,
      this.chapterId,
      this.chapterName,
      this.collect,
      this.courseId,
      this.desc,
      this.envelopePic,
      this.fresh,
      this.id,
      this.link,
      this.niceDate,
      this.origin,
      this.projectLink,
      this.publishTime,
      this.superChapterId,
      this.superChapterName,
      this.tags,
      this.title,
      this.type,
      this.userId,
      this.visible,
      this.zan);

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);
}

@JsonSerializable()
class Tag {
  String name;
  String url;

  Tag(this.name, this.url);

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
}
