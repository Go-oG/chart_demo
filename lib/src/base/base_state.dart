import 'package:e_chart/e_chart.dart';
import 'package:flutter/material.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  @override
  Widget build(BuildContext context) {
    List<Widget> wl = [
      buildTitle(),
      Expanded(child: buildContent()),
    ];
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: wl,
    );
  }

  String get title => '';

  Widget buildTitle();

  Widget buildContent() {
    return Container(
      width: double.infinity,
      height: 400,
      alignment: Alignment.center,
      child: Chart(buildConfig()),
    );
  }

  ChartOption buildConfig();

  Widget buildCheck(String text, void Function(bool) callback, [bool defaultSelect = false]) {
    return SizedBox(
        height: 36,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
                value: defaultSelect,
                onChanged: (b) {
                  callback.call(b ?? false);
                }),
            Text(
              text,
              style: const TextStyle(color: Colors.black87, fontSize: 20),
            )
          ],
        ));
  }

  Widget buildCheck2(String text, void Function(bool) callback, [bool defaultSelect = false]) {
    return SizedBox(
        height: 36,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: const TextStyle(color: Colors.black87, fontSize: 20),
            ),
            Checkbox(
                value: defaultSelect,
                onChanged: (b) {
                  callback.call(b ?? false);
                })
          ],
        ));
  }
}
