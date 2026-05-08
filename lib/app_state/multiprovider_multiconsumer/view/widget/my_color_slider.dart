import 'package:flutter/material.dart';
import 'package:flutter_state_management/app_state/multiprovider_multiconsumer/model/color_channel.dart';
import 'package:provider/provider.dart';

class MyColorSlider<T extends ColorChannel> extends StatelessWidget {
  const MyColorSlider({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the correct provider instance based on channel type.
    final channel = context.watch<T>();

    return Row(
      children: [
        Text(channel.type.name),
        Expanded(
          child: Slider(
            value: channel.value,
            min: 0,
            max: 255,
            onChanged: channel.update,
          ),
        ),
        Text(channel.toInt().toString()),
      ],
    );
  }
}
