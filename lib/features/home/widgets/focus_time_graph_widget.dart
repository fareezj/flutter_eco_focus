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

double calculateMinY(Map<String, double> aggregatedData) {
  return aggregatedData.values.reduce((a, b) => a < b ? a : b);
}

double calculateMaxY(Map<String, double> aggregatedData) {
  return aggregatedData.values.reduce((a, b) => a > b ? a : b);
}

class _FocusTimeChartState extends State<FocusTimeChart> {
  LineChartData get chartData {
    final viewModel = Provider.of<HomeScreenViewModel>(context, listen: true);
    final aggregatedData =
        aggregateData(viewModel.xAxisList, viewModel.yAxisList);

    double minY = calculateMinY(aggregatedData);
    double maxY = calculateMaxY(aggregatedData);

    return LineChartData(
      lineTouchData: lineTouchData1,
      gridData: gridData,
      titlesData: titlesData1,
      borderData: borderData,
      lineBarsData: lineBarsData1,
      minX: 0,
      maxX: 14,
      maxY: maxY,
      minY: minY,
    );
  }

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_2,
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

  Map<String, double> aggregateData(List<String> dates, List<String> values) {
    Map<String, double> aggregatedData = {};

    // Parsing the y-values correctly
    List<double> yValues =
        values.map((e) => double.tryParse(e.substring(0, 2)) ?? 0.0).toList();

    for (int i = 0; i < dates.length; i++) {
      // Extract only the date part
      String datePart = dates[i].split(' ')[0];

      if (aggregatedData.containsKey(datePart)) {
        aggregatedData[datePart] = aggregatedData[datePart]! + yValues[i];
      } else {
        aggregatedData[datePart] = yValues[i];
      }
    }

    return aggregatedData;
  }

  List<FlSpot> generateAggregatedSpots(Map<String, double> aggregatedData) {
    List<FlSpot> spots = [];
    int index = 0;

    aggregatedData.forEach((date, value) {
      spots.add(FlSpot(index.toDouble(), value));
      index++;
    });

    return spots;
  }

  Map<String, List<double>> groupData(List<String> dates, List<String> values) {
    Map<String, List<double>> groupedData = {};
    var yVal = values.map((e) => double.parse(e.substring(0, 2))).toList();

    for (int i = 0; i < dates.length; i++) {
      if (groupedData.containsKey(dates[i])) {
        groupedData[dates[i]]!.add(yVal[i]);
      } else {
        groupedData[dates[i]] = [yVal[i]];
      }
    }

    return groupedData;
  }

  List<FlSpot> generateSpots(Map<String, List<double>> groupedData) {
    List<FlSpot> spots = [];
    int index = 0;

    groupedData.forEach((date, values) {
      for (var value in values) {
        spots.add(FlSpot(index.toDouble(), value));
      }
      index++;
    });

    return spots;
  }

  LineChartBarData get lineChartBarData1_2 {
    final viewModel = Provider.of<HomeScreenViewModel>(context, listen: true);

    final aggregatedData =
        aggregateData(viewModel.xAxisList, viewModel.yAxisList);
    return LineChartBarData(
      isCurved: true,
      color: AppColors.primaryColor,
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: true), // Show dots for each value
      belowBarData: BarAreaData(show: false),
      spots: generateAggregatedSpots(aggregatedData),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final viewModel = Provider.of<HomeScreenViewModel>(context, listen: true);

    final aggregatedData =
        aggregateData(viewModel.xAxisList, viewModel.yAxisList);
    final dateList = aggregatedData.keys.toList();
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);

    Widget text = const Text('');
    if (value < dateList.length) {
      text = Text(Utils().dayParser(dateList[value.toInt()]).toString(),
          style: style);
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
    String text = value.toStringAsFixed(1);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Text(text, style: style),
    );
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: (calculateMaxY(aggregateData(
                    Provider.of<HomeScreenViewModel>(context, listen: false)
                        .xAxisList,
                    Provider.of<HomeScreenViewModel>(context, listen: false)
                        .yAxisList)) -
                calculateMinY(aggregateData(
                    Provider.of<HomeScreenViewModel>(context, listen: false)
                        .xAxisList,
                    Provider.of<HomeScreenViewModel>(context, listen: false)
                        .yAxisList))) /
            (5 - 1),
        reservedSize: 60,
      );

  @override
  Widget build(BuildContext context) {
    return LineChart(
      chartData,
      duration: const Duration(milliseconds: 100),
    );
  }
}
