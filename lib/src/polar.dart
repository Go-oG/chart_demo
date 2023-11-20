import 'dart:math';
import 'package:e_chart/e_chart.dart';

ChartOption polarConfig() {
  Polar polar = Polar(
      radius: [const SNumber.percent(40)],
      radiusAxis: RadiusAxis(offsetAngle: 0, splitNumber: 4),
      angleAxis: AngleAxis(
        categoryList: ['1', '2', '3', '4'],
        min: 0,
        max: 360,
        interval: 30,
      ),
      silent: false);
  return ChartOption(
    series: [testPolar()],
    polarList: [polar],
  );
}

ChartSeries testPolar() {
  List<PointData> dl = [];
  // for (int i = 0; i <= 360; i++) {
  //   double t = pi * (i / 180);
  //   double r = sin(2 * t) * cos(2 * t);
  //   dl.add(PointData(DynamicData(r.abs()), DynamicData(i)));
  // }
  for (int i = 1; i <= 4; i++) {
    double t = pi * (i / 180);
    dl.add(PointData(i, '1'));
  }

  // for (int i = 0; i <= 100; i++) {
  //   num theta = (i / 100) * 360;
  //   num r = 5 * (1 + sin((theta / 180) * pi));
  //   dl.add(MultiData(r.abs(), theta));
  // }

  return PointSeries(dl, coordType: CoordType.polar);
}
