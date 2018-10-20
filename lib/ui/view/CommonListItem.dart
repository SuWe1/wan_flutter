import 'package:flutter/material.dart';
import 'package:wan_flutter/data/bean/Article.dart';
import 'package:wan_flutter/ui/common/ColorValue.dart';

class CommonListItem extends StatefulWidget {
  CommonListItem(this.data, {Key key}) : super(key: key);

  final ArticleItem data;

  @override
  State<StatefulWidget> createState() => CommonListItemState();
}

class CommonListItemState extends State<CommonListItem> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.only(top: d05),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Container(
            padding: EdgeInsets.all(d10),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Text(
                  widget.data.title,
                  style: TextStyle(color: Colors.black87, fontSize: ts14),
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                new Padding(
                  padding: EdgeInsets.only(bottom: d10),
                ),
                new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Row(
                        children: <Widget>[
                          new Text(
                            widget.data.author,
                            style: TextStyle(
                                color: Colors.black45, fontSize: ts12),
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          new Padding(padding: EdgeInsets.only(right: d05)),
                          new Icon(
                            Icons.timer,
                            color: Colors.grey,
                            size: 12.0,
                          ),
                          new Padding(padding: EdgeInsets.only(right: d05)),
                          new Text(
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
                    new Text(
                      '${widget.data.chapterName}/${widget.data.superChapterName}',
                      style:
                          TextStyle(color: Colors.pinkAccent, fontSize: ts12),
                    )
                  ],
                ),
              ],
            ),
          ),
          new Padding(
            padding: EdgeInsets.only(bottom: d05),
          ),
          new Container(
            color: Colors.black12,
            height: 1.0,
          ),
        ],
      ),
    );
  }
}
