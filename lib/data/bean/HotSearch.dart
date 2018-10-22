import 'package:json_annotation/json_annotation.dart';

part 'HotSearch.g.dart';

@JsonSerializable()
class HotSearch {
  List<HotSearchItem> data;
  int errorCode;
  String errorMsg;

  HotSearch(this.data, this.errorCode, this.errorMsg);

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
