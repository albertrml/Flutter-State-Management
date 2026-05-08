import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_state_management/route/destine.dart';

class StateManagementWidget extends StatelessWidget {
  final String title;
  final List<Destine> destines;
  const StateManagementWidget({
    super.key,
    required this.title,
    required this.destines,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),

        Divider(indent: 32, endIndent: 32),

        GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),

          crossAxisCount: 2,
          padding: EdgeInsets.all(32),
          crossAxisSpacing: 8,
          childAspectRatio: 0.75,

          children: destines
              .map(
                (item) => GestureDetector(
                  onTap: () => context.push(item.route),
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(item.icon, size: 48, color: Colors.blue),
                          Text(
                            item.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            item.description,
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
              )
              .toList(),
        ),
      ],
    );
  }
}
