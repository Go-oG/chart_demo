import 'dart:math';
import 'package:e_chart/e_chart.dart';
import 'package:flutter/material.dart';

List<String> _weekList = ['Mon', 'Tue', "Wed", "Thu", "Fri", "Sat", "Sun"];

ChartOption barConfig() {
  // return barWaterfallConfig();
  // return barGridVConfig2();
  //  return barPolarHConfig();
  // return barPolarVConfig();
  return barGridVConfig();
}

ChartOption barMulti() {
  // var brush = Brush(supportMulti: false, removeOnClick: true, enable: true, type: BrushType.polygon);
  var xAxisPointer = AxisPointer(show: true, lineStyle: const LineStyle(color: Colors.black45, dash: [3, 8]));
  var yAxisPointer = AxisPointer(show: true, lineStyle: const LineStyle(color: Colors.black45, dash: [3, 8]));

  var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  XAxis xAxis = XAxis(
    type: AxisType.category,
    categoryList: months,
    axisPointer: xAxisPointer,
    categoryCenter: true,
  );
  YAxis yAxis1 = YAxis(
    type: AxisType.value,
    position: Align2.end,
    axisName: AxisName("Evaporation".toText()),
  );
  yAxis1.axisTick.show = false;
  yAxis1.axisLabel.inside = false;

  YAxis yAxis2 = YAxis(
    type: AxisType.value,
    position: Align2.end,
    axisName: AxisName("Precipitation".toText()),
    offset: 80,
  );
  yAxis2.axisTick.show = false;
  yAxis2.axisLabel.inside = false;

  YAxis yAxis3 = YAxis(
    type: AxisType.value,
    position: Align2.start,
    axisName: AxisName("温度".toText()),
    axisPointer: yAxisPointer,
  );
  yAxis3.axisTick.show = false;
  yAxis3.axisLabel.inside = true;

  Grid grid = Grid(
    xAxisList: [xAxis],
    yAxisList: [
      yAxis1,
      yAxis2,
      yAxis3,
    ],
    //  brush: brush,
  );

  List<BarGroupData> gl = [];
  var random = Random(1);
  var data = [2.0, 4.9, 7.0, 23.2, 25.6, 76.7, 135.6, 162.2, 32.6, 20.0, 6.4, 3.3];
  for (int i = 0; i < 4; i++) {
    BarGroupData gd = BarGroupData([], id: "bar${i + 1}");
    gd.valueAxis = 0;
    for (int j = 0; j < data.length; j++) {
      gd.data.add(StackData(StackItemData(months[j], (data[j] + random.nextDouble() * 9))));
    }
    gl.add(gd);
  }
  var barSeries = BarSeries(
    gl,
    coordType: CoordType.grid,
    direction: Direction.vertical,
    columnGap: const SNumber.percent(10),
    groupGap: const SNumber.percent(
      10,
    ),
    markLine: MarkLine(
      MarkPoint(MarkPointData.data(["Jan", 120])),
      MarkPoint(MarkPointData.data(["Dec", 120])),
    ),
    animation: null,
  );

  var data3 = [2.0, 2.2, 3.3, 4.5, 6.3, 10.2, 20.3, 23.4, 23.0, 16.5, 12.0, 6.2];
  LineGroupData group3 = LineGroupData([]);
  group3.valueAxis = 2;
  for (int j = 0; j < data3.length; j++) {
    var t = StackItemData(months[j], data3[j]);
    group3.data.add(StackData(t));
  }
  var lineSeries = LineSeries(
    [group3],
    coordType: CoordType.grid,
    direction: Direction.vertical,
    animation: null,
  );
  List<ChartSeries> seriesList = [barSeries, lineSeries];
  var config = ChartOption(series: seriesList, gridList: [grid]);

  config.theme.categoryAxisTheme.showSplitArea = false;
  config.theme.categoryAxisTheme.showSplitLine = false;

  config.theme.lineTheme.smooth = 0.25;
  config.theme.valueAxisTheme.showSplitArea = false;
  config.theme.valueAxisTheme.showSplitLine = false;
  return config;
}

ChartOption barGridVConfig2() {
  XAxis xAxis = XAxis(min: 0, interval: 1, max: 5);
  xAxis.axisLabel.show = true;
  YAxis yAxis = YAxis(axisTick: AxisTick(tick: MainTick(inside: true)));
  Grid grid = Grid(
    xAxisList: [xAxis],
    yAxisList: [yAxis],
  );
  Random random = Random(1);
  List<BarGroupData> list = [];
  for (int i = 0; i < 2; i++) {
    BarGroupData groupData = BarGroupData([], name: "LegendBar${i + 1}");
    for (int j = 1; j < 5; j++) {
      var t = StackItemData(j, random.nextDouble() * 100);
      groupData.data.add(StackData(t));
    }
    list.add(groupData);
  }
  var series = BarSeries(
    list,
    coordType: CoordType.grid,
    direction: Direction.vertical,
    groupStyleFun: (d) {
      return AreaStyle(color: Colors.grey.withOpacity(0.3));
    },
  );
  var config = ChartOption(
    series: [series],
    gridList: [grid],
    legend: Legend(),
  );
  config.theme.categoryAxisTheme.showSplitArea = true;
  config.theme.valueAxisTheme.showSplitArea = true;
  config.theme.logAxisTheme.showSplitArea = true;
  config.theme.timeAxisTheme.showSplitArea = true;
  return config;
}

