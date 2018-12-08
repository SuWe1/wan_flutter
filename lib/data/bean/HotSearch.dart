import 'package:json_annotation/json_annotation.dart';
import 'package:wan_flutter/data/bean/CommonBean.dart';

part 'HotSearch.g.dart';

@JsonSerializable()
class HotSearch extends CommonBean {
  List<HotSearchItem> data;

  HotSearch(this.data, int errorCode, String errorMsg)
      : super(errorCode, errorMsg);

  factory HotSearch.fromJson(Map<String, dynamic> json) =>
      _$HotSearchFromJson(json);
}

@JsonSerializable()
class HotSearchItem {
  int id;
  int order;
  int visible;
  String link;
  String name;

  HotSearchItem(this.id, this.order, this.visible, this.link, this.name);

  factory HotSearchItem.fromJson(Map<String, dynamic> json) =>
      _$HotSearchItemFromJson(json);
}
