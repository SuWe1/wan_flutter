// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WxBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WxTabs _$WxTabsFromJson(Map<String, dynamic> json) {
  return WxTabs(
      json['errorCode'] as int,
      json['errorMsg'] as String,
      (json['data'] as List)
          ?.map((e) =>
              e == null ? null : WxTabItem.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$WxTabsToJson(WxTabs instance) => <String, dynamic>{
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
      'data': instance.data
    };

WxTabItem _$WxTabItemFromJson(Map<String, dynamic> json) {
  return WxTabItem(
      json['children'] as List,
      json['courseId'] as int,
      json['id'] as int,
      json['order'] as int,
      json['parentChapterId'] as int,
      json['visible'] as int,
      json['userControlSetTop'] as bool,
      json['name'] as String);
}

Map<String, dynamic> _$WxTabItemToJson(WxTabItem instance) => <String, dynamic>{
      'children': instance.children,
      'courseId': instance.courseId,
      'id': instance.id,
      'order': instance.order,
      'parentChapterId': instance.parentChapterId,
      'visible': instance.visible,
      'userControlSetTop': instance.userControlSetTop,
      'name': instance.name
    };
