import 'package:e_chart/e_chart.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class ContentPage extends StatelessWidget {
  final ConfigData itemData;
  final bool needToolBar;

  const ContentPage(this.itemData, {super.key, this.needToolBar = false});

  @override
  Widget build(BuildContext context) {
    Widget w = Container(
        alignment: Alignment.center,
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Chart(itemData.config!),
        ));
    if (!needToolBar) {
      return w;
    }

    return Scaffold(
        appBar: AppBar(
            title: Text(
          itemData.name,
          style: const TextStyle(fontSize: 15, color: Colors.white),
        )),
        body: w);
  }
}
