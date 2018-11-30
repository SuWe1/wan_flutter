import 'package:flutter/material.dart';
import 'package:wan_flutter/common/CommonValue.dart';

class DrawerMenuItem extends StatefulWidget {
  const DrawerMenuItem({this.onPress, this.icon, this.label});

  final VoidCallback onPress;

  final IconData icon;

  final String label;

  @override
  State<StatefulWidget> createState() => new DrawerMenuItemState();
}

class DrawerMenuItemState extends State<DrawerMenuItem> {
  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      height: d40,
      child: new Container(
        padding: EdgeInsets.all(d20),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new Icon(
              widget.icon,
              color: Theme.of(context).primaryColor,
            ),
            new Expanded(
              child: FlatButton(
                onPressed: widget.onPress,
                child: new Text(
                  widget.label,
                  textAlign: TextAlign.start,
                  style: new TextStyle(
                    color: Colors.black,
                    fontSize: ts14,
                  ),
                ),
              ),
              flex: 1,
            )
          ],
        ),
      ),
    );
  }
}
