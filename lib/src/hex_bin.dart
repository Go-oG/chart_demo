import 'package:chart_demo/src/base/base_state.dart';
import 'package:e_chart/e_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as md;

class HexbinPage extends StatefulWidget {
  const HexbinPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return HexbinState();
  }
}

class HexbinState extends BaseState<HexbinPage> {
  List<HexBinData> dataList = [];
  double radius = 16;
  Map<String, HexbinLayout> layoutMap = {};
  String curKey = 'Hexagons1';
  bool flat = true;
  SNumber centerX = const SNumber(50, true);
  SNumber centerY = const SNumber(50, true);

  late HexbinSeries series;
  late ChartOption option;

  @override
  void initState() {
    super.initState();
    layoutMap['Hexagons1'] = HexagonsLayout(clockwise: true);
    layoutMap['Hexagons2'] = HexagonsLayout(clockwise: false);
    layoutMap['ParallelSQ'] = HexParallelLayout(type: HexParallelLayout.typeSQ);
    layoutMap['ParallelQR'] = HexParallelLayout(type: HexParallelLayout.typeQR);
    layoutMap['ParallelRS'] = HexParallelLayout(type: HexParallelLayout.typeRS);
    layoutMap['Rect1'] = HexRectLayout(rowPriority: true, evenLineIndent: true);
    layoutMap['Rect2'] = HexRectLayout(rowPriority: true, evenLineIndent: false);
    layoutMap['Rect3'] = HexRectLayout(rowPriority: false, evenLineIndent: true);
    layoutMap['Rect4'] = HexRectLayout(rowPriority: false, evenLineIndent: false);
    layoutMap['Triangle1'] = HexTriangleLayout(direction: Direction2.ttb);
    layoutMap['Triangle2'] = HexTriangleLayout(direction: Direction2.btt);
    layoutMap['Triangle3'] = HexTriangleLayout(direction: Direction2.ltr);
    layoutMap['Triangle4'] = HexTriangleLayout(direction: Direction2.rtl);
    curKey = 'Hexagons1';
    dataList = buildData(50);
    series = HexbinSeries(dataList, radius: radius, flat: flat, center: [centerX, centerY], layout: layoutMap[curKey]!);
    option = ChartOption(series: [series]);
  }

  @override
  ChartOption buildConfig() {
    HexbinLayout? lay = layoutMap[curKey];
    if (lay == null) {
      curKey = 'Hexagons1';
      lay = layoutMap[curKey]!;
    }
    series.radius = radius;
    series.flat = flat;
    series.center = [centerX, centerY];
    series.layout = lay;
    series.data = dataList;
    series.notifyConfigChange();
    return option;
  }

  @override
  Widget buildTitle() {
    List<List<String>> keyList = [];
    keyList.add(['Hexagons1', 'Hexagons2']);
    keyList.add(['ParallelQR', 'ParallelRS', 'ParallelSQ']);
    keyList.add(['Rect1', 'Rect2', 'Rect3', 'Rect4']);
    keyList.add(['Triangle1', 'Triangle2', 'Triangle3', 'Triangle4']);

    List<Widget> cl = [];
    for (var list in keyList) {
      List<Widget> wl = [];
      for (var key in list) {
        wl.add(buildCheck(key, (p0) {
          handleClick(key, p0);
        }, curKey == key));
      }
      cl.add(
        md.Wrap(textDirection: TextDirection.ltr, children: wl),
      );
    }

    return Container(
      constraints: const BoxConstraints(maxHeight: 250),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: SingleChildScrollView(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildCheck('Flat', (p0) {
                    setState(() {
                      flat = p0;
                    });
                  }, flat),
                  Text(
                    'DataCount:${dataList.length}',
                    style: const TextStyle(color: Colors.black87, fontSize: 14),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(overlayShape: SliderComponentShape.noOverlay),
                        child: Slider(
                          value: dataList.length.toDouble(),
                          onChanged: (v) {
                            setState(() {
                              dataList = buildData(v.toInt());
                            });
                          },
                          min: 10,
                          max: 100,
                          divisions: 9,
                        )),
                  ),
                  Text(
                    'Radius: ${radius.toStringAsFixed(2)}',
                    style: const TextStyle(color: Colors.black87, fontSize: 14),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(overlayShape: SliderComponentShape.noOverlay),
                        child: Slider(
                            value: radius,
                            onChanged: (v) {
                              setState(() {
                                radius = v;
                              });
                            },
                            min: 16,
                            max: 80,
                            activeColor: Colors.blueAccent,
                            inactiveColor: Colors.grey)),
                  ),
                  Text(
                    'Center:X ${centerX.number.toStringAsFixed(2)} Y:${centerY.number.toStringAsFixed(2)}',
                    style: const TextStyle(color: Colors.black87, fontSize: 14),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(overlayShape: SliderComponentShape.noOverlay),
                        child: Slider(
                            value: centerX.number.toDouble(),
                            onChanged: (v) {
                              setState(() {
                                centerX = SNumber(v, true);
                              });
                            },
                            min: 0,
                            max: 100)),
                  ),
                  SliderTheme(
                      data: SliderTheme.of(context).copyWith(overlayShape: SliderComponentShape.noOverlay),
                      child: Slider(
                          value: centerY.number.toDouble(),
                          onChanged: (v) {
                            setState(() {
                              centerY = SNumber(v, true);
                            });
                          },
                          min: 0,
                          max: 100))
                ],
              )),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
                padding: const EdgeInsets.only(top: 8, right: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          'Layout',
                          style: TextStyle(color: Colors.black87, fontSize: 24),
                        )),
                    md.Wrap(textDirection: TextDirection.ltr, children: cl),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  @override
  String get title => 'Hexbin';

  void handleClick(String key, bool select) {
    setState(() {
      if (select) {
        curKey = key;
      } else {
        curKey = '';
      }
    });
  }

  List<HexBinData> buildData(int c) {
    List<HexBinData> dl = [];
    for (int i = 0; i < c; i++) {
      dl.add(HexBinData(id: '$i', name: DynamicText.fromString('$i')));
    }
    return dl;
  }
}
