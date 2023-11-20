import 'dart:math';

import 'package:e_chart/e_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as md;

import 'data/graph_data.dart';

class GraphPage extends StatefulWidget {
  const GraphPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return GraphState();
  }
}

class GraphState extends State<GraphPage> {
  static const double textSize = 24;
  static const String forceCenter = "FOCenter";
  static const String forceCollide = "FOCollide";
  static const String forceLink = "FOLink";
  static const String forceManyBody = "FOManyBody";
  static const String forceRadial = "FORadial";
  static const String forceX = "FOX";
  static const String forceY = "FOY";
  static const String circle = "circle";
  static const String concentric = "concentric";
  static const String dagre = "dagre";
  static const String grid = "grid";
  static const String mds = "mds";
  static const String radial = "radial";
  static const String random = "random";
  static const String combo = "combo";
  final Map<String, bool> selectMap = {};
  List<GraphData> nodeDataList = [];
  List<EdgeData> edgeDataList = [];

  bool buildFlag = false;
  GraphLayout? graphLayout;

  @override
  void initState() {
    super.initState();
    var data = loadData1();
    nodeDataList = data[0];
    edgeDataList = data[1];
  }

  @override
  void didUpdateWidget(GraphPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    var data = loadData1();
    nodeDataList = data[0];
    edgeDataList = data[1];
  }

  @override
  void dispose() {
    graphLayout?.dispose();
    graphLayout = null;
    super.dispose();
  }

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

