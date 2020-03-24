import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_style.dart';

class SummaryPiechart extends StatefulWidget {
  final List<String> numbers;

  const SummaryPiechart({
    Key key,
    @required this.numbers,
  }) : super(key: key);

  @override
  _SummaryPiechartState createState() => _SummaryPiechartState();
}

class _SummaryPiechartState extends State<SummaryPiechart> {
  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5 / 1,
      child: PieChart(
        PieChartData(
          pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
            setState(() {
              if (pieTouchResponse.touchInput is FlLongPressEnd ||
                  pieTouchResponse.touchInput is FlPanEnd) {
                touchedIndex = -1;
              } else {
                touchedIndex = pieTouchResponse.touchedSectionIndex;
              }
            });
          }),
          borderData: FlBorderData(
            show: false,
          ),
          sectionsSpace: 0,
          centerSpaceRadius: 40,
          sections: showingSections(),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final value = widget.numbers[i] == '' ? '' : widget.numbers[i];
      final isTouched = i == touchedIndex;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: confirmedColor,
            value: double.parse(value),
            showTitle: false,
            radius: radius,
          );
        case 1:
          return PieChartSectionData(
            color: deathsColor,
            value: double.parse(value),
            showTitle: false,
            radius: radius,
          );
        case 2:
          return PieChartSectionData(
            color: recoveredColor,
            value: double.parse(value),
            showTitle: false,
            radius: radius,
          );
        default:
          return null;
      }
    });
  }
}
