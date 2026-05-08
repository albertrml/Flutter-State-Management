import 'package:flutter/material.dart';
import 'package:flutter_state_management/app_state/multiprovider_multiconsumer/model/color_channel.dart';
import 'package:provider/provider.dart';

class MyColor extends StatefulWidget {
  const MyColor({super.key});

  @override
  State<MyColor> createState() => _MyColorState();
}

class _MyColorState extends State<MyColor> {
  @override
  Widget build(BuildContext context) {
    // Consumer3 listens simultaneously to three providers.
    return Consumer3<RedChannel, GreenChannel, BlueChannel>(
      builder: (ctx, r, g, b, _) => Center(
        child: Container(
          width: 200,
          height: 200,
          // Combined application state.
          color: Color.fromRGBO(r.toInt(), g.toInt(), b.toInt(), 1),
        ),
      ),
    );
  }
}
