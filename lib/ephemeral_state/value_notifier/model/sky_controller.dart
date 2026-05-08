import 'package:flutter/material.dart';

enum SkyMode {
  /*
   * The application can be in only two visual states:
   * 
   * 1. day
   * 2. night
   * 
   * Enums are useful to represent finite states safely.
   */
  day,
  night,
}

class SkyController {
  /*
   * ValueNotifier is one of Flutter's simplest reactive
   * state management mechanisms.
   * 
   * It stores a single value and automatically notifies
   * listeners whenever the value changes.
   * 
   * Here, the state starts in day mode.
   */
  final ValueNotifier<SkyMode> mode = ValueNotifier(SkyMode.day);

  /*
   * This method returns different gradients according
   * to the current visual state.
   * 
   * The UI will rebuild automatically whenever the
   * ValueNotifier changes.
   */
  static List<Color> skyMode(bool isDay) {
    List<Color> gradient = <Color>[
      Colors.orange.shade700,
      Colors.yellow.shade200,
      Colors.orange.shade100,
    ];

    if (isDay) return gradient;

    return <Color>[
      Color.fromRGBO(19, 24, 98, 1),
      Color.fromRGBO(46, 68, 130, 1),
      Color.fromRGBO(84, 107, 171, 1),
    ];
  }

  /*
   * This method changes the current state.
   * 
   * Whenever mode.value changes, all widgets listening
   * to this ValueNotifier are rebuilt automatically.
   */
  void toggle() {
    mode.value = (mode.value == SkyMode.day) ? SkyMode.night : SkyMode.day;
  }

  /*
   * ValueNotifier internally manages listeners.
   * 
   * dispose() prevents memory leaks when the screen
   * is removed from memory.
   */
  void dispose() {
    mode.dispose();
  }
}
