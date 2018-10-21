import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wan_flutter/common/ColorValue.dart';

class CommonLoadMore extends StatelessWidget {
  CommonLoadMore(this.color);

  final Color color;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _buildLoadMore();
  }

  Widget _buildLoadMore() {
    return new Container(
      padding: EdgeInsets.all(d10),
      child: SpinKitWave(
        color: color,
        size: 20.0,
        type: SpinKitWaveType.center,
      ),
    );
  }
}
