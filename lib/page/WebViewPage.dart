import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:wan_flutter/data/bean/Article.dart';
import 'package:wan_flutter/data/bean/CommonBean.dart';
import 'package:wan_flutter/data/bean/Project.dart';
import 'package:wan_flutter/model/HttpHelper.dart';

/*
  关于lutter_webview_plugin使用参考 https://github.com/fluttercommunity/flutter_webview_plugin
  webview未集成在窗口小部件树中，它是在flutter视图之上的本机视图。不能使用 snackbars, dialogs等
 */

const key_select_edit = 'KEY_SELECT_EDIT';
const key_select_remove = 'KEY_SELECT_REMOVE';

class WebViewPage extends StatefulWidget {
  String title;
  String url;
  int id;
  bool collect;

  @override
  State<StatefulWidget> createState() => WebViewPageState();

  WebViewPage.fromArticle(Article data) {
    title = data.title;
    url = data.link;
    id = data.id;
    collect = data.collect;
  }

  WebViewPage.fromProject(Project data) {
    title = data.title;
    url = data.link;
    id = data.id;
    collect = data.collect;
  }
}

class WebViewPageState extends State<WebViewPage> {
  bool isLoading = true;
  bool collected = false;
  String responseMsg;

  //全局单例
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
    flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      if (state.type == WebViewState.finishLoad) {
        setState(() {
          isLoading = false;
        });
      } else if (state.type == WebViewState.startLoad) {
        setState(() {
          isLoading = true;
        });
      }
    });
    collected = widget.collect;
  }

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      url: widget.url,
      appBar: new AppBar(
        title: new Text(
          responseMsg == null || responseMsg.isEmpty
              ? widget.title
              : responseMsg,
        ),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(
              collected ? Icons.favorite : Icons.favorite_border,
              color: collected ? Colors.red : Colors.white,
            ),
            onPressed: _handleIconClick,
          ),
        ],
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        bottom: new PreferredSize(
            child: isLoading
                ? new LinearProgressIndicator()
                : new Divider(
                    height: 1.0,
                    color: Theme.of(context).primaryColor,
                  ),
            preferredSize: const Size.fromHeight(1.0)),
      ),
      withZoom: false,
      withJavascript: true,
      withLocalStorage: true,
    );
  }

  _handleIconClick() async {
    bool successful;
    await HttpHelper.post(
        path: collected
            ? "lg/uncollect_originId/${widget.id}/json"
            : "lg/collect/${widget.id}/json",
        data: {'id': widget.id},
        options: new Options(contentType: ContentType.json),
        transform: (Map json) => CommonBean.fromJson(json),
        action: (result) {
          successful = result.errorCode == 0;
          if (successful) {
            setState(() {
              collected = !collected;
            });
          }
          //结果显示
          Timer.run(() {
            setState(() {
              responseMsg = successful ? "Success" : result.errorMsg;
            });
          });
          //2秒后 重置
          Timer(Duration(seconds: 2), () {
            setState(() {
              responseMsg = null;
            });
          });
        });
  }
}
