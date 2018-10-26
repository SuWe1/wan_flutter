import 'package:dio/dio.dart';

class DioUtils {
  static DioUtils instance;
  Dio dio;
  Options options;

  static DioUtils getInstance() {
    print('get Dio Instance');
    if (instance == null) {
      instance = new DioUtils();
    }
    return instance;
  }

  DioUtils() {
    print('dio init');
    // 或者通过传递一个 `options`来创建dio实例
    options = Options(
      // 请求基地址,可以包含子路径，如: "https://www.google.com/api/".
      baseUrl: "http://www.wanandroid.com/",
      //连接服务器超时时间，单位是毫秒.
      connectTimeout: 10000,

      ///  响应流上前后两次接受到数据的间隔，单位为毫秒。如果两次间隔超过[receiveTimeout]，
      ///  [Dio] 将会抛出一个[DioErrorType.RECEIVE_TIMEOUT]的异常.
      ///  注意: 这并不是接收数据的总时限.
      receiveTimeout: 3000,
      headers: {},
    );
    dio = new Dio(options);
  }

  /// 请求路径，如果 `path` 以 "http(s)"开始, 则 `baseURL` 会被忽略； 否则,
  /// 将会和baseUrl拼接出完整的的url.
  get(path, {data, Options options, CancelToken cancelToken}) async {
    Response response;
    try {
      response = await dio.get(path,
          data: data, options: options, cancelToken: cancelToken);
      print('get Response : ${response.data.toString()}');
    } on DioError catch (e, s) {
      if (CancelToken.isCancel(e)) {
        print('get request cancle! ' + e.message);
      }
      print('get request error：$e');
      print('Stack trace: $s');
    }
    return response.data;
  }

  post(path, {data, Options options, CancelToken cancelToken}) async {
    Response response;
    try {
      response = await dio.post(path,
          data: data, options: options, cancelToken: cancelToken);
      print('post Response : ${response.data.toString()}');
    } on DioError catch (e, s) {
      if (CancelToken.isCancel(e)) {
        print('post request cancle! ' + e.message);
      }
      print('post request error：$e');
      print('Stack trace: $s');
    }
    return response.data;
  }
}
