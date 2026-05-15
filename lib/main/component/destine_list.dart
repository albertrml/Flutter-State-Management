import 'package:flutter/material.dart';
import 'package:flutter_state_management/main/route/destine.dart';
import 'package:flutter_state_management/main/state_management_card.dart';

class DestineList extends StatelessWidget {
  final List<Destine> destines;
  const DestineList({super.key, required this.destines});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 200),
        child: ListView.builder(
          itemCount: destines.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return StateManagementCard(destine: destines[index]);
          },
        ),
      ),
    );
  }
}
