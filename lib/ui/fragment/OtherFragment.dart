import 'package:flutter/material.dart';
import 'package:wan_flutter/page/LgRgPage.dart';
import 'package:wan_flutter/common/ColorValue.dart';

class OtherFragment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return OtherFragmentState();
  }
}

class OtherFragmentState extends State<OtherFragment> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new GestureDetector(
            child: CircleAvatar(
              maxRadius: d50,
              backgroundColor: Theme.of(context).primaryColor,
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return LgRgPage();
              }));
            },
          ),
        ],
      ),
    );
  }
}
