import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_state_management/app_state/bloc_provider_lifecycle/bloc/cubit/counter_cubit.dart';

class BlocProviderCreateWidget extends StatelessWidget {
  const BlocProviderCreateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    /*
     * BlocProvider creates and owns the Cubit.
     * 
     * When this widget is removed from the tree,
     * the Cubit is automatically closed.
     */
    return BlocProvider(
      /*
       * BlocProvider creates and owns the Cubit.
       *
       * When this widget is removed from the tree,
       * the Cubit is automatically closed.
       */
      create: (_) => CounterCubit(),
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
