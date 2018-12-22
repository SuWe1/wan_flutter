// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Collect.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectBean _$CollectBeanFromJson(Map<String, dynamic> json) {
  return CollectBean(
      json['data'] == null
          ? null
          : CollectData.fromJson(json['data'] as Map<String, dynamic>),
      json['errorCode'] as int,
      json['errorMsg'] as String);
}

Map<String, dynamic> _$CollectBeanToJson(CollectBean instance) =>
    <String, dynamic>{
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
      'data': instance.data
    };

CollectData _$CollectDataFromJson(Map<String, dynamic> json) {
  return CollectData(
      json['curPage'] as int,
      (json['datas'] as List)
          ?.map((e) =>
              e == null ? null : Collect.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['offset'] as int,
      json['over'] as bool,
      json['pageCount'] as int,
      json['size'] as int,
      json['total'] as int);
}

Map<String, dynamic> _$CollectDataToJson(CollectData instance) =>
    <String, dynamic>{
      'curPage': instance.curPage,
      'datas': instance.datas,
      'offset': instance.offset,
      'over': instance.over,
      'pageCount': instance.pageCount,
      'size': instance.size,
      'total': instance.total
    };

Collect _$CollectFromJson(Map<String, dynamic> json) {
  return Collect(
      json['author'] as String,
      json['chapterId'] as int,
      json['chapterName'] as String,
      json['courseId'] as int,
      json['desc'] as String,
      json['envelopePic'] as String,
      json['id'] as int,
      json['link'] as String,
      json['niceDate'] as String,
      json['origin'] as String,
      json['originId'] as int,
      json['publishTime'] as int,
      json['title'] as String,
      json['userId'] as int,
      json['visible'] as int,
      json['zan'] as int);
}

Map<String, dynamic> _$CollectToJson(Collect instance) => <String, dynamic>{
      'author': instance.author,
      'chapterId': instance.chapterId,
      'chapterName': instance.chapterName,
      'courseId': instance.courseId,
      'desc': instance.desc,
      'envelopePic': instance.envelopePic,
      'id': instance.id,
      'link': instance.link,
      'niceDate': instance.niceDate,
      'origin': instance.origin,
      'originId': instance.originId,
      'publishTime': instance.publishTime,
      'title': instance.title,
      'userId': instance.userId,
      'visible': instance.visible,
      'zan': instance.zan
    };
