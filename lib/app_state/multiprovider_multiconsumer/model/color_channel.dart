import 'package:flutter/material.dart';

enum ChannelType { red, green, blue }

class ColorChannel extends ChangeNotifier {
  final ChannelType type;
  ColorChannel(this.type);

  /*
   * Shared application state.
   * Multiple widgets can read and react to this value
   */
  double _value = 0;

  double get value => _value;

  int toInt() => _value.toInt();

  void update(double newValue) {
    _value = newValue;

    /*
     * Notify all listening widgets.
     * Widgets using Provider.of/watch/select/Consumer rebuild automatically.
     */
    notifyListeners();
  }
}

/*
 * Three ColorChannels that work as different source for MultiProvider 
 */

class BlueChannel extends ColorChannel {
  BlueChannel() : super(ChannelType.blue);
}

class GreenChannel extends ColorChannel {
  GreenChannel() : super(ChannelType.green);
}

class RedChannel extends ColorChannel {
  RedChannel() : super(ChannelType.red);
}
