import 'package:flutter/material.dart';
import 'package:flutter_state_management/main/route/destine.dart';
import 'package:flutter_state_management/main/component/category_title.dart';
import 'package:flutter_state_management/main/component/destine_list.dart';

class StateManagementView extends StatelessWidget {
  final String title;
  final Map<StateManagementType, List<Destine>> destineGroups;
  const StateManagementView({
    super.key,
    required this.title,
    required this.destineGroups,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: CategoryTitle(title: title)),

        ...destineGroups.entries.map((entry) {
          return SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Text(
                    entry.key.name,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                const SizedBox(
                  height: 8,
                  child: Divider(
                    color: Colors.deepPurple,
                    thickness: 2,
                    indent: 16,
                    endIndent: 16,
                  ),
                ),

                DestineList(destines: entry.value),
              ],
            ),
          );
        }),
      ],
    );
  }
}
