import 'package:eco_focus/features/home/home_screen_view_model.dart';
import 'package:eco_focus/features/home/widgets/line_charts.dart';
import 'package:eco_focus/style/colors.dart';
import 'package:eco_focus/utils/utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FocusTimeGraphWidget extends StatefulWidget {
  const FocusTimeGraphWidget({super.key});

  @override
  State<FocusTimeGraphWidget> createState() => _FocusTimeGraphWidgetState();
}

class _FocusTimeGraphWidgetState extends State<FocusTimeGraphWidget> {
  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Column(
        children: [
          Text('Focus Time'),
          SizedBox(
            height: 250,
            width: 400,
            child: FocusTimeChart(),
          ),
        ],
      ),
    );
  }
}

class FocusTimeChart extends StatefulWidget {
  const FocusTimeChart({super.key});

  @override
  State<FocusTimeChart> createState() => _FocusTimeChartState();
}

class _FocusTimeChartState extends State<FocusTimeChart> {
  LineChartData get chartData => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 0,
        maxX: 14,
        maxY: 4,
        minY: 0,
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
      ];
  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) => Colors.blueGrey.withOpacity(0.8),
        ),
      );

  FlGridData get gridData => const FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(
              color: const Color.fromARGB(255, 255, 0, 153).withOpacity(0.2),
              width: 4),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: true,
        color: AppColors.primaryColor,
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 4),
          FlSpot(3, 1.5),
          FlSpot(5, 1.4),
          FlSpot(7, 3.4),
          FlSpot(10, 2),
          FlSpot(12, 2.2),
          FlSpot(13, 1.8),
        ],
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  double calculateInterval() {
    final viewModel = Provider.of<HomeScreenViewModel>(context, listen: true);
    var xAxisList = viewModel.xAxisList;
    if (xAxisList.isEmpty) return 1;
    return (xAxisList.length / 5).ceilToDouble();
  }

  List<int> calculatePositions(int dataCount, int columnCount) {
    List<int> positions = [];
    if (dataCount > 1) {
      int interval = (columnCount - 1) ~/ (dataCount - 1);
      for (int i = 0; i < dataCount; i++) {
        positions.add(i * interval);
      }
    } else {
      positions.add(0); // If there's only one data point, place it at the start
    }
    return positions;
  }

  List<MapEntry<int, Widget>>? combineLists(List list1, List list2) {
    if (list1.isEmpty || list2.isEmpty) {
      return null;
    }
    List<MapEntry<int, Widget>> result = [];
    for (int i = 0; i < list1.length; i++) {
      int a = list1[i];
      Widget b = list2[i];
      result.add(MapEntry(a, b));
    }
    return result;
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final viewModel = Provider.of<HomeScreenViewModel>(context, listen: true);
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
    Widget text = const Text('');
    List<Widget> textList = [];
    var xAxisList = viewModel.xAxisList;
    int index = value.toInt();
    List<int> positions = calculatePositions(xAxisList.length, 14);

    for (var i = 0; i < xAxisList.length; i++) {
      textList
          .add(Text(Utils().dayParser(xAxisList[i]).toString(), style: style));
    }

    var combinedResult = combineLists(positions, textList);

    if (combinedResult != null) {
      for (var element in combinedResult) {
        if (value == element.key) {
          text = element.value;
          break;
        }
      }
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '1m';
        break;
      case 2:
        text = '2m';
        break;
      case 3:
        text = '3m';
        break;
      case 4:
        text = '5m';
        break;
      case 5:
        text = '6m';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  @override
  Widget build(BuildContext context) {
    return LineChart(
      chartData,
      duration: const Duration(milliseconds: 100),
    );
  }
}
