import 'package:flutter/material.dart';
import 'package:wan_flutter/data/bean/Article.dart';
import 'package:wan_flutter/page/CollectPage.dart';
import 'package:wan_flutter/page/LgRgPage.dart';
import 'package:wan_flutter/page/WebViewPage.dart';
import 'package:wan_flutter/page/WxPage.dart';

class Router {
  static finish(BuildContext context) {
    Navigator.of(context).pop();
  }

  static gotoWebView(BuildContext context, ArticleItem data) {
    return Navigator.of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) {
      return new WebViewPage(
        title: data.title,
        url: data.link,
        collect: data.collect,
        id: data.id,
      );
    }));
  }

  static gotoLogin(BuildContext context) async {
    return await Navigator.of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) {
      return new LgRgPage();
    }));
  }

  static gotoCollect(BuildContext context) async {
    return await Navigator.of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) {
      return new CollectPage();
    }));
  }

  static gotoWx(BuildContext context) async {
    return await Navigator.of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) {
      return new WxPage();
    }));
  }
}
