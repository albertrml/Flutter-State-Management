import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_management/app_state/lifting_state_up/model/my_schedule.dart';
import 'package:flutter_state_management/app_state/lifting_state_up/model/problem.dart';
import 'package:provider/provider.dart';

class MyChart extends StatefulWidget {
  const MyChart({super.key});

  @override
  State<MyChart> createState() => _MyChartState();
}

class _MyChartState extends State<MyChart> {
  @override
  Widget build(BuildContext ctx) {
    /*
     * Consumer<MySchedule> allows the widget react all changes it comes from
     * MySchedule changes.
     */
    return Consumer<MySchedule>(
      builder: (context, schedule, child) => PieChart(
        PieChartData(
          sections: createData(schedule.stateManagementTime).map((problem) {
            return PieChartSectionData(
              value: problem.time,
              title: problem.getTitle(),
              color: problem.color,
              radius: 100,
              titleStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
