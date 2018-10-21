import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:wan_flutter/common/ColorValue.dart';

/*
  关于lutter_webview_plugin使用参考 https://github.com/fluttercommunity/flutter_webview_plugin
  webview未集成在窗口小部件树中，它是在flutter视图之上的本机视图。不能使用 snackbars, dialogs等
 */

class WebViewPage extends StatefulWidget {
  WebViewPage({Key key, @required this.title, @required this.url})
      : super(key: key);

  String title;
  String url;

  @override
  State<StatefulWidget> createState() => WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> {
  bool isLoading = true;

  //全局单例
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  @override
  void initState() {
    // TODO: implement initState
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
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new WebviewScaffold(
      url: widget.url,
      appBar: new AppBar(
        title: new Text(
          widget.title,
        ),
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
}
