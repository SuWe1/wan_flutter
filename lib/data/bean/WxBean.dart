import 'package:json_annotation/json_annotation.dart';

part 'WxBean.g.dart';

@JsonSerializable()
class WxTabs {
  final int errorCode;
  final String errorMsg;
  final List<WxTabItem> data;

  WxTabs(this.errorCode, this.errorMsg, this.data);

  factory WxTabs.fromJson(Map<String, dynamic> json) => _$WxTabsFromJson(json);
}

@JsonSerializable()
class WxTabItem {
  final List<dynamic> children;
  final int courseId;
  final int id;
  final int order;
  final int parentChapterId;
  final int visible;

  final bool userControlSetTop;
  final String name;

  WxTabItem(this.children, this.courseId, this.id, this.order,
      this.parentChapterId, this.visible, this.userControlSetTop, this.name);

  factory WxTabItem.fromJson(Map<String, dynamic> json) =>
      _$WxTabItemFromJson(json);
}
