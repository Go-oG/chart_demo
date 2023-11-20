import 'package:chart_demo/src/data/tree_data.dart';
import 'package:e_chart/e_chart.dart';
import 'package:flutter/material.dart';

ChartOption packConfig() {
  return ChartOption(series: [testPack()]);
}

ChartSeries testPack() {
  LabelStyle style = const LabelStyle(textStyle: TextStyle(color: Colors.black87, fontSize: 15));
  return PackSeries(
    loadTreeData<PackData>((p, v, n) {
      return PackData(p, [], value: v, name: n.toText());
    }),
    labelStyleFun: (node) {
      if (node.parent == null || node.hasChild) {
        return LabelStyle.empty;
      }
      return style;
    },
  );
}
