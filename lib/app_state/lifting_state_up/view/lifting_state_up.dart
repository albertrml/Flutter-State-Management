import 'package:flutter/material.dart';
import 'package:flutter_state_management/app_state/lifting_state_up/model/my_schedule.dart';
import 'package:flutter_state_management/app_state/lifting_state_up/view/widget/my_chart.dart';
import 'package:flutter_state_management/app_state/lifting_state_up/view/widget/my_slider.dart';
import 'package:provider/provider.dart';

class LiftingStateUpTimeSpentScreen extends StatefulWidget {
  final String title;
  const LiftingStateUpTimeSpentScreen({super.key, required this.title});

  @override
  State<LiftingStateUpTimeSpentScreen> createState() =>
      _LiftingStateUpTimeSpentScreenState();
}

class _LiftingStateUpTimeSpentScreenState
    extends State<LiftingStateUpTimeSpentScreen> {
  @override
  Widget build(BuildContext context) {
    /*
     * Creates and provides MySchedule to the widget subtree.
     */
    return ChangeNotifierProvider(
      create: (context) => MySchedule(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(
            widget.title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(padding: EdgeInsets.all(32), child: MyChart()),
            ),
            Padding(padding: const EdgeInsets.all(32), child: MySlider()),
          ],
        ),
      ),
    );
  }
}
