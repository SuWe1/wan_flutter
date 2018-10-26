import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wan_flutter/common/ColorValue.dart';

class CommonLoadingView extends StatelessWidget {
  CommonLoadingView(this.color);

  final Color color;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Center(
      child: new SpinKitCubeGrid(
        color: color,
        size: d30,
      ),
    );
  }
}
