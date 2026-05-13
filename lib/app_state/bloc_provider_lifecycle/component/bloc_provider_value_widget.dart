import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_state_management/app_state/bloc_provider_lifecycle/bloc/cubit/counter_cubit.dart';

class BlocProviderValueWidget extends StatefulWidget {
  const BlocProviderValueWidget({super.key});

  @override
  State<BlocProviderValueWidget> createState() =>
      _BlocProviderValueWidgetState();
}

class _BlocProviderValueWidgetState extends State<BlocProviderValueWidget> {
  /*
   * The Cubit is created outside BlocProvider.
   * 
   * Therefore, this widget becomes responsible
   * for closing the Cubit manually.
   */
  late final CounterCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = CounterCubit();
  }

  @override
  void dispose() {
    /*
     * BlocProvider.value DOES NOT autommatically close cubit.
     * Manual dispose is required.
     */
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      /*
       * BlocProvider.value only exposes
       * an existing Cubit instance.
       *
       * It does NOT own the lifecycle.
       */
      value: cubit,
      child: Center(
        child: BlocBuilder<CounterCubit, int>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  state.toString(),
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Text('Counter', style: Theme.of(context).textTheme.bodyMedium),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.read<CounterCubit>().increment(),
                  child: const Text('Increment'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
