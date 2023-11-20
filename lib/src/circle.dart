import 'dart:math';

import 'package:e_chart/e_chart.dart';
import 'package:flutter/material.dart';

ChartOption circleConfig() {
  return testCircle();
}

ChartOption testCircle() {
  final bs = AreaStyle(color: Colors.grey.withOpacity(0.5));

  var c1 = Colors.blue;
  var c2 = Colors.deepPurple;

  var a1 = AreaStyle(shader: LineShader([c1, c2]));
  var a2 = AreaStyle(shader: RadialShader([c1, c2]));
  var a3 = AreaStyle(shader: SweepShader([c1, c2]));

  var series = CircleSeries(
    buildCircleData(7),
    corner: 24,
    radiusGap: SNumber(8, false),
    radius: SNumber(16, false),
    itemStyleFun: (data) {
      int index = data.dataIndex;
      if (index == 0) {
        return a1.convert(data.status);
      }
      if (index == 1) {
        return a2.convert(data.status);
      }
      if (index == 2) {
        return a3.convert(data.status);
      }
      return AreaStyle(color: randomColor());
    },
    backStyleFun: (data) {
      return bs;
    },
  );
  return ChartOption(
    series: [series],
  );
}

List<CircleData> buildCircleData(int count) {
  Random random = Random(1);
  List<CircleData> gl = [];
  for (var i = 0; i < count; i++) {
    gl.add(CircleData(random.nextDouble(),1));
  }
  return gl;
}
