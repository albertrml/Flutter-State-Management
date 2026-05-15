import 'package:flutter/material.dart';
import 'package:flutter_state_management/main/route/destine.dart';
import 'package:go_router/go_router.dart';

class StateManagementCard extends StatelessWidget {
  final Destine destine;
  const StateManagementCard({super.key, required this.destine});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(destine.route),
      child: Card(
        elevation: 4,
        child: SizedBox(
          height: 220,
          width: 200,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(destine.icon, size: 48, color: Colors.blue),
                Text(
                  destine.title,
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  destine.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
