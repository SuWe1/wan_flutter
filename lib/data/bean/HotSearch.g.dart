// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HotSearch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotSearch _$HotSearchFromJson(Map<String, dynamic> json) {
  return HotSearch(
      (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : HotSearchItem.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['errorCode'] as int,
      json['errorMsg'] as String);
}

Map<String, dynamic> _$HotSearchToJson(HotSearch instance) => <String, dynamic>{
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
      'data': instance.data
    };

HotSearchItem _$HotSearchItemFromJson(Map<String, dynamic> json) {
  return HotSearchItem(json['id'] as int, json['order'] as int,
      json['visible'] as int, json['link'] as String, json['name'] as String);
}

Map<String, dynamic> _$HotSearchItemToJson(HotSearchItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order': instance.order,
      'visible': instance.visible,
      'link': instance.link,
      'name': instance.name
    };
