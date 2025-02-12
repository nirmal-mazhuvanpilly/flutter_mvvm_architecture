import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_architecture/res/styles/fonts/inter_font.dart';
import 'package:flutter_mvvm_architecture/src/counter/view_model/counter_provider.dart';
import 'package:flutter_mvvm_architecture/utils/routes/arguments/counter_arguments.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class CounterScopedScreen extends StatelessWidget {
  final CounterArguments arguments;
  const CounterScopedScreen({super.key, required this.arguments});

  Tuple2<int, bool> selectedVariable() {
    switch (arguments.selectedCounter) {
      case 1:
        return Tuple2(arguments.counterProvider.counterOne,
            arguments.counterProvider.colorOne);
      case 2:
        return Tuple2(arguments.counterProvider.counterTwo,
            arguments.counterProvider.colorTwo);
      case 3:
        return Tuple2(arguments.counterProvider.counterThree,
            arguments.counterProvider.colorThree);
      default:
        return Tuple2(arguments.counterProvider.counterOne,
            arguments.counterProvider.colorOne);
    }
  }

  void selectedIncrementMethod() {
    switch (arguments.selectedCounter) {
      case 1:
        arguments.counterProvider.incrementCounterOne();
        break;
      case 2:
        arguments.counterProvider.incrementCounterTwo();
        break;
      case 3:
        arguments.counterProvider.incrementCounterThree();
        break;
    }
  }

  void selectedDecrementMethod() {
    switch (arguments.selectedCounter) {
      case 1:
        arguments.counterProvider.decrementCounterOne();
        break;
      case 2:
        arguments.counterProvider.decrementCounterTwo();
        break;
      case 3:
        arguments.counterProvider.decrementCounterThree();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: arguments.counterProvider,
      child: Scaffold(
        body: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Selector<CounterProvider, Tuple2<int, bool>>(
                    selector: (context, provider) => selectedVariable(),
                    builder: (context, value, child) {
                      return Text(
                        value.item1.toString(),
                        style: InterFontPalette.fBlack_20_800.copyWith(
                            color: (value.item2) ? Colors.red : Colors.black),
                      );
                    }),
                Builder(builder: (context) {
                  log("Scoped View Button rebuilds");
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            selectedDecrementMethod();
                          },
                          child: const Text("-")),
                      TextButton(
                          onPressed: () {
                            selectedIncrementMethod();
                          },
                          child: const Text("+")),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
