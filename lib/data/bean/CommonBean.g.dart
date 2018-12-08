// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CommonBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonBean _$CommonBeanFromJson(Map<String, dynamic> json) {
  return CommonBean(json['errorCode'] as int, json['errorMsg'] as String);
}

Map<String, dynamic> _$CommonBeanToJson(CommonBean instance) =>
    <String, dynamic>{
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg
    };
