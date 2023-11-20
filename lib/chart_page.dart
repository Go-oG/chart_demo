import 'package:chart_demo/main.dart';
import 'package:chart_demo/src/bar.dart';
import 'package:chart_demo/src/boxplot.dart';
import 'package:chart_demo/src/candlestick.dart';
import 'package:chart_demo/src/chord.dart';
import 'package:chart_demo/src/circle.dart';
import 'package:chart_demo/src/custom_chart.dart';
import 'package:chart_demo/src/delaunator.dart';
import 'package:chart_demo/src/funnel.dart';
import 'package:chart_demo/src/graph.dart';
import 'package:chart_demo/src/heatmap.dart';
import 'package:chart_demo/src/hex_bin.dart';
import 'package:chart_demo/src/line.dart';
import 'package:chart_demo/src/multi.dart';
import 'package:chart_demo/src/pack.dart';
import 'package:chart_demo/src/page/bar_realtimesort.dart';
import 'package:chart_demo/src/paraller.dart';
import 'package:chart_demo/src/pie.dart';
import 'package:chart_demo/src/point.dart';
import 'package:chart_demo/src/polar.dart';
import 'package:chart_demo/src/radar.dart';
import 'package:chart_demo/src/sankey.dart';
import 'package:chart_demo/src/sunburst.dart';
import 'package:chart_demo/src/theme_river.dart';
import 'package:chart_demo/src/tree.dart';
import 'package:chart_demo/src/tree_map.dart';
import 'package:flutter/material.dart';

import 'content_page.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return ChartPageState();
  }
}

class ChartPageState extends State<ChartPage> {
  ConfigData2? _curItem;

  List<ConfigData2> _data = [];
  int curIndex = -1;

  @override
  void initState() {
    super.initState();
    _data = buildData();
  }

  @override
  void didUpdateWidget(ChartPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    _data = buildData();
    _curItem = null;
  }

  @override
  Widget build(BuildContext context) {
    var list = ListView.builder(
      itemBuilder: (ctx, index) {
        var data = _data[index];
        return _buildItem(index, data);
      },
      itemCount: _data.length,
    );
    Widget? cw;
    if (_curItem != null) {
      cw = _curItem?.builder.call();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _curItem?.name ?? 'chartDemo',
          style: const TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
      body: Container(
          color: Colors.white,
          height: double.infinity,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            textDirection: TextDirection.ltr,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 200,
                height: double.infinity,
                color: Colors.black12,
                child: list,
              ),
              Expanded(
                  child: Container(
                width: double.infinity,
                height: double.infinity,
                padding: const EdgeInsets.all(24),
                child: cw,
              ))
            ],
          )),
    );
  }

  Widget _buildItem(int index, ConfigData2 data) {
    BoxDecoration? decoration;
    if (data.select) {
      decoration = BoxDecoration(color: Colors.blueAccent.withOpacity(0.8));
    }
    var item = Container(
      decoration: decoration,
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      height: 56,
      alignment: Alignment.centerLeft,
      child: Text(
        data.name,
        style: const TextStyle(color: Colors.black87, fontSize: 32),
      ),
    );
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          if (index == curIndex) {
            return;
          }
          curIndex = index;
          setState(() {
            _curItem?.select = false;
            _curItem = data;
            _curItem?.select = true;
          });
        },
        child: item);
  }

  List<ConfigData2> buildData() {
    List<ConfigData2> rl = [];
    rl.add(ConfigData2('Multi', () => ContentPage(ConfigData('Multi', testMulti()))));
    rl.add(ConfigData2('Bar', () => ContentPage(ConfigData('Bar', barConfig()))));
    rl.add(ConfigData2('BarRealSort', () => const BarRealSortPage()));
    rl.add(ConfigData2('Boxplot', () => ContentPage(ConfigData('Boxplot', boxplotOption()))));
    rl.add(ConfigData2('Candlestick', () => ContentPage(ConfigData('Candlestick', candlestickOption()))));
    rl.add(ConfigData2('Chord', () => ContentPage(ConfigData('Chord', chordConfig()))));
    rl.add(ConfigData2('Circle', () => ContentPage(ConfigData('Circle', circleConfig()))));
    rl.add(ConfigData2('Delaunator', () => ContentPage(ConfigData('Delaunator', delaunayConfig()))));
    rl.add(ConfigData2('Funnel', () => ContentPage(ConfigData('Funnel', funnelConfig()))));
    rl.add(ConfigData2('Graph', () => const GraphPage()));
    rl.add(ConfigData2('HeatMap', () => ContentPage(ConfigData('Heatmap', heatmapConfig()))));
    rl.add(ConfigData2('Hexbin', () => const HexbinPage()));
    rl.add(ConfigData2('Line', () => ContentPage(ConfigData('Line', lineConfig()))));
    rl.add(ConfigData2('Pack', () => ContentPage(ConfigData('Pack', packConfig()))));
    rl.add(ConfigData2('Paraller', () => ContentPage(ConfigData('Paraller', parallelConfig()))));
    rl.add(ConfigData2('Pie', () => const PiePage()));
    rl.add(ConfigData2('Point', () => ContentPage(ConfigData('Point', pointConfig()))));
    rl.add(ConfigData2('Polar', () => ContentPage(ConfigData('Polar', polarConfig()))));
    rl.add(ConfigData2('Radar', () => const RadarPage()));
    rl.add(ConfigData2('Sankey', () => ContentPage(ConfigData('Sankey', sankeyConfig()))));
    rl.add(ConfigData2('Sunburst', () => ContentPage(ConfigData('Sunburst', sunburstConfig()))));
    rl.add(ConfigData2('ThemeRiver', () => ContentPage(ConfigData('ThemeRiver', themeRiverConfig()))));
    rl.add(ConfigData2('Tree', () => const TreePage()));
    rl.add(ConfigData2('TreeMap', () => ContentPage(ConfigData('TreeMap', treeMapConfig()))));
    // rl.sort((a, b) {
    //   return a.name.compareTo(b.name);
    // });
    rl.add(ConfigData2('Custom', () => const CustomPage()));
    return rl;
  }
}

class ConfigData2 {
  final String name;

  final Widget Function() builder;

  bool select = false;

  ConfigData2(this.name, this.builder);
}
