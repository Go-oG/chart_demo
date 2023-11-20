import 'dart:convert';
import 'package:e_chart/e_chart.dart';

import 'package:flutter/cupertino.dart';

const _json =
    '[{"children":[{"value":5,"children":[{"value":1,"itemStyle":{"color":"#F54F4A"}},{"value":2,"children":[{"value":1,"itemStyle":{"color":"#FF8C75"}}]},{"children":[{"value":1}]}],"itemStyle":{"color":"#F54F4A"}},{"value":10,"children":[{"value":6,"children":[{"value":1,"itemStyle":{"color":"#F54F4A"}},{"value":1},{"value":1,"itemStyle":{"color":"#FF8C75"}},{"value":1}],"itemStyle":{"color":"#FFB499"}},{"value":2,"children":[{"value":1}],"itemStyle":{"color":"#FFB499"}},{"children":[{"value":1,"itemStyle":{"color":"#FF8C75"}}]}],"itemStyle":{"color":"#F54F4A"}}],"itemStyle":{"color":"#F54F4A"}},{"value":9,"children":[{"value":4,"children":[{"value":2,"itemStyle":{"color":"#FF8C75"}},{"children":[{"value":1,"itemStyle":{"color":"#F54F4A"}}]}],"itemStyle":{"color":"#F54F4A"}},{"children":[{"value":3,"children":[{"value":1},{"value":1,"itemStyle":{"color":"#FF8C75"}}]}],"itemStyle":{"color":"#FFB499"}}],"itemStyle":{"color":"#FF8C75"}},{"value":7,"children":[{"children":[{"value":1,"itemStyle":{"color":"#FFB499"}},{"value":3,"children":[{"value":1,"itemStyle":{"color":"#FF8C75"}},{"value":1}],"itemStyle":{"color":"#FF8C75"}},{"value":2,"children":[{"value":1},{"value":1,"itemStyle":{"color":"#F54F4A"}}],"itemStyle":{"color":"#F54F4A"}}],"itemStyle":{"color":"#FFB499"}}],"itemStyle":{"color":"#F54F4A"}},{"children":[{"value":6,"children":[{"value":1,"itemStyle":{"color":"#FF8C75"}},{"value":2,"children":[{"value":2,"itemStyle":{"color":"#FF8C75"}}],"itemStyle":{"color":"#F54F4A"}},{"value":1,"itemStyle":{"color":"#FFB499"}}],"itemStyle":{"color":"#FFB499"}},{"value":3,"children":[{"value":1},{"children":[{"value":1,"itemStyle":{"color":"#FF8C75"}}]},{"value":1}],"itemStyle":{"color":"#FFB499"}}],"itemStyle":{"color":"#F54F4A"}}]';

SunburstData _parseJson(SunburstData? parent, Map<String, dynamic> map) {
  double value = (map['value'] ?? 0).toDouble();
  String? color = map['itemStyle']?['color'];
  Color? colorInt;
  if (color != null) {
    color = 'FF${color.substring(1)}';
    colorInt = Color(int.parse(color, radix: 16));
  }
  String label = value > 0 ? 'V${formatNumber(value)}' : '';

  SunburstData data = SunburstData(parent,[],value, name: label.toText());

  List<dynamic> children = map['children'] ?? [];
  for (var element in children) {
    data.add(_parseJson(data,element));
  }
  return data;
}

ChartOption sunburstConfig() {
  return ChartOption(series: [testSunburst()]);
}

ChartSeries testSunburst() {
  List<SunburstData> list = [];
  List<dynamic> jsonList = const JsonDecoder().convert(_json);
  SunburstData root = SunburstData(null,[],0);
  for (int i = 0; i < jsonList.length; i++) {
    Map<String, dynamic> map = jsonList[i];
    list.add(_parseJson(root,map));
  }
  root.addAll(list);
  return SunburstSeries(
    root,
    sort: Sort.none,
    selectedMode: SelectedMode.group,
    radius: const [SNumber.number(30), SNumber.percent(30)],
    angleGap: 1,
    radiusGap: 2,
    matchParent: true,
  );
}

String formatNumber(num number, [int fractionDigits = 2]) {
  String s = number.toStringAsFixed(fractionDigits);
  int index = s.indexOf('.');
  if (index == -1) {
    return s;
  }

  while (s.isNotEmpty) {
    if (s.endsWith('0')) {
      s = s.substring(0, s.length - 1);
    } else if (s.endsWith('.')) {
      s = s.substring(0, s.length - 1);
      break;
    } else {
      break;
    }
  }
  if (s.isEmpty) {
    return '0';
  }
  return s;
}
