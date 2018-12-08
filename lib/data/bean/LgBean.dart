import 'package:json_annotation/json_annotation.dart';
import 'package:wan_flutter/data/bean/CommonBean.dart';

part 'LgBean.g.dart';

@JsonSerializable()
class LgBean extends CommonBean {
  Lg data;

  LgBean(this.data, int errorCode, String errorMsg)
      : super(errorCode, errorMsg);

  factory LgBean.fromJson(Map<String, dynamic> json) => _$LgBeanFromJson(json);
}

@JsonSerializable()
class Lg {
  List<Object> chapterTops;
  List<int> collectIds;
  String email;
  String icon;
  int id;
  String password;
  String token;
  int type;
  String username;

  Lg(this.chapterTops, this.collectIds, this.email, this.icon, this.id,
      this.password, this.token, this.type, this.username);

  factory Lg.fromJson(Map<String, dynamic> json) => _$LgFromJson(json);
}
