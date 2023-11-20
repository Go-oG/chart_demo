import 'dart:async';
import 'dart:math' as m;

import 'package:chart_demo/src/base/base_state.dart';
import 'package:e_chart/e_chart.dart';
import 'package:flutter/material.dart';

class CustomPage extends StatefulWidget {
  const CustomPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return CustomState();
  }
}

class CustomState extends BaseState<CustomPage> {
  @override
  ChartOption buildConfig() {
    return ChartOption(series: [PolarClockSeries()]);
  }

  @override
  Widget buildTitle() {
    return const SizedBox(
      height: 0,
    );
  }
}

class PolarClockSeries extends ChartSeries {
  @override
  ChartView? toView() {
    return PolarClockView(this);
  }

  @override
  List<LegendItem> getLegendItem(Context context) => [];

  @override
  int onAllocateStyleIndex(int start) {
    return 0;
  }

  @override
  SeriesType get seriesType => SeriesType('PolarClock',1);
}

class PolarClockView extends SeriesView<PolarClockSeries, PolarHelper> {
  PolarClockView(super.series);

  Timer? timer;
  Map<CircleSymbol, Offset> symbolList = {};
  Map<CircleSymbol, List<Offset>> offsetList = {};

  @override
  void onCreate() {
    super.onCreate();
    // timer?.cancel();
    // timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    //   invalidate();
    // });
    m.Random random = m.Random(1);
    for (int i = 0; i < 100000; i++) {
      var sym = CircleSymbol(radius: 24, itemStyle: AreaStyle(color: Colors.blue.withOpacity(0.05)));
      symbolList[sym] = Offset(random.nextDouble() * 6000, random.nextDouble() * 500);
      offsetList[sym]=PositiveShape(count: 6,r:16).toList();
    }
  }

  @override
  void onDispose() {
    timer?.cancel();
    timer = null;
    super.onDispose();
  }

  @override
  void onDraw(CCanvas canvas) {
    var sw = Stopwatch();
    sw.start();
    canvas.save();
    canvas.translate(translationX, translationY);
    canvas.scale(5);
    mPaint.style=PaintingStyle.fill;

    symbolList.forEach((key, value) {
      key.draw(canvas, mPaint, value);
    });
    canvas.restore();
    sw.stop();
    debugPrint('耗时1:${sw.elapsedMicroseconds}ns');
    sw.reset();

    // DateTime time = DateTime.now();
    // canvas.save();
    // canvas.translate(width / 2, height / 2);
    // double r = m.min(width / 2, height / 2) * 0.95;
    // drawMonth(canvas, time.month, r * 0.35);
    // drawDay(canvas, time.day, 31, r * 0.45);
    // drawWeek(canvas, time.weekday, r * 0.55);
    // drawHour(canvas, time.hour, r * 0.8);
    // drawMinute(canvas, time.minute, r * 0.9);
    // drawSecond(canvas, time.second, r);
    // canvas.restore();
  }

  void drawMonth(CCanvas canvas, int month, double r) {
    List<String> monthList = ['Ja', 'Fe', 'Ma', 'Ap', 'Ma', 'Ju', 'Au', 'Se', 'Oc', 'No', 'De'];
    drawCategory(canvas, month - 1, monthList, r, Colors.orangeAccent);
  }

  void drawDay(CCanvas canvas, int day, int maxDay, double r) {
    drawNumber(canvas, day, 1, maxDay, r, Colors.deepPurple, 14);
  }

  void drawWeek(CCanvas canvas, int week, double r) {
    List<String> weekListList = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
    drawCategory(canvas, week - 1, weekListList, r, Colors.blue);
  }

  void drawHour(CCanvas canvas, int hour, double r) {
    drawNumber(canvas, hour, 0, 23, r, Colors.green);
  }

  void drawMinute(CCanvas canvas, int minute, double r) {
    drawNumber(canvas, minute, 0, 59, r, Colors.orange);
  }

  void drawSecond(CCanvas canvas, int minute, double r) {
    drawNumber(canvas, minute, 0, 59, r, Colors.cyan);
  }

  void drawNumber(CCanvas canvas, int cur, int minV, int maxV, double r, Color color, [num symbolSize = 16]) {
    LineStyle lineStyle = const LineStyle(color: Colors.black, width: 1.5);
    lineStyle.drawArc(canvas, mPaint, r, -90, 360);

    CircleSymbol symbol1 = CircleSymbol(radius: symbolSize, itemStyle: AreaStyle(color: Colors.white));
    LabelStyle labelStyle1 = const LabelStyle(textStyle: TextStyle(color: Colors.black, fontSize: 14));

    CircleSymbol symbol2 = CircleSymbol(radius: symbolSize, itemStyle: AreaStyle(color: Colors.black));
    LabelStyle labelStyle2 = const LabelStyle(
        textStyle: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ));

    num angleInterval = 360 / (maxV - minV + 1);

    for (int i = minV; i <= maxV; i++) {
      String s = i < 10 ? '0$i' : "$i";
      num angle = -90 + (i - minV) * angleInterval;
      Offset offset = circlePoint(r, angle);
      var config = TextDraw(s.toText(), LabelStyle.empty, offset);
      if (i == cur) {
        symbol2.draw(canvas, mPaint, offset);
        config.updatePainter(style: labelStyle2);
        config.draw(canvas, mPaint);
      } else {
        symbol1.draw(canvas, mPaint, offset);

        config.updatePainter(style: labelStyle1, text: s.toText());
        config.draw(canvas, mPaint);
      }
    }
  }

  void drawCategory(CCanvas canvas, int index, List<String> data, double r, Color color) {
    LineStyle lineStyle = const LineStyle(color: Colors.black, width: 1.5);
    lineStyle.drawArc(canvas, mPaint, r, -90, 360);

    CircleSymbol symbol1 = CircleSymbol(radius: 16, itemStyle: const AreaStyle(color: Colors.white));
    CircleSymbol symbol2 = CircleSymbol(radius: 14, itemStyle: const AreaStyle(color: Colors.black));

    LabelStyle style = const LabelStyle(textStyle: TextStyle(color: Colors.black));
    LabelStyle labelStyle2 = const LabelStyle(
        textStyle: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ));

    num angleInterval = 360 / data.length;
    for (int i = 0; i < data.length; i++) {
      String s = data[i];
      num angle = -90 + i * angleInterval;
      Offset offset = circlePoint(r, angle);
      var config = TextDraw(s.toText(), LabelStyle.empty, offset);
      if (i == index) {
        symbol2.draw(canvas, mPaint, offset);
        config.updatePainter(style: labelStyle2);
        config.draw(canvas, mPaint);
      } else {
        symbol1.draw(canvas, mPaint, offset);
        config.updatePainter(style: style);
        config.draw(canvas, mPaint);
      }
    }
  }

  @override
  PolarHelper buildLayoutHelper(var oldHelper) {
    oldHelper?.clearRef();
    return PolarHelper(context, this, series);
  }

  @override
  bool get enableDrag => true;
}

class PolarHelper extends LayoutHelper2<RenderData,PolarClockSeries> {
  PolarHelper(super.context, super.view, super.series);

  @override
  void onLayout(LayoutType type) {}
}
