// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleBean _$ArticleBeanFromJson(Map<String, dynamic> json) {
  return ArticleBean(ArticleData.fromJson(json['data'] as Map<String, dynamic>),
      json['errorCode'] as int, json['errorMsg'] as String);
}

Map<String, dynamic> _$ArticleBeanToJson(ArticleBean instance) =>
    <String, dynamic>{
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
      'data': instance.data
    };

ArticleData _$ArticleDataFromJson(Map<String, dynamic> json) {
  return ArticleData(
      json['curPage'] as int,
      (json['datas'] as List)
          ?.map((e) =>
              e == null ? null : Article.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['offset'] as int,
      json['over'] as bool,
      json['pageCount'] as int,
      json['size'] as int,
      json['total'] as int);
}

Map<String, dynamic> _$ArticleDataToJson(ArticleData instance) =>
    <String, dynamic>{
      'curPage': instance.curPage,
      'datas': instance.datas,
      'offset': instance.offset,
      'over': instance.over,
      'pageCount': instance.pageCount,
      'size': instance.size,
      'total': instance.total
    };

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return Article(
      json['title'] as String,
      json['author'] as String,
      json['niceDate'] as String,
      json['superChapterName'] as String,
      json['chapterName'] as String,
      json['link'] as String,
      json['id'] as int,
      json['collect'] as bool,
      json['visible'] as int,
      json['zan'] as int);
}

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'title': instance.title,
      'author': instance.author,
      'niceDate': instance.niceDate,
      'superChapterName': instance.superChapterName,
      'chapterName': instance.chapterName,
      'link': instance.link,
      'id': instance.id,
      'collect': instance.collect,
      'visible': instance.visible,
      'zan': instance.zan
    };
