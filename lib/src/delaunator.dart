import 'dart:math';
import 'dart:ui';
import 'package:e_chart/e_chart.dart';

ChartOption delaunayConfig() {
  List<ChartOffset> dl = [];
  int row = 30;
  int col = 30;
  num cellWidth = 100;
  num cellHeight = 100;
  Random random = Random(1);
  for (int i = 0; i < row; i++) {
    for (int j = 0; j < col; j++) {
      var x = cellWidth * j + cellWidth * random.nextDouble();
      var y = cellHeight * i + cellHeight * random.nextDouble();
      dl.add(ChartOffset(x, y));
    }
  }

  var series = DelaunaySeries(dl, triangle: false);

  return ChartOption(
    series: [series],
    animation: null,
  );
}
