import 'package:flutter/material.dart';
import 'package:wan_flutter/data/bean/Article.dart';
import 'package:wan_flutter/common/ColorValue.dart';
import 'package:wan_flutter/page/WebViewPage.dart';

class CommonListItem extends StatefulWidget {
  CommonListItem(this.data, {Key key}) : super(key: key);

  final ArticleItem data;

  @override
  State<StatefulWidget> createState() => CommonListItemState();
}

class CommonListItemState extends State<CommonListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _click,
      child: Container(
        padding: EdgeInsets.only(top: d05),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(d10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    widget.data.title,
                    style: TextStyle(color: Colors.black87, fontSize: ts14),
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: d10),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Text(
                              widget.data.author,
                              style: TextStyle(
                                  color: Colors.black45, fontSize: ts12),
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Padding(padding: EdgeInsets.only(right: d05)),
                            Icon(
                              Icons.timer,
                              color: Colors.grey,
                              size: 12.0,
                            ),
                            Padding(padding: EdgeInsets.only(right: d05)),
                            Text(
                              widget.data.niceDate,
                              style: TextStyle(
                                  color: Colors.black45, fontSize: ts12),
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                        flex: 1,
                      ),
                      Text(
                        '${widget.data.chapterName}/${widget.data.superChapterName}',
                        style:
                            TextStyle(color: Colors.pinkAccent, fontSize: ts12),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: d05),
            ),
            Container(
              color: Colors.black12,
              height: 1.0,
            ),
          ],
        ),
      ),
    );
  }

  /*
  跳转有延迟 所以看做是异步任务
   */
  void _click() async {
    await Navigator.of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) {
      return WebViewPage(title: widget.data.title, url: widget.data.link);
    }));
  }
}
