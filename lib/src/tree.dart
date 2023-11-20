import 'package:chart_demo/src/data/tree_data.dart';
import 'package:e_chart/e_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as md;

import 'base/base_state.dart';

class TreePage extends StatefulWidget {
  const TreePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return TreeState();
  }
}

class TreeState extends BaseState<TreePage> {
  final Map<String, TreeLayout> layoutMap = {};
  String curKey = 'Compact';
  late TreeData data;
  double nodeSize = 18;
  double gap = 12;
  double levelGap = 24;
  LineType lineType = LineType.line;
  bool smooth = false;
  bool centerIsRoot = true;

  SNumber centerX = const SNumber(50, true);
  SNumber centerY = const SNumber(50, true);
  ChartOption config = ChartOption(series: []);
  TreeSeries? series;

  @override
  void initState() {
    super.initState();
    layoutMap['Compact'] = CompactLayout();
    layoutMap['Dendrogram'] = DendrogramLayout(direction: Direction2.v);
    layoutMap['Indented'] = IndentedLayout();
    layoutMap['MindMap'] = MindMapLayout();
    var radial = RadialTreeLayout(useTidy: true);
    radial.splitFun = (a, b) {
      return (a.parent == b.parent ? 1 : 2) / a.deep;
    };
    layoutMap['Radial'] = radial;
    curKey = 'Compact';
    data = loadTreeData<TreeData>((p, d, n) {
      return TreeData(p, [], value: d);
    }, 3);
  }

  @override
  ChartOption buildConfig() {
    series ??= TreeSeries(data, layoutMap[curKey]!, symbolFun: (d) {
      return CircleSymbol(radius: nodeSize / 2, itemStyle: AreaStyle(color: Colors.black87));
    });
    series?.layout = layoutMap[curKey]!;
    series?.layout.gapFun = (a, b) {
      return Offset(gap, gap);
    };
    series?.layout.levelGapFun = (a, b) {
      return levelGap;
    };
    series?.layout.lineType = lineType;
    series?.center = [centerX, centerY];
    series?.layout.smooth = smooth ? 0.25 : 0;
    series?.rootInCenter = centerIsRoot;
    series!.data = data;
    config.series.clear();
    config.series.add(series!);
    series!.notifyConfigChange();
    return config;
  }

  @override
  Widget buildTitle() {
    List<Widget> wl = [];
    List<String> keys = List.from(layoutMap.keys);
    keys.sort();
    for (var key in keys) {
      wl.add(buildCheck(key, (p0) {
        if (p0) {
          setState(() {
            curKey = key;
          });
        }
      }, curKey == key));
    }
    List<Widget> leftList = [];
    leftList.add(const Text(
      'Layout',
      style: TextStyle(color: Colors.black87, fontSize: 14),
    ));
    leftList.add(md.Wrap(textDirection: TextDirection.ltr, children: wl));
    leftList.add(const Text(
      'LineType',
      style: TextStyle(color: Colors.black87, fontSize: 14),
    ));
    leftList.add(md.Wrap(textDirection: TextDirection.ltr, children: [
      buildCheck('Line', (p0) {
        if (p0) {
          setState(() {
            lineType = LineType.line;
          });
        }
      }, lineType == LineType.line),
      buildCheck('step', (p0) {
        if (p0) {
          setState(() {
            lineType = LineType.step;
          });
        }
      }, lineType == LineType.step),
      buildCheck('stepBefore', (p0) {
        if (p0) {
          setState(() {
            lineType = LineType.before;
          });
        }
      }, lineType == LineType.before),
      buildCheck('stepAfter', (p0) {
        if (p0) {
          setState(() {
            lineType = LineType.after;
          });
        }
      }, lineType == LineType.after),
    ]));
    leftList.add(buildCheck('smooth', (p0) {
      setState(() {
        smooth = p0;
      });
    }, smooth));
    List<Widget> rightList = [];
    rightList.add(buildCheck('centerIsRoot', (p0) {
      setState(() {
        centerIsRoot = p0;
      });
    }, centerIsRoot));
    rightList.add(Text('Size:${nodeSize.toStringAsFixed(2)}', style: const TextStyle(color: Colors.black87, fontSize: 14)));
    rightList.add(Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      child: SliderTheme(
          data: SliderTheme.of(context).copyWith(overlayShape: SliderComponentShape.noOverlay),
          child: Slider(
              value: nodeSize,
              onChanged: (v) {
                setState(() {
                  nodeSize = v;
                });
              },
              min: 8,
              max: 24,
              activeColor: Colors.blueAccent,
              inactiveColor: Colors.grey)),
    ));
    rightList.add(Text(
      'Gap:${gap.toStringAsFixed(2)}',
      style: const TextStyle(color: Colors.black87, fontSize: 14),
    ));
    rightList.add(Padding(
        padding: const EdgeInsets.only(top: 4, bottom: 4),
        child: SliderTheme(
            data: SliderTheme.of(context).copyWith(overlayShape: SliderComponentShape.noOverlay),
            child: Slider(
                value: gap,
                onChanged: (v) {
                  setState(() {
                    gap = v;
                  });
                },
                min: 2,
                max: 36,
                activeColor: Colors.blueAccent,
                inactiveColor: Colors.grey))));
    rightList.add(Text(
      'levelGap:${levelGap.toStringAsFixed(2)}',
      style: const TextStyle(color: Colors.black87, fontSize: 14),
    ));
    rightList.add(Padding(
        padding: const EdgeInsets.only(top: 4, bottom: 4),
        child: SliderTheme(
            data: SliderTheme.of(context).copyWith(overlayShape: SliderComponentShape.noOverlay),
            child: Slider(
                value: levelGap,
                onChanged: (v) {
                  setState(() {
                    levelGap = v;
                  });
                },
                min: 16,
                max: 40,
                activeColor: Colors.blueAccent,
                inactiveColor: Colors.grey))));

    return Container(
      constraints: const BoxConstraints(maxHeight: 300, minWidth: double.infinity),
      child: SingleChildScrollView(
          child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: md.Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: leftList,
            )),
            Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: rightList,
            ))
          ],
        ),
      )),
    );
  }

  @override
  String get title => 'Tree';
}
