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
    return new ListTile(
      leading: Icon(
        widget.icon,
        color: Theme.of(context).primaryColor,
      ),
      title: Text(widget.label),
      onTap: widget.onPress,
    );
  }
}
