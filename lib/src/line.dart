import 'dart:math';
import 'package:e_chart/e_chart.dart';
import 'package:flutter/material.dart';

ChartOption lineConfig() {
  return lineGridVConfig2();
}

ChartOption lineGridVConfig2() {
  Grid grid = Grid(xAxisList: [XAxis()], yAxisList: [YAxis()], baseXScale: 2);
  Random random = Random(1);
  List<LineGroupData> list = [];
  for (int i = 0; i < 1; i++) {
    LineGroupData groupData = LineGroupData([]);
    for (int j = 0; j <= 200; j++) {
      int d = random.nextInt(100);
      groupData.data.add(StackData(StackItemData(j, d)));
    }
    list.add(groupData);
  }
  var symbol = CircleSymbol(itemStyle: const AreaStyle(color: Colors.blue), radius: 4);
  var as =AreaStyle(color: Colors.amber);
  var series = LineSeries(
    list,
    coordType: CoordType.grid,
    direction: Direction.vertical,
    symbolFun: (d) {
      if (d.dataIsNull) {
        return EmptySymbol.empty;
      }
      return symbol;
    },
    // areaStyleFun: (d,g){
    //   return as;
    // },
  );
  var config = ChartOption(series: [series], gridList: [grid]);
  config.theme.lineTheme.showSymbol = false;
  config.theme.lineTheme.smooth = 0;
  config.theme.lineTheme.fill = false;
  return config;
}

ChartOption lineGridVConfig() {
  Grid grid = Grid(xAxisList: [
    XAxis(type: AxisType.category, categoryCenter: true, position: Align2.end)
  ], yAxisList: [
    YAxis(max: 200, position: Align2.start),
  ]);
  List<LineGroupData> list = buildLineData(1, 7, []);
  var series = LineSeries(
    list,
    coordType: CoordType.grid,
    direction: Direction.vertical,
  );
  return ChartOption(series: [series], gridList: [grid]);
}

ChartOption lineGridHConfig() {
  Grid grid = Grid(
    yAxisList: [
      YAxis(
        type: AxisType.category,
        categoryList: _weekList,
      )
    ],
    xAxisList: [
      XAxis(max: 200),
    ],
  );
  List<LineGroupData> list = buildLineData(7, 7, ["a", "a", "a", null, null, "b", "b"]);
  var series = LineSeries(
    list,
    animatorStyle: GridAnimatorStyle.expand,
    coordType: CoordType.grid,
    direction: Direction.horizontal,
  );
  return ChartOption(series: [series], gridList: [grid]);
}

ChartOption linePolarVConfig() {
  Polar polar = Polar(
    radius: [const SNumber.percent(45)],
    radiusAxis: RadiusAxis(type: AxisType.category, categoryList: _weekList),
    angleAxis: AngleAxis(max: 360, splitNumber: 12, interval: 30),
  );
  List<LineGroupData> dl = buildLineData(2, 7, [null, null]);
  var series = LineSeries(
    dl,
    coordType: CoordType.polar,
    direction: Direction.vertical,
  );
  var config = ChartOption(series: [series], polarList: [polar]);
  config.theme.lineTheme.showSymbol = false;
  config.theme.lineTheme.smooth = 0.25;
  config.theme.lineTheme.fill = true;
  return config;
}

ChartOption linePolarHConfig() {
  Polar polar = Polar(
    radius: [const SNumber.percent(45)],
    radiusAxis: RadiusAxis(
      offsetAngle: -90,
      max: 100,
      splitNumber: 10,
      interval: 20,
    ),
    angleAxis: AngleAxis(type: AxisType.category, categoryList: _weekList, offsetAngle: -90),
  );
  var series = LineSeries(
    buildLineData(3, 7, ["a", "b", "c"]),
    animatorStyle: GridAnimatorStyle.originExpand,
    coordType: CoordType.polar,
    direction: Direction.horizontal,
  );
  var config = ChartOption(series: [series], polarList: [polar]);
  config.theme.lineTheme.showSymbol = false;
  config.theme.lineTheme.smooth = 0;
  config.theme.lineTheme.fill = true;
  return config;
}

List<LineGroupData> buildLineData([int groupCount = 7, int itemCount = 7, List<String?> stackIds = const []]) {
  if (groupCount > 7) {
    groupCount = 7;
  }
  if (itemCount > 7) {
    itemCount = 7;
  }
  List<LineGroupData> list = [];
  Random random = Random(1);
  for (int i = 0; i < groupCount; i++) {
    String? stackId;
    if (i < stackIds.length) {
      stackId = stackIds[i];
    }
    LineGroupData groupData = LineGroupData([], stackId: stackId);
    for (int j = 0; j < itemCount; j++) {
      groupData.data.add(StackData(StackItemData(_weekList[j], (random.nextInt(50) + 10))));
    }
    list.add(groupData);
  }
  return list;
}

List<String> _weekList = ['Mon', 'Tue', "Wed", "Thu", "Fri", "Sat", "Sun"];
