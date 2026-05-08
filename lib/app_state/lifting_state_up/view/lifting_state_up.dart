import 'package:flutter/material.dart';
import 'package:flutter_state_management/app_state/lifting_state_up/model/my_schedule.dart';
import 'package:flutter_state_management/app_state/lifting_state_up/view/widget/my_chart.dart';
import 'package:flutter_state_management/app_state/lifting_state_up/view/widget/my_slider.dart';
import 'package:provider/provider.dart';

class LiftingStateUp extends StatefulWidget {
  const LiftingStateUp({super.key});

  @override
  State<LiftingStateUp> createState() => _LiftingStateUpState();
}

class _LiftingStateUpState extends State<LiftingStateUp> {
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
            'Time spent',
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
