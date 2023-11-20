import 'dart:math';

import 'package:e_chart/e_chart.dart';

ChartOption chordConfig() {
  return testChord();
}

ChartOption testChord() {
  var series = ChordSeries(
    buildChordData(5),
    padAngle: 2,
    chordWidth: SNumber.number(16),
    // itemStyleFun: (data) {
    //   return AreaStyle(color: randomColor());
    // },
    // linkItemStyleFun: (link)=>AreaStyle(color: randomColor()),
   // linkBorderStyleFun: (link)=>LineStyle(color: randomColor()),
  );
  return ChartOption(
    series: [series],
  );
}

List<ChordLink> buildChordData(int count) {
  Random random = Random(1);
  List<ChordLink> gl = [];
  List<ChordData> dl = List.generate(count, (index) => ChordData());
  each(dl, (data, p1) {
    int c = random.nextInt(5) + 1;
    for (int i = 0; i < c; i++) {
      int index = random.nextInt(dl.length - 1);
      var target = dl[index];
      if (target != data) {
        gl.add(ChordLink(data, target, random.nextInt(100)));
      }
    }
  });

  return gl;
}
