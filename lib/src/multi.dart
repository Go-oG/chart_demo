import 'dart:math';

import 'package:e_chart/e_chart.dart';
import 'package:flutter/material.dart';

ChartOption testMulti() {
  Random random = Random(1);
  List<PieData> pieList = [];
  for (int i = 0; i < 10; i++) {
    pieList.add(PieData(random.nextInt(20) + 8));
  }

  var pieSeries = PieSeries(pieList,
      roseType: RoseType.area,
      leftMargin: const SNumber.number(100),
      topMargin: const SNumber.number(50),
      width: const SNumber.number(400),
      height: const SNumber.number(400),
      innerRadius: SNumber.percent(5),
      outerRadius: SNumber.percent(20));
  List<PieData> pieList2 = [];
  for (int i = 0; i < 10; i++) {
    pieList2.add(PieData(random.nextInt(30) + 8));
  }

  var pieSeries2 = PieSeries(pieList2,
      leftMargin: const SNumber.number(100),
      topMargin: const SNumber.number(50),
      width: const SNumber.number(400),
      height: const SNumber.number(400),
      innerRadius: SNumber.percent(25),
      outerRadius: SNumber.percent(45));

  List<FunnelData> funnelList = [];
  funnelList.add(FunnelData(20, name: DynamicText.fromString('Order')));
  funnelList.add(FunnelData(40, name: DynamicText.fromString('Click')));
  funnelList.add(FunnelData(60, name: DynamicText.fromString('Visit')));
  funnelList.add(FunnelData(80, name: DynamicText.fromString('Inquiry')));
  funnelList.add(FunnelData(100, name: DynamicText.fromString('Show')));
  var style = const LabelStyle(textStyle: TextStyle(color: Colors.white));

  var funnelSeries = FunnelSeries(
    funnelList,
    labelStyleFun: ((d) {
      return style;
    }),
    direction: Direction.vertical,
    align: Align2.center,
    maxValue: 100,
    gap: 0,
    sort: Sort.asc,
    leftMargin: const SNumber.number(510),
    topMargin: const SNumber.number(100),
    width: const SNumber.number(300),
    height: const SNumber.number(300),
  );

  return ChartOption(series: [pieSeries2, pieSeries, funnelSeries]);
}
