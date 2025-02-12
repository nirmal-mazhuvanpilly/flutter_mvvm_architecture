import 'package:flutter_mvvm_architecture/src/counter/view_model/counter_provider.dart';

class CounterArguments {
  final int selectedCounter;
  final CounterProvider counterProvider;
  CounterArguments({
    required this.selectedCounter,
    required this.counterProvider,
  });
}
