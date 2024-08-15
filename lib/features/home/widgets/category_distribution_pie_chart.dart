import 'package:eco_focus/features/home/home_screen_view_model.dart';
import 'package:eco_focus/shared/widgets/text_widgets.dart';
import 'package:eco_focus/style/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryDistributionPieChart extends StatefulWidget {
  const CategoryDistributionPieChart({super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<CategoryDistributionPieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 12.0),
        child: Column(
          children: [
            TextWidgets.secondaryTitleText(
                text: 'Sessions Distribution', fontSize: 16.0),
            Consumer<HomeScreenViewModel>(
              builder: (context, value, child) {
                if (value.sessions != null) {
                  if (value.sessions!.isNotEmpty) {
                    return Column(
                      children: [
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: AspectRatio(
                                aspectRatio: 1.1,
                                child: PieChart(
                                  PieChartData(
                                    pieTouchData: PieTouchData(
                                      touchCallback: (FlTouchEvent event,
                                          pieTouchResponse) {
                                        setState(() {
                                          if (!event
                                                  .isInterestedForInteractions ||
                                              pieTouchResponse == null ||
                                              pieTouchResponse.touchedSection ==
                                                  null) {
                                            touchedIndex = -1;
                                            return;
                                          }
                                          touchedIndex = pieTouchResponse
                                              .touchedSection!
                                              .touchedSectionIndex;
                                        });
                                      },
                                    ),
                                    borderData: FlBorderData(
                                      show: false,
                                    ),
                                    sectionsSpace: 5,
                                    centerSpaceRadius: 60,
                                    sections:
                                        value.plotPieChart(value.sessions!),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Text('hi'),
                      ],
                    );
                  }
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 100.0),
                      child: TextWidgets.regularText(
                          text: 'No focus recorded', fontSize: 16.0),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: AppColors.primaryColor,
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.contentColorPink,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: AppColors.primaryColor,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.contentColorPink,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: AppColors.primaryColor,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.contentColorPink,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: AppColors.primaryColor,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.contentColorPink,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
