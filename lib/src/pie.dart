import 'dart:math';

import 'package:e_chart/e_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as md;

import 'base/base_state.dart';

class PiePage extends StatefulWidget {
  const PiePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return PieState();
  }
}

class PieState extends BaseState<PiePage> {
  static const double textSize = 20;
  List<PieData> dataList = [];
  int dataCount = 10;
  SNumber ir = const SNumber.percent(15);
  SNumber or = const SNumber.percent(50);
  double sweepAngle = 360;
  double offsetAngle = 0;
  double corner = 0;
  double angleGap = 2;

  RoseType roseType = RoseType.normal;
  bool showLabel = true;
  CircleAlign labelAlign = CircleAlign.inside;
  PieAnimatorStyle style = PieAnimatorStyle.originExpand;
  SNumber centerX = const SNumber(50, true);
  SNumber centerY = const SNumber(50, true);

  late PieSeries series;
  late ChartOption config;

  @override
  void initState() {
    super.initState();
    dataList = buildData(dataCount);
    LabelStyle labelStyle = const LabelStyle();
    series = PieSeries(
      dataList,
      labelStyleFun: (a) {
        if (showLabel) {
          return labelStyle;
        }
        return LabelStyle.empty;
      },);
    config = ChartOption(series: [series]);
  }

  @override
  void didUpdateWidget(covariant PiePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    series.notifyUpdateData();
  }

  List<PieData> buildData(int c) {
    List<PieData> list = [];
    Random random = Random();
    for (int i = 0; i < dataCount; i++) {
      list.add(PieData(random.nextDouble() * dataCount + 5, name: 'L$i'.toText()));
    }
    return list;
  }

  @override
  ChartOption buildConfig() {
    series.data = dataList;
    series.center = [centerX, centerY];
    series.sweepAngle = sweepAngle;
    series.angleGap = angleGap;
    series.innerRadius = ir;
    series.outerRadius = or;
    series.labelAlign = labelAlign;
    series.corner = corner;
    series.offsetAngle = offsetAngle;
    series.roseType = roseType;
    series.animatorStyle = style;
    series.notifyConfigChange();
    return config;
  }

  @override
  Widget buildTitle() {
    Widget r1 = SingleChildScrollView(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildItem('DataCount:$dataCount', dataCount, 0, 40, (v) {
          setState(() {
            dataCount = v.toInt();
            dataList = buildData(dataCount);
          });
        }),
        md.Row(children: [
          Expanded(
              child: buildItem('innerRadius:${ir.number.toStringAsFixed(2)}%', ir.number, 0, 50, (v) {
            setState(() {
              ir = SNumber.percent(v);
            });
          })),
          const md.SizedBox(width: 16),
          Expanded(
              child: buildItem('outerRadius:${or.number.toStringAsFixed(2)}%', or.number, 10, 100, (v) {
            setState(() {
              or = SNumber.percent(v);
            });
          })),
        ]),
        md.Row(children: [
          Expanded(
              child: buildItem('sweepAngle:${sweepAngle.toStringAsFixed(2)}', sweepAngle, -360, 360, (v) {
            setState(() {
              sweepAngle = v;
            });
          })),
          const md.SizedBox(width: 16),
          Expanded(
              child: buildItem('offsetAngle:${offsetAngle.toStringAsFixed(2)}', offsetAngle, 0, 359, (v) {
            setState(() {
              offsetAngle = v;
            });
          })),
        ]),
        md.Row(children: [
          Expanded(
              child: buildItem('corner:${corner.toStringAsFixed(2)}', corner, 0, 24, (v) {
            setState(() {
              corner = v;
            });
          })),
          const md.SizedBox(width: 16),
          Expanded(
              child: buildItem('angleGap:${angleGap.toStringAsFixed(2)}', angleGap, 0, 12, (v) {
            setState(() {
              angleGap = v;
            });
          })),
        ]),
        md.Row(children: [
          Expanded(
              child: buildItem("x", centerX.number, 0, 100, (v) {
            setState(() {
              centerX = SNumber(v, true);
            });
          })),
          const md.SizedBox(width: 16),
          Expanded(
              child: buildItem("y", centerY.number, 0, 100, (v) {
            setState(() {
              centerY = SNumber(v, true);
            });
          })),
        ]),
      ],
    ));

    Widget r2 = SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ///roseType
        const Text(
          'roseType',
          style: TextStyle(color: Colors.black87, fontSize: textSize),
        ),
        md.Wrap(textDirection: TextDirection.ltr, children: [
          buildCheck('Normal', (p0) {
            if (p0) {
              setState(() {
                roseType = RoseType.normal;
              });
            }
          }, roseType == RoseType.normal),
          buildCheck('Radius', (p0) {
            if (p0) {
              setState(() {
                roseType = RoseType.radius;
              });
            }
          }, roseType == RoseType.radius),
          buildCheck('Area', (p0) {
            if (p0) {
              setState(() {
                roseType = RoseType.area;
              });
            }
          }, roseType == RoseType.area),
        ]),
        buildCheck2('showLabel:', (p0) {
          setState(() {
            showLabel = p0;
          });
        }, showLabel),

        ///labelAlign
        const Text(
          'labelAlign',
          style: TextStyle(color: Colors.black87, fontSize: textSize),
        ),
        md.Wrap(textDirection: TextDirection.ltr, children: [
          buildCheck('inside', (p0) {
            if (p0) {
              setState(() {
                labelAlign = CircleAlign.inside;
              });
            }
          }, labelAlign == CircleAlign.inside),
          buildCheck('outSide', (p0) {
            if (p0) {
              setState(() {
                labelAlign = CircleAlign.outside;
              });
            }
          }, labelAlign == CircleAlign.outside),
          buildCheck('center', (p0) {
            if (p0) {
              setState(() {
                labelAlign = CircleAlign.center;
              });
            }
          }, labelAlign == CircleAlign.center),
        ]),

        ///AnimatorStyle
        const Text(
          'animatorStyle',
          style: TextStyle(color: Colors.black87, fontSize: textSize),
        ),
        md.Wrap(textDirection: TextDirection.ltr, children: [
          buildCheck('expand', (p0) {
            if (p0) {
              setState(() {
                style = PieAnimatorStyle.expand;
              });
            }
          }, style == PieAnimatorStyle.expand),
          buildCheck('expandScale', (p0) {
            if (p0) {
              setState(() {
                style = PieAnimatorStyle.expandScale;
              });
            }
          }, style == PieAnimatorStyle.expandScale),
          buildCheck('originExpand', (p0) {
            if (p0) {
              setState(() {
                style = PieAnimatorStyle.originExpand;
              });
            }
          }, style == PieAnimatorStyle.originExpand),
          buildCheck('originExpandScale', (p0) {
            if (p0) {
              setState(() {
                style = PieAnimatorStyle.originExpandScale;
              });
            }
          }, style == PieAnimatorStyle.originExpandScale),
        ]),
      ],
    ));

    return Container(
      constraints: const BoxConstraints(maxHeight: 300, minWidth: double.infinity),
      child: Row(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(child: r1),
        const md.SizedBox(width: 16),
        Expanded(child: r2),
      ]),
    );
  }

  Widget buildItem(String title, num value, num min, num max, void Function(double v) onChanged) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.black87, fontSize: textSize),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 4),
          child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                overlayShape: SliderComponentShape.noOverlay,
              ),
              child: Slider(
                value: value.toDouble(),
                onChanged: onChanged,
                min: min.toDouble(),
                max: max.toDouble(),
              )),
        ),
      ],
    );
  }

  @override
  String get title => 'Pie';
}
