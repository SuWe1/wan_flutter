import 'dart:io';

import 'package:dio/dio.dart';
import 'package:wan_flutter/model/DioUtils.dart';

typedef ActionCallback<T> = void Function(T args);
typedef TransformCallback<T> = T Function(Map args);

class HttpHelper {
  static get<T>(
      {path, TransformCallback<T> transform, ActionCallback<T> action}) async {
    Map<String, dynamic> json = await DioUtils.getInstance().get(path);
    action(transform(json));
  }

  static post<T>(
      {path,
      data,
      TransformCallback<T> transform,
      ActionCallback<T> action,
      Options options}) async {
    Map<String, dynamic> json = await DioUtils.getInstance().post(path,
        data: data,
        options: options ??= new Options(
          contentType: ContentType.parse("application/x-www-form-urlencoded"),
        ));
    action(transform(json));
  }
}
