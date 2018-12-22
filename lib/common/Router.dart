import 'package:flutter/material.dart';
import 'package:wan_flutter/data/bean/Article.dart';
import 'package:wan_flutter/data/bean/Project.dart';
import 'package:wan_flutter/page/CollectPage.dart';
import 'package:wan_flutter/page/LgRgPage.dart';
import 'package:wan_flutter/page/WebViewPage.dart';
import 'package:wan_flutter/page/WxPage.dart';

class Router {
  static finish(BuildContext context) {
    Navigator.of(context).pop();
  }

  static gotoWebView(BuildContext context, {Article article, Project project}) {
    return Navigator.of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) {
      if (article != null) {
        return WebViewPage.fromArticle(article);
      } else if (project != null) {
        return WebViewPage.fromProject(project);
      }
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
