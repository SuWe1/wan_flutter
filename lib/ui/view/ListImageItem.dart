import 'package:flutter/material.dart';
import 'package:wan_flutter/common/CommonValue.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wan_flutter/common/Router.dart';
import 'package:wan_flutter/data/bean/Project.dart';

class ListImageItem extends StatefulWidget {
  Project project;

  @override
  State<StatefulWidget> createState() => ListImageItemState();

  ListImageItem(this.project);
}

class ListImageItemState extends State<ListImageItem> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: _click,
      child: new Card(
        elevation: d02,
        child: new Container(
          padding: EdgeInsets.fromLTRB(d10, d15, d10, d20),
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Padding(
                      padding: EdgeInsets.only(bottom: d05),
                      child: new Text(
                        widget.project.title,
                        style: TextStyle(color: Colors.black87, fontSize: ts16),
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    new Padding(
                      padding: EdgeInsets.symmetric(vertical: d10),
                      child: new Text(
                        widget.project.desc,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 14.0),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          widget.project.author,
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
                          widget.project.niceDate,
                          style:
                              TextStyle(color: Colors.black45, fontSize: ts13),
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: new CachedNetworkImage(
                  imageUrl: widget.project?.envelopePic,
                  width: d50,
                  height: d100,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _click() {
    Router.gotoWebView(context, project: widget.project);
  }
}
