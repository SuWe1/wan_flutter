// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LgBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LgBean _$LgBeanFromJson(Map<String, dynamic> json) {
  return LgBean(
      json['data'] == null
          ? null
          : Lg.fromJson(json['data'] as Map<String, dynamic>),
      json['errorCode'] as int,
      json['errorMsg'] as String);
}

Map<String, dynamic> _$LgBeanToJson(LgBean instance) => <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg
    };

Lg _$LgFromJson(Map<String, dynamic> json) {
  return Lg(
      json['chapterTops'] as List,
      (json['collectIds'] as List)?.map((e) => e as int)?.toList(),
      json['email'] as String,
      json['icon'] as String,
      json['id'] as int,
      json['password'] as String,
      json['token'] as String,
      json['type'] as String,
      json['username'] as String);
}

Map<String, dynamic> _$LgToJson(Lg instance) => <String, dynamic>{
      'chapterTops': instance.chapterTops,
      'collectIds': instance.collectIds,
      'email': instance.email,
      'icon': instance.icon,
      'id': instance.id,
      'password': instance.password,
      'token': instance.token,
      'type': instance.type,
      'username': instance.username
    };
