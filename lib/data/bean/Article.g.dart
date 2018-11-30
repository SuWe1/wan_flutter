// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return Article(ArticleData.fromJson(json['data'] as Map<String, dynamic>),
      json['errorCode'] as int, json['errorMsg'] as String);
}

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg
    };

ArticleData _$ArticleDataFromJson(Map<String, dynamic> json) {
  return ArticleData(
      json['curPage'] as int,
      (json['datas'] as List)
          ?.map((e) => e == null
              ? null
              : ArticleItem.fromJson(e as Map<String, dynamic>))
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

ArticleItem _$ArticleItemFromJson(Map<String, dynamic> json) {
  return ArticleItem(
      json['title'] as String,
      json['author'] as String,
      json['niceDate'] as String,
      json['superChapterName'] as String,
      json['chapterName'] as String,
      json['link'] as String,
      json['id'] as int);
}

Map<String, dynamic> _$ArticleItemToJson(ArticleItem instance) =>
    <String, dynamic>{
      'title': instance.title,
      'author': instance.author,
      'niceDate': instance.niceDate,
      'superChapterName': instance.superChapterName,
      'chapterName': instance.chapterName,
      'link': instance.link,
      'id': instance.id
    };
