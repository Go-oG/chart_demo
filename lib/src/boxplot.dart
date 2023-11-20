import 'dart:math';

import 'package:e_chart/e_chart.dart';

ChartOption boxplotOption() {
  XAxis xAxis = XAxis(type: AxisType.category);
  YAxis yAxis1 = YAxis(type: AxisType.value, position: Align2.start);
  yAxis1.axisLabel.inside = true;
  yAxis1.axisTick.show = true;
  yAxis1.axisTick.tick = MainTick(inside: true);
  Grid grid = Grid(xAxisList: [xAxis], yAxisList: [yAxis1]);
  List<BoxplotGroup> gl = [];
  var random = Random(1);
  for (int i = 0; i < 2; i++) {
    BoxplotGroup gd = BoxplotGroup([]);
    for (int j = 0; j < 10; j++) {
      num minv = random.nextDouble() * 5;
      num downV = minv + random.nextDouble() * 5;
      num mv = downV + random.nextDouble() * 5;
      num upV = mv + random.nextDouble() * 5;
      num maxV = upV + random.nextDouble() * 5;
      var t = BoxplotData(x: "${j + 1}", min: minv, downAve4: downV, middle: mv, upAve4: upV, max: maxV);
      gd.data.add(StackData(t));
    }
    gl.add(gd);
  }

  var series = BoxplotSeries(
    gl,
    coordType: CoordType.grid,
    direction: Direction.vertical,
    columnGap: const SNumber.percent(10),
    groupGap: const SNumber.percent(
      10,
    ),
  );

  var config = ChartOption(series: [series], gridList: [grid]);

  return config;
}
