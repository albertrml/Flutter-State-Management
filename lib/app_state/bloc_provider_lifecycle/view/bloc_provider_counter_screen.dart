import 'package:flutter/material.dart';
import 'package:flutter_state_management/app_state/bloc_provider_lifecycle/component/bloc_provider_create_widget.dart';
import 'package:flutter_state_management/app_state/bloc_provider_lifecycle/component/bloc_provider_value_widget.dart';

class BlocProviderCounterScreen extends StatelessWidget {
  final String title;
  const BlocProviderCounterScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      ),

      body: Column(
        children: [
          /*
           * First half of the screen:
           * BlocProvider(create:)
           */
          Expanded(
            child: _LifecycleSection(
              title: 'BlocProvider.create',
              child: const BlocProviderCreateWidget(),
            ),
          ),

          /*
           * Second half of the screen:
           * BlocProvider.value
           */
          Expanded(
            child: _LifecycleSection(
              title: 'BlocProvider.value',
              child: const BlocProviderValueWidget(),
            ),
          ),
        ],
      ),
    );
  }
}

// Reusable layout section for lifecycle examples.
class _LifecycleSection extends StatelessWidget {
  final String title;
  final Widget child;

  const _LifecycleSection({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),

      child: Column(
        children: [
          // Section title
          Text(title, style: Theme.of(context).textTheme.titleLarge),

          const SizedBox(height: 8),

          // Section divider
          const Divider(indent: 32, endIndent: 32),

          // Center remaining content
          Expanded(child: Center(child: child)),
        ],
      ),
    );
  }
}