  Widget buildTitle() {
    return SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Force',
              style: TextStyle(color: Colors.black87, fontSize: textSize),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 16),
                child: md.Wrap(textDirection: TextDirection.ltr, children: [
                  buildCheck('Center', (p0) {
                    handleBox(forceCenter, p0);
                  }, selectMap[forceCenter] ?? false),
                  buildCheck('Collide', (p0) {
                    handleBox(forceCollide, p0);
                  }, selectMap[forceCollide] ?? false),
                  buildCheck("Link", (p0) {
                    handleBox(forceLink, p0);
                  }, selectMap[forceLink] ?? false),
                  buildCheck('ManyBody', (p0) {
                    handleBox(forceManyBody, p0);
                  }, selectMap[forceManyBody] ?? false),
                  buildCheck('Radial', (p0) {
                    handleBox(forceRadial, p0);
                  }, selectMap[forceRadial] ?? false),
                  buildCheck('X', (p0) {
                    handleBox(forceX, p0);
                  }, selectMap[forceX] ?? false),
                  buildCheck('Y', (p0) {
                    handleBox(forceY, p0);
                  }, selectMap[forceY] ?? false),
                ])),
            const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'Normal',
                  style: TextStyle(color: Colors.black87, fontSize: textSize),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: md.Wrap(textDirection: TextDirection.ltr, children: [
                buildCheck('circular', (p0) {
                  handleBox(circle, p0);
                }, selectMap[circle] ?? false),
                buildCheck('concentric', (p0) {
                  handleBox(concentric, p0);
                }, selectMap[concentric] ?? false),
                buildCheck('dagre', (p0) {
                  handleBox(dagre, p0);
                }, selectMap[dagre] ?? false),
                buildCheck('grid', (p0) {
                  handleBox(grid, p0);
                }, selectMap[grid] ?? false),
                buildCheck('mds', (p0) {
                  handleBox(mds, p0);
                }, selectMap[mds] ?? false),
                buildCheck('radial', (p0) {
                  handleBox(radial, p0);
                }, selectMap[radial] ?? false),
                buildCheck('random', (p0) {
                  handleBox(random, p0);
                }, selectMap[random] ?? false),
                buildCheck('combo', (p0) {
                  handleBox(combo, p0);
                }, selectMap[combo] ?? false),
              ]),
            ),
            Container(
              height: 56,
              width: double.infinity,
              margin: const EdgeInsets.only(top: 16),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                      child: Container(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                graphLayout?.dispose();
                                graphLayout = null;
                                buildFlag = false;
                                selectMap.clear();
                              });
                            },
                            style: ElevatedButton.styleFrom(minimumSize: const Size(144, 56)),
                            child: const Text('清除', style: TextStyle(fontSize: 24)),
                          ))),
                  Expanded(
                      child: Container(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                buildFlag = true;
                              });
                            },
                            style: ElevatedButton.styleFrom(minimumSize: const Size(144, 56)),
                            child: const Text(
                              '保存',
                              style: TextStyle(fontSize: 24),
                            ),
                          ))),
                ],
              ),
            )
          ],
        ));
  }

  void handleBox(String key, bool state) {
    if (key.startsWith('FO')) {
      selectMap.removeWhere((key, value) => !key.startsWith('FO'));
      selectMap[key] = state;
    } else {
      selectMap.clear();
      selectMap[key] = state;
    }
    setState(() {});
  }

  Widget buildContent() {
    GraphLayout? gl = buildLayout();
    if (gl == null) {
      graphLayout = null;
      return Container(
        height: 200,
      );
    }
    graphLayout = gl;
    var mr = Random(1);
    var series = GraphSeries(
      nodeDataList,
      edgeDataList,
      gl,
      sizeFun: (node) {
        return Size.square(mr.nextDouble() * 30 + 8);
      },
      onlyDragNode: false,
    );
    if (gl is ForceLayout) {
      // series.longPressMove = (v, e) {
      //   Offset offset = v.toLocal(e.globalPosition);
      //   var node = data.nodes.first;
      //   node.fx = offset.dx - v.width / 2;
      //   node.fy = offset.dy - v.height / 2;
      //   gl.restart();
      // };
    }
    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      child: Chart(ChartOption(series: [series])),
    );
  }

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
              style: const TextStyle(color: Colors.black87, fontSize: textSize),
            )
          ],
        ));
  }

  GraphLayout? buildLayout() {
    if (selectMap.isEmpty || !buildFlag) {
      return null;
    }
    buildFlag = false;
    String key = selectMap.keys.first;
    GraphLayout? layout;
    if (key.startsWith('FO')) {
      List<Force> forceList = [];
      layout = ForceLayout(forceList, alphaTarget: 0.3, velocityDecay: 0.1, optPerformance: false);
      selectMap.forEach((key, value) {
        if (key == forceCenter) {
          forceList.add(CenterForce());
        } else if (key == forceCollide) {
          forceList.add(CollideForce().radius((a, b, c, d, e) {
            return a.r + 1;
          }).setIterations(4));
        } else if (key == forceLink) {
          forceList.add(LinkForce());
        } else if (key == forceManyBody) {
          forceList.add(ManyBodyForce().setStrength((node, i, list, w, h) {
            return i != 0 ? 0 : -w * 2 / 3;
          }));
        } else if (key == forceRadial) {
          forceList.add(RadialForce(radiusFun: (a, b, c, d, e) {
            if (b < 40) {
              return 50;
            }
            return 80;
          }));
        } else if (key == forceX) {
          forceList.add(XForce().setStrength((a, b, c, d, e) {
            return 0.01;
          }));
        } else if (key == forceY) {
          forceList.add(YForce().setStrength((a, b, c, d, e) {
            return 0.01;
          }));
        }
      });
    } else {
      if (key == circle) {
        layout = CircularLayout(radius: SNumber.percent(45));
      } else if (key == concentric) {
        layout = ConcentricLayout();
      } else if (key == dagre) {
        layout = DagreLayout(Config(), multiGraph: true, directedGraph: false);
      } else if (key == grid) {
        layout = GraphGridLayout();
      } else if (key == mds) {
        layout = MDSLayout();
      } else if (key == radial) {
        layout = RadialLayout(
          preventOverlap: true,
          strictRadial: true,
          workerThread: true,
        );
      } else if (key == random) {
        layout = RandomLayout();
      } else if (key == combo) {
        // List<Force> forceList = [];
        // forceList.add(CollideForce().radius((a, b, c, d, e) {
        //   return a.r + 1;
        // }).setIterations(4));
        // forceList.add(ManyBodyForce().setStrength((node, i, list, w, h) {
        //   return i != 0 ? 0 : -w * 2 / 3;
        // }));
        // forceList.add(XForce().setStrength((a, b, c, d, e) {
        //   return 0.01;
        // }));
        // forceList.add(YForce().setStrength((a, b, c, d, e) {
        //   return 0.01;
        // }));
        // ForceLayout fl = ForceLayout(
        //   forceList,
        //   alphaTarget: 0.3,
        //   velocityDecay: 0.1,
        //   optPerformance: false,
        // );
        // layout = ComboLayout(
        //     outerLayout: fl,
        //     sizeFun: (node) {
        //       if (node is Combo) {
        //         return Size.square(node.width);
        //       }
        //       return Size.square(16);
        //     },
        //     comboFun: (gh) {
        //       List<Combo> comboList = [];
        //       comboList.add(Combo(id: '1', GraphGridLayout(), Graph([])));
        //       comboList.add(Combo(id: '2', CircularLayout(), Graph([])));
        //       comboList.add(Combo(id: '3', CircularLayout(), Graph([])));
        //       comboList.add(Combo(id: '4', ConcentricLayout(), Graph([])));
        //       comboList.add(Combo(id: '5', RadialLayout(), Graph([])));
        //       for (int i = 0; i < gh.nodes.length; i++) {
        //         if (i < 10) {
        //           comboList[0].graph.nodes.add(gh.nodes[i]);
        //         } else if (i < 30) {
        //           comboList[1].graph.nodes.add(gh.nodes[i]);
        //         } else if (i < 50) {
        //           comboList[2].graph.nodes.add(gh.nodes[i]);
        //         } else if (i < 60) {
        //           comboList[3].graph.nodes.add(gh.nodes[i]);
        //         } else {
        //           comboList[4].graph.nodes.add(gh.nodes[i]);
        //         }
        //       }
        //       for (Combo combo in comboList) {
        //         double w = combo.graph.nodes.length * 8;
        //         w *= 1.2;
        //         combo.width = w;
        //         combo.height = w;
        //         combo.r = w * 0.6;
        //       }
        //       return comboList;
        //     });
      }
    }
    return layout;
  }
}
