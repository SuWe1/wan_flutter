// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoBean _$TodoBeanFromJson(Map<String, dynamic> json) {
  return TodoBean(
      json['data'] == null
          ? null
          : TodoData.fromJson(json['data'] as Map<String, dynamic>),
      json['errorCode'] as int,
      json['errorMsg'] as String);
}

Map<String, dynamic> _$TodoBeanToJson(TodoBean instance) => <String, dynamic>{
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
      'data': instance.data
    };

TodoData _$TodoDataFromJson(Map<String, dynamic> json) {
  return TodoData(
      (json['datas'] as List)
          ?.map((e) =>
              e == null ? null : Todo.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['offset'] as int,
      json['over'] as bool,
      json['pageCount'] as int,
      json['size'] as int,
      json['total'] as int,
      json['curPage'] as int);
}

Map<String, dynamic> _$TodoDataToJson(TodoData instance) => <String, dynamic>{
      'datas': instance.datas,
      'offset': instance.offset,
      'over': instance.over,
      'pageCount': instance.pageCount,
      'size': instance.size,
      'total': instance.total,
      'curPage': instance.curPage
    };

Todo _$TodoFromJson(Map<String, dynamic> json) {
  return Todo(
      json['completeDate'] as int,
      json['completeDateStr'] as String,
      json['content'] as String,
      json['date'] as int,
      json['dateStr'] as String,
      json['id'] as int,
      json['status'] as int,
      json['title'] as String,
      json['type'] as int,
      json['userId'] as int)
    ..priority = json['priority'] as int;
}

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      'completeDate': instance.completeDate,
      'completeDateStr': instance.completeDateStr,
      'content': instance.content,
      'date': instance.date,
      'dateStr': instance.dateStr,
      'id': instance.id,
      'priority': instance.priority,
      'status': instance.status,
      'title': instance.title,
      'type': instance.type,
      'userId': instance.userId
    };
