import 'package:flutter/material.dart';
import 'package:wan_flutter/common/Router.dart';
import 'package:wan_flutter/data/bean/Article.dart';
import 'package:wan_flutter/common/CommonValue.dart';

class CommonListItem extends StatefulWidget {
  CommonListItem(this.data, {Key key}) : super(key: key);

  final Article data;

  @override
  State<StatefulWidget> createState() => CommonListItemState();
}

class CommonListItemState extends State<CommonListItem> {
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: _click,
      child: new Card(
        elevation: d02,
        child: new Container(
          padding: EdgeInsets.fromLTRB(d10, d15, d10, d20),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Padding(
                padding: EdgeInsets.only(bottom: d15),
                child: new Text(
                  widget.data.title,
                  style: TextStyle(color: Colors.black87, fontSize: ts16),
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Row(
                      children: <Widget>[
                        new Text(
                          widget.data.author,
                          style:
                              TextStyle(color: Colors.black45, fontSize: ts13),
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        new Padding(
                          padding: EdgeInsets.symmetric(horizontal: d05),
                          child: new Icon(
                            Icons.timer,
                            color: Colors.grey,
                            size: 12.0,
                          ),
                        ),
                        new Text(
                          widget.data.niceDate,
                          style:
                              TextStyle(color: Colors.black45, fontSize: ts13),
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                    flex: 1,
                  ),
                  new Text(
                    widget.data.superChapterName != null
                        ? '${widget.data.chapterName}/${widget.data.superChapterName}'
                        : widget.data.chapterName,
                    style: TextStyle(color: Colors.pinkAccent, fontSize: ts13),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*
  跳转有延迟 所以看做是异步任务
   */
  void _click() {
    Router.gotoWebView(context, article: widget.data);
  }
}
