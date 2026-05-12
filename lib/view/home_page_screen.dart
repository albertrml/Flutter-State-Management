import 'package:flutter/material.dart';
import 'package:flutter_state_management/route/destine.dart';
import 'package:flutter_state_management/view/state_management_widget.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Home Page', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 32, bottom: 32),
        child: ListView(
          children: [
            StateManagementWidget(
              title: 'Ephemeral State Management',
              destines: ephemeralStatedestines,
            ),

            SizedBox(height: 32),

            StateManagementWidget(
              title: 'App State Management',
              destines: appStateDestines,
            ),
          ],
        ),
      ),
    );
  }
}
