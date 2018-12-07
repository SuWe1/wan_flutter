import 'dart:io';
import 'package:dio/dio.dart';
import 'package:wan_flutter/common/PreferenceUtils.dart';
import 'package:wan_flutter/data/bean/LgBean.dart';
import 'package:wan_flutter/model/DioUtils.dart';

class UserManager {
  String username;
  String userPass;

  static final UserManager _instance = new UserManager._internal();

  factory UserManager() {
    return _instance;
  }

  UserManager._internal();

  tryAutoLogin() {
    if (username != null && userPass != null) {
      login();
    }
  }

  login() async {
    Map<String, dynamic> json = await DioUtils.getInstance().post('user/login',
        data: {'username': username, 'password': userPass},
        options: new Options(
          contentType: ContentType.parse("application/x-www-form-urlencoded"),
        ));
    LgBean lgBean = LgBean.fromJson(json);
    if (lgBean.errorCode == 0) {
      //登录成功 保存信息用于更新token
      UserManager().username = lgBean.data.username;
      UserManager().userPass = lgBean.data.password;
      PreferenceUtils.putStr(USER_NAME, lgBean.data.username);
      PreferenceUtils.putStr(USER_PASSWORD, lgBean.data.password);
      PreferenceUtils.putStr(LAST_SAVE_TIME, DateTime.now().toIso8601String());
    }
  }
}
