import 'package:flutter/material.dart';
import 'package:flutter_state_management/ephemeral_state/value_notifier/model/sky_controller.dart';

class ValueNotifierDayShiftScreen extends StatefulWidget {
  final String title;
  const ValueNotifierDayShiftScreen({super.key, required this.title});

  @override
  State<ValueNotifierDayShiftScreen> createState() =>
      _ValueNotifierDayShiftScreenState();
}

class _ValueNotifierDayShiftScreenState
    extends State<ValueNotifierDayShiftScreen> {
  /*
   * The controller is created once and persists during
   * the widget lifecycle.
   */
  final controller = SkyController();

  @override
  void dispose() {
    /*
     * Always dispose controllers/listenables created
     * inside StatefulWidgets.
     */
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /*
     * ValueListenableBuilder listens reactively to
     * ValueNotifier changes.
     * 
     * Whenever mode.value changes:
     * 
     * 1. the builder callback is executed again
     * 2. the UI rebuilds automatically
     * 3. no setState() is required
     */
    return ValueListenableBuilder(
      // The reactive state source.
      valueListenable: controller.mode,

      // mode contains the current ValueNotifier value.
      builder: (ctx, mode, _) {
        final isDay = (mode == SkyMode.day);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(ctx).colorScheme.inversePrimary,
            title: Text(
              widget.title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          body: AnimatedContainer(
            /*
             * AnimatedContainer automatically animates
             * property changes between rebuilds.
             * 
             * Since the gradient changes reactively,
             * Flutter interpolates the transition.
             */
            duration: const Duration(seconds: 1),

            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,

                // The gradient depends directly on state.
                colors: SkyController.skyMode(isDay),
              ),
            ),

            child: Center(
              child: IconButton(
                /*
                 * User interaction updates the state.
                 * 
                 * toggle() changes mode.value.
                 * 
                 * That triggers ValueNotifier listeners,
                 * causing ValueListenableBuilder to rebuild.
                 */
                onPressed: controller.toggle,
                icon: isDay
                    ? Icon(Icons.dark_mode, color: Colors.red)
                    : Icon(Icons.light_mode, color: Colors.white),
                iconSize: 64,
              ),
            ),
          ),
        );
      },
    );
  }
}
