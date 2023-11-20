import 'package:e_chart/e_chart.dart';
import 'package:flutter/material.dart';

ChartOption funnelConfig() {
  return ChartOption(
    series: [testFunnel()],
  );
}

ChartSeries testFunnel() {
  List<FunnelData> list = [];
  list.add(FunnelData(20, name: DynamicText.fromString('Order')));
  list.add(FunnelData(40, name: DynamicText.fromString('Click')));
  list.add(FunnelData(60, name: DynamicText.fromString('Visit')));
  list.add(FunnelData(80, name: DynamicText.fromString('Inquiry')));
  list.add(FunnelData(100, name: DynamicText.fromString('Show')));
  LabelStyle style = const LabelStyle(textStyle: TextStyle(color: Colors.white));
  return FunnelSeries(
    list,
    labelStyleFun: ((d) {
      return style;
    }),
    direction: Direction.vertical,
    align: Align2.center,
    maxValue: 100,
    gap: 0,
    sort: Sort.asc,
  );
}
