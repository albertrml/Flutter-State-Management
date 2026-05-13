import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0) {
    debugPrint('CounterCubit: CREATED');
  }

  void increment() => emit(state + 1);

  @override
  Future<void> close() {
    debugPrint('CounterCubit: CLOSED');
    return super.close();
  }
}
