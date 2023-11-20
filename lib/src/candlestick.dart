import 'package:chart_demo/src/data/candlestick_data.dart';
import 'package:e_chart/e_chart.dart';
import 'package:flutter/material.dart';

ChartOption candlestickOption() {
  XAxis xAxis = XAxis(
      type: AxisType.category,
      categoryCenter: false,
      splitLine: SplitLine(interval: 5, style: const LineStyle(color: Colors.black12)));
  xAxis.axisLabel.interval = 5;
  xAxis.axisTick.tick = MainTick(interval: 5);

  YAxis yAxis1 = YAxis(
    type: AxisType.value,
    position: Align2.start,
    start0: false,
  );
  yAxis1.axisTick.show = true;
  yAxis1.axisTick.tick = MainTick(inside: true);
  yAxis1.axisLabel.inside = true;

  Grid grid = Grid(
    xAxisList: [xAxis],
    yAxisList: [yAxis1],
    baseXScale: 6,
  );

  var series = CandleStickSeries([loadCandleStickData(0, 600)], dynamicRange: true, labelStyleFun: (a) {
    return null;
  });

  return ChartOption(series: [series], gridList: [grid]);

}
