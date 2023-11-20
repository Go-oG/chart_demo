import 'dart:math';

import 'package:e_chart/e_chart.dart';
import 'package:flutter/material.dart';

ChartOption pointConfig() {
  return testPointForGrid();
  return testPointForPolar();
}

ChartOption testPointForGrid() {
  Random random = Random(1);
  var series = PointSeries(buildPointData(1, 20000), coordType: CoordType.grid, symbolFun: (a) {
    return CircleSymbol(
        radius: random.nextInt(24) + 6, itemStyle: AreaStyle(color: Colors.blueAccent.withOpacity(0.2)));
  });

  Grid grid = Grid(
    xAxisList: [XAxis(type: AxisType.value, minInterval: 1)],
    yAxisList: [YAxis()],
    baseXScale: 10,
  );
  return ChartOption(
    gridList: [grid],
    series: [series],
  );
}

ChartOption testPointForPolar() {
  var series = PointSeries(
    buildPointDataForPolar(4, 10),
    coordType: CoordType.polar,
  );

  Polar polar = Polar(
    angleAxis: AngleAxis(splitNumber: 6, max: 360),
    radiusAxis: RadiusAxis(max: 10),
    radius: [SNumber.percent(50)],
  );
  return ChartOption(
    polarList: [polar],
    series: [series],
  );
}

ChartOption testPointForCalendar() {
  var series = PointSeries(
    buildPointDataForTime(1, 10),
    coordType: CoordType.calendar,
  );

  Calendar calendar = Calendar(range: Pair(DateTime(2023, 1, 1), DateTime(2023, 12, 31)));
  return ChartOption(
    calendarList: [calendar],
    series: [series],
  );
}

List<PointData> buildPointData(int groupCount, int childCount) {
  Random random = Random(1);
  List<PointData> gl = [];
  for (var i = 0; i < groupCount; i++) {
    for (var j = 0; j < childCount; j++) {
      var y = random.nextDouble() * 50;
      gl.add(PointData(random.nextDouble() * 500, y));
    }
  }
  return gl;
}

List<PointData> buildPointDataForPolar(int groupCount, int childCount) {
  Random random = Random(2);
  List<PointData> gl = [];
  for (var i = 0; i < groupCount; i++) {
    for (var j = 0; j < childCount; j++) {
      var r = random.nextDouble() * 10;
      var y = random.nextDouble() * 360;
      gl.add(PointData(r, y));
    }
  }
  return gl;
}

List<PointData> buildPointDataForTime(int groupCount, int childCount) {
  Random random = Random();
  List<PointData> gl = [];
  for (var i = 0; i < groupCount; i++) {
    for (var j = 0; j < childCount; j++) {
      var y = random.nextDouble() * 50;
      var time = DateTime(2023, random.nextInt(11) + 1, random.nextInt(24) + 1);
      gl.add(PointData(time, y));
    }
  }
  return gl;
}
