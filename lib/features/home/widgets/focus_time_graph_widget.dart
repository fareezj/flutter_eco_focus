import 'package:eco_focus/features/home/home_screen_view_model.dart';
import 'package:eco_focus/style/colors.dart';
import 'package:eco_focus/utils/utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FocusTimeGraphWidget extends StatefulWidget {
  const FocusTimeGraphWidget({super.key});

  @override
  State<FocusTimeGraphWidget> createState() => _FocusTimeGraphWidgetState();
}

class _FocusTimeGraphWidgetState extends State<FocusTimeGraphWidget> {
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  DateFormat dateFormatMonth = DateFormat('MMMM');
  int addedDays = 5;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenViewModel>(
      builder: (context, value, child) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                    onTap: () => value.switchDate(DateSwitchMode.previous),
                    child: const Icon(Icons.arrow_back_ios_new)),
                Text(dateFormat.format(value.startDate).toString()),
                const SizedBox(width: 20.0),
                Text(dateFormat.format(value.endDate).toString()),
                GestureDetector(
                    onTap: () => value.switchDate(DateSwitchMode.next),
                    child: const Icon(Icons.arrow_forward_ios)),
              ],
            ),
            const SizedBox(height: 12.0),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 22.0, horizontal: 12.0),
                child: Column(
                  children: [
                    const Text('Focus Time'),
                    Text(dateFormatMonth.format(value.startDate).toString()),
                    const SizedBox(height: 12.0),
                    if (value.xAxisList.isNotEmpty) ...[
                      const SizedBox(height: 200, child: FocusTimeChart())
                    ] else
                      const SizedBox(
                        height: 200,
                        width: double.maxFinite,
                        child: Center(child: Text('No focus recorded')),
                      )
                  ],
                ),
              ),
            ),
          ],
        );
      },
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
      maxX: 6,
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
          getTooltipColor: (touchedSpot) => Colors.blue.withOpacity(0.5),
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

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          axisNameWidget: const Text(
            'Day',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          axisNameWidget: const Text(
            'Cumulative Time (mins)',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
          sideTitles: leftTitles(),
        ),
      );

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  Map<String, double> aggregateData(List<String> dates, List<String> values) {
    Map<String, double> aggregatedData = {};

    // Parsing the y-values correctly
    List<double> yValues =
        values.map((e) => double.tryParse(e.substring(0, 2)) ?? 0.0).toList();

    for (int i = 0; i < dates.length; i++) {
      print(yValues[i]);
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

  LineChartBarData get lineChartBarData1_2 {
    final viewModel = Provider.of<HomeScreenViewModel>(context, listen: true);

    final aggregatedData =
        aggregateData(viewModel.xAxisList, viewModel.yAxisList);
    return LineChartBarData(
      isCurved: true,
      color: AppColors.primaryColor,
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: true),
      belowBarData: BarAreaData(show: false),
      spots: generateAggregatedSpots(aggregatedData),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final viewModel = Provider.of<HomeScreenViewModel>(context, listen: true);

    final aggregatedData =
        aggregateData(viewModel.xAxisList, viewModel.yAxisList);
    final dateList = aggregatedData.keys.toList();
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 13);

    Widget text = const Text('');
    if (value < dateList.length) {
      text = Text(
        Utils().dayParser(dateList[value.toInt()]).toString(),
        style: style,
      );
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 13);
    String text = value.toStringAsFixed(1);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 20,
      child: Text(text, style: style),
    );
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 5,
        reservedSize: 60,
      );

  //   interval: (calculateMaxY(
  //       aggregateData(
  //           Provider.of<HomeScreenViewModel>(context, listen: false)
  //               .xAxisList,
  //           Provider.of<HomeScreenViewModel>(context, listen: false)
  //               .yAxisList),
  //     ) -
  //     calculateMinY(
  //       aggregateData(
  //           Provider.of<HomeScreenViewModel>(context, listen: false)
  //               .xAxisList,
  //           Provider.of<HomeScreenViewModel>(context, listen: false)
  //               .yAxisList),
  //     )) /
  // (5 - 1),

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeScreenViewModel>(context, listen: true);

    if (viewModel.xAxisList.isNotEmpty && viewModel.xAxisList.isNotEmpty) {
      return LineChart(
        chartData,
        duration: const Duration(milliseconds: 100),
      );
    } else {
      return const SizedBox();
    }
  }
}
