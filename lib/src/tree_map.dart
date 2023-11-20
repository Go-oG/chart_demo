import 'package:chart_demo/src/data/tree_data.dart';
import 'package:e_chart/e_chart.dart';
import 'package:flutter/material.dart';

ChartOption treeMapConfig() {
  return ChartOption(series: [testTreeMap()]);
}

ChartSeries testTreeMap() {
  LabelStyle s = const LabelStyle(textStyle: TextStyle(fontSize: 13, color: Colors.black),overFlow: OverFlow.scale);
  return TreeMapSeries(
    loadTreeData<TreeMapData>((p, d, n) {
      return TreeMapData(p, [], d,name: n.toText());
    }),
    layout: SquareLayout(),
    initShowDepth: 3,
    paddingTop: (a) {
      return 1;
    },
    paddingLeft: (a) {
      return 1;
    },
    paddingRight: (a) {
      return 1;
    },
    paddingBottom: (a) {
      return 1;
    },
    paddingInner: (a) {
      return 2;
    },
    labelStyleFun: (tmp, [action]) {
      return s;
    },
    labelAlignFun: (a) {
      return Alignment.topLeft;
    },
  );
}

TreeMapData? parseJson(Map<String, dynamic> map, Map<TreeMapData, AreaStyle> styleMap) {
  num value = map['value'];
  if (value <= 0) {
    return null;
  }
  String name = map['name'];
  List<dynamic> children = map['children'] ?? [];
  List<TreeMapData> childrenList = [];
  for (var element in children) {
    TreeMapData? d = parseJson(element, styleMap);
    if (d != null) {
      childrenList.add(d);
      styleMap[d] = AreaStyle(color: randomColor());
    }
  }
  var data = TreeMapData(null, [], value, name: name.toText());
  data.addAll(childrenList);
  styleMap[data] = AreaStyle(color: randomColor());
  return data;
}

TreeMapData convertData(dynamic d) {
  num value = (d['value'] ?? 0).toDouble();
  List<TreeMapData> cl = [];
  TreeMapData root = TreeMapData(null, [], value, name: d['name']);
  List<dynamic> dl = d['children'] ?? [];
  for (var element in dl) {
    cl.add(convertData(element));
  }
  root.addAll(cl);
  return root;
}
