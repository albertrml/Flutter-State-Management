import 'package:flutter/material.dart';
import 'package:flutter_state_management/app_state/lifting_state_up/model/my_schedule.dart';
import 'package:provider/provider.dart';

class MySlider extends StatefulWidget {
  const MySlider({super.key});

  @override
  State<MySlider> createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  @override
  Widget build(BuildContext ctx) {
    /*
    /*
     * 1. Provider.of<MySchedule>(ctx) retrieves the nearest
     *    MySchedule instance from the widget tree.
     *
     * 2. By default, listen: true is used internally.
     *
     * 3. This means the widget subscribes to MySchedule
     *    updates and rebuilds whenever notifyListeners()
     *    is called.
     */
    final schedule = Provider.of<MySchedule>(ctx);

    return Slider(
      value: schedule.stateManagementTime,
      /*
       * 1. Updates the current stateManagementTime value.
       *
       * 2. If the setter calls notifyListeners(),
       *    all listening widgets rebuild.
       *
       * 3. Since this widget itself is listening through
       *    Provider.of(...), it also rebuilds.
       */
      onChanged: (value) => schedule.stateManagementTime = value,
    );
    */

    /*
     * 1. ctx.select<MySchedule, double>() subscribes this widget 
     *    only to changes in stateManagementTime.
     *
     * 2. The widget rebuilds only when the selected value changes.
     *
     * 3. Even if MySchedule calls notifyListeners(),
     *    this widget will NOT rebuild unless
     *    stateManagementTime has a different value.
     */
    final stateManagementTime = ctx.select<MySchedule, double>(
      (schedule) => schedule.stateManagementTime,
    );

    return Slider(
      value: stateManagementTime,

      /*
       * 1. ctx.read<MySchedule>() gets the current instance
       *    without registering rebuild dependencies.
       *
       * 2. read() is appropriate inside callbacks because
       *    callbacks should not subscribe to state changes.
       *
       * 3. Updating the value probably triggers
       *    notifyListeners(), which causes widgets using
       *    watch() to rebuild.
       */
      onChanged: (newValue) =>
          ctx.read<MySchedule>().stateManagementTime = newValue,
    );
  }
}
