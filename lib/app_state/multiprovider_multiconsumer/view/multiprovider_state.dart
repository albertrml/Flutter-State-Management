import 'package:flutter/material.dart';
import 'package:flutter_state_management/app_state/multiprovider_multiconsumer/model/color_channel.dart';
import 'package:flutter_state_management/app_state/multiprovider_multiconsumer/view/widget/my_color.dart';
import 'package:flutter_state_management/app_state/multiprovider_multiconsumer/view/widget/my_color_slider.dart';
import 'package:provider/provider.dart';

class MultiproviderRGBColorScreen extends StatefulWidget {
  const MultiproviderRGBColorScreen({super.key});

  @override
  State<MultiproviderRGBColorScreen> createState() =>
      _MultiproviderRGBColorScreenState();
}

class _MultiproviderRGBColorScreenState
    extends State<MultiproviderRGBColorScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // Provides multiple independent states.
      providers: [
        ChangeNotifierProvider(create: (_) => BlueChannel()),
        ChangeNotifierProvider(create: (_) => GreenChannel()),
        ChangeNotifierProvider(create: (_) => RedChannel()),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(
            'Create Base Color',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(padding: EdgeInsets.all(32), child: MyColor()),
            ),
            Padding(
              padding: EdgeInsets.all(32),
              child: MyColorSlider<BlueChannel>(),
            ),
            Padding(
              padding: EdgeInsets.all(32),
              child: MyColorSlider<GreenChannel>(),
            ),
            Padding(
              padding: EdgeInsets.all(32),
              child: MyColorSlider<RedChannel>(),
            ),
          ],
        ),
      ),
    );
  }
}
