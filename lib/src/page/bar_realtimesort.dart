import 'dart:async';
import 'dart:math';

import 'package:e_chart/e_chart.dart';
import 'package:flutter/material.dart';

class BarRealSortPage extends StatefulWidget {
  const BarRealSortPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return BarRealSortState();
  }
}

class BarRealSortState extends State<BarRealSortPage> {
  late BarSeries series;
  late ChartOption option;
  Timer? timer;
  Random random = Random(1);
  late BarGroupData groupData;
  int index = 0;
  var duration = const Duration(milliseconds: 1200);
  var duration2 = const Duration(milliseconds: 1201);

  @override
  void initState() {
    super.initState();
    var yAxis = YAxis(type: AxisType.category);
    yAxis.axisLabel.inside = true;
    yAxis.axisTick.tick?.inside = true;
    Grid grid = Grid(
      yAxisList: [yAxis],
      xAxisList: [XAxis(type: AxisType.value,splitNumber: 10)],
    );
    groupData = BarGroupData([]);
    index = 10;
    for (int i = 0; i < index; i++) {
      var d=StackItemData(random.nextInt(100) + 1, "$i", id: '$i');
      groupData.data.add(StackData(d));
    }
    Map<String, AreaStyle> styleMap = {};
    var animator = AnimatorOption(
      duration: duration,
      updateDuration: duration,
      curve: Curves.linear,
      updateCurve: Curves.linear,
    );
    series = BarSeries(
      [groupData],
      coordType: CoordType.grid,
      direction: Direction.horizontal,
      realtimeSort: true,
      dynamicLabel: true,
      dynamicRange: true,
      animation: animator,
      sortCount: 10,
      animatorStyle: GridAnimatorStyle.originExpand,
      sort: Sort.asc,
      areaStyleFun: (a,b) {
        if (a.dataIsNull) {
          return null;
        }
        AreaStyle style = styleMap[a.id] ?? AreaStyle(color: randomColor());
        styleMap[a.id] = style;
        return style;
      },
    );
    option = ChartOption(series: [series], gridList: [grid]);
  }

  @override
  Widget build(BuildContext context) {
    Widget w = Container(
        alignment: Alignment.center,
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Chart(option),
        ));
    Widget cl = Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          children: [
            ElevatedButton(
                onPressed: () {
                  if (timer != null) {
                    return;
                  }
                  timer = Timer.periodic(duration2, (timer) {
                    //  if (random.nextDouble() <= 0.9) {
                    for (var d in groupData.data) {
                      d.dataNull?.domain = d.dataNull?.domain + random.nextInt(50);
                    }
                    // } else {
                    //   var item = StackItemData((random.nextDouble() * 90 + 1), "${index + 1}");
                    //   index += 1;
                    //   groupData.data.add(item);
                    // }
                    series.notifyUpdateData();
                  });
                },
                child: const Text("Start")),
            ElevatedButton(
                onPressed: () {
                  timer?.cancel();
                  timer = null;
                },
                child: const Text("Stop")),
          ],
        ),
        Expanded(child: w),
      ],
    );
    return cl;
  }
}
