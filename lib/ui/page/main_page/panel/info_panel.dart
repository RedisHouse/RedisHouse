
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redis_house/ui/example/bar_chart.dart';
import 'package:redis_house/ui/example/line_chart.dart';
import 'package:redis_house/ui/example/pie_chart.dart';
import 'package:redis_house/ui/example/scatter_chart.dart';

class InfoPanel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InfoPanelState();
  }
}

class _InfoPanelState extends State<InfoPanel> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: Row(
          children: [
            Expanded(child: LineChartSample1()),
            Expanded(child: BarChartSample1()),
          ],
        )),
        Expanded(child: Row(
          children: [
            Expanded(child: PieChartSample2()),
            Expanded(child: ScatterChartSample1()),
          ],
        )),
      ],
    );
  }

}