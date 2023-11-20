import 'dart:math';

import 'package:e_chart/e_chart.dart';
import 'package:flutter/material.dart';

ChartOption heatmapConfig() {
  Pair<DateTime> pair = Pair(DateTime(2023, 1, 1), DateTime(2023, 12, 31));
  Calendar calendar = Calendar(
    range: pair,
    cellSize: [60, 60],
  );
  ChartOption config = ChartOption(
    series: [testHeatmap()],
    calendarList: [calendar],
  );
  return config;
}

ChartSeries testHeatmap() {
  List<HeatMapData> dataList = [];
  DateTime time = DateTime(2023, 1, 1);
  DateTime end = DateTime(2023, 12, 31);
  int diff = end.difference(time).inDays;
  Random random = Random();
  for (int i = 0; i < diff; i++) {
    DateTime dd = time.add(Duration(days: i));
    String label = '${dd.month}-${dd.day}';
    HeatMapData data = HeatMapData(dd, dd, random.nextInt(290) + 10, name: DynamicText(label));
    dataList.add(data);
  }
  var s1 = const AreaStyle(color: Colors.blueGrey);
  var s2 = const AreaStyle(color: Colors.blue);
  var s3 = const AreaStyle(color: Colors.red);
  return HeatMapSeries(dataList, coordType: CoordType.calendar, symbolFun: (d) {
    var index=d.dataIndex;
    var status=d.status;
    var size=d.attr.size;
    if (index % 3 == 0) {
      return RectSymbol(itemStyle: s1.convert(status), rectSize: size);
    } else if (index % 3 == 1) {
      return PositiveSymbol(count: 5, itemStyle: s2.convert(status), r: size.shortestSide / 2);
    }
    return PositiveSymbol(count: 8, itemStyle: s3.convert(status), r: size.shortestSide / 2);
  });
}