ChartOption barGridVConfig() {
  Grid grid = Grid(xAxisList: [
    XAxis(
        type: AxisType.category,
        categoryList: _weekList,
        axisLabel: AxisLabel(
          rotate: -45,
        ))
  ], yAxisList: [
    YAxis()
  ]);
  var list = buildBarData(7, 7, ["a", "a", "a", null, null, "b", "b"], false);
  var series = BarSeries(
    list,
    animatorStyle: GridAnimatorStyle.originExpand,
    coordType: CoordType.grid,
    direction: Direction.vertical,
    corner: const Corner.all(24),
    stackIsPercent: true,

  );

  return ChartOption(series: [
    series,
  ], gridList: [
    grid
  ]);
}

ChartOption barGridHConfig() {
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
  List<BarGroupData> list = buildBarData(7, 7, ["a", "a", "a", null, null, "b", "b"]);
  var series = BarSeries(
    list,
    animatorStyle: GridAnimatorStyle.expand,
    coordType: CoordType.grid,
    direction: Direction.horizontal,
  );
  return ChartOption(series: [series], gridList: [grid]);
}

ChartOption barPolarVConfig() {
  Polar polar = Polar(
    radius: const [SNumber.percent(0), SNumber.percent(40)],
    radiusAxis: RadiusAxis(type: AxisType.category, categoryList: _weekList),
    angleAxis: AngleAxis(max: 360, splitNumber: 12, interval: 30),
  );
  var series = BarSeries(
    buildBarData(2, 7, [null, null, null, null]),
    animatorStyle: GridAnimatorStyle.originExpand,
    coordType: CoordType.polar,
    innerGap: 4,
    direction: Direction.vertical,
  );
  return ChartOption(series: [series], polarList: [polar]);
}

ChartOption barPolarHConfig() {
  var polar = Polar(
    radius: const [SNumber.percent(3), SNumber.percent(45)],
    radiusAxis: RadiusAxis(
      offsetAngle: -90,
      max: 200,
      interval: 20,
    ),
    angleAxis: AngleAxis(
      type: AxisType.category,
      categoryList: _weekList,
      offsetAngle: -90,
    ),
  );
  var data = buildBarData(2, 7, ["a", "a", "a", "a"]);
  each(data, (group, p1) {
    each(group.data, (child, p1) {
      if (child.dataIsNull) {
        return;
      }
      var data = child.data;
      var t = data.domain;
      data.domain = data.value;
      data.value = t;
    });
  });
  var series = BarSeries(
    data,
    animatorStyle: GridAnimatorStyle.originExpand,
    coordType: CoordType.polar,
    direction: Direction.horizontal,
  );
  return ChartOption(series: [series], polarList: [polar]);
}

List<BarGroupData> buildBarData([int groupCount = 7, int itemCount = 7, List<String?> stackIds = const [], bool usePercent = false]) {
  if (groupCount > 7) {
    groupCount = 7;
  }
  if (itemCount > 7) {
    itemCount = 7;
  }
  List<BarGroupData> list = [];
  Random random = Random(1);
  for (int i = 0; i < groupCount; i++) {
    String? stackId;
    if (i < stackIds.length) {
      stackId = stackIds[i];
    }
    BarGroupData groupData = BarGroupData([], stackId: stackId);
    for (int j = 0; j < itemCount; j++) {
      var t = StackItemData(_weekList[j], (random.nextInt(50) + 10));
      groupData.data.add(StackData(t));
    }
    list.add(groupData);
  }

  return list;
}

ChartOption barWaterfallConfig() {
  Grid grid = Grid(xAxisList: [XAxis(type: AxisType.category, categoryList: _weekList)], yAxisList: [YAxis()]);

  List<BarGroupData> list = [];
  Random random = Random(1);
  BarGroupData groupData = BarGroupData([]);
  for (int j = 0; j < 7; j++) {
    var d = random.nextInt(50) + 10;
    var u = d + random.nextInt(15) + 1;
    var t = WaterFallData(_weekList[j], u, d);
    groupData.data.add(StackData(t));
  }
  list.add(groupData);
  var series = BarSeries(
    list,
    animatorStyle: GridAnimatorStyle.originExpand,
    coordType: CoordType.grid,
    direction: Direction.vertical,
    corner: const Corner.all(24),
  );
  return ChartOption(series: [
    series,
  ], gridList: [
    grid
  ]);
}
