import 'package:chart_demo/chart_page.dart';
import 'package:e_chart/e_chart.dart';
import 'package:flutter/material.dart';


void main() {
  //debugRepaintRainbowEnabled=true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ChartPage(),
    );
  }
}

class ConfigData {
  final String name;
  final ChartOption? config;
  final VoidCallback? callback;

  ConfigData(this.name, this.config, [this.callback]);
}
