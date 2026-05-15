import 'package:flutter/material.dart';
import 'package:flutter_state_management/main/component/state_management_view.dart';
import 'package:flutter_state_management/main/route/destine.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(
            'Home Page',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Ephemeral State', icon: Icon(Icons.flash_on)),
              Tab(text: 'App State', icon: Icon(Icons.apps)),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
          child: TabBarView(
            children: [
              StateManagementView(
                title: 'Ephemeral State Management',
                destineGroups: ephemeralStateDestines,
              ),

              StateManagementView(
                title: 'App State Management',
                destineGroups: appStateDestines,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
