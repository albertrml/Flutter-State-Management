import 'package:flutter/material.dart';

class MySchedule with ChangeNotifier {
  /*
   * Shared application state.
   * Multiple widgets can read and react to this value
   */
  double _stateManagementTime = 0.5;

  double get stateManagementTime => _stateManagementTime;

  set stateManagementTime(double newValue) {
    _stateManagementTime = newValue;

    /*
     * Notify all listening widgets.
     * Widgets using Provider.of/watch/select/Consumer rebuild automatically.
     */
    notifyListeners();
  }
}
