import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_architecture/res/constants/string_constants.dart';
import 'package:flutter_mvvm_architecture/res/styles/fonts/inter_font.dart';
import 'package:flutter_mvvm_architecture/src/counter/view_model/counter_provider.dart';
import 'package:flutter_mvvm_architecture/utils/routes/arguments/counter_arguments.dart';
import 'package:flutter_mvvm_architecture/utils/routes/route_constants.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class CounterScreen extends StatelessWidget {
  CounterScreen({super.key});

  final CounterProvider counterProvider = CounterProvider();
  @override
  Widget build(BuildContext context) {
    log("***************#########Rebuilds Build Method#########***************");
    final globalCounterProvider = context.read<CounterGlobalProvider>();
    return ChangeNotifierProvider.value(
      value: counterProvider,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Selector<CounterGlobalProvider, int>(
                        selector: (context, provider) => provider.counter,
                        builder: (context, value, child) {
                          log("Counter One rebuilds");
                          return Text(
                            value.toString(),
                            style: InterFontPalette.fBlack_20_800,
                          );
                        }),
                    Builder(builder: (context) {
                      log("Counter Button rebuilds");
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {
                                globalCounterProvider.decrementCounter();
                              },
                              child: Text(
                                "-",
                                style: InterFontPalette.f616068_10_400,
                              )),
                          TextButton(
                              onPressed: () {
                                globalCounterProvider.incrementCounter();
                              },
                              child: Text(
                                "+",
                                style: InterFontPalette.f616068_10_400,
                              )),
                        ],
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Selector<CounterProvider, Tuple2<int, bool>>(
                            selector: (context, provider) =>
                                Tuple2(provider.counterOne, provider.colorOne),
                            builder: (context, value, child) {
                              log("Counter One rebuilds");
                              return Text(
                                value.item1.toString(),
                                style: TextStyle(
                                    color: (value.item2)
                                        ? Colors.red
                                        : Colors.black,
                                    fontWeight: FontWeight.bold),
                              );
                            }),
                        Builder(builder: (context) {
                          log("Counter One Button rebuilds");
                          return Column(
                            children: [
                              Row(
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        counterProvider.decrementCounterOne();
                                      },
                                      child: const Text("-")),
                                  TextButton(
                                      onPressed: () {
                                        counterProvider.incrementCounterOne();
                                      },
                                      child: const Text("+")),
                                ],
                              ),
                              TextButton(
                                  onPressed: () {
                                    counterProvider.changeColorOne();
                                  },
                                  child: const Text(Strings.changeColor)),
                            ],
                          );
                        }),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                RouteConstants.routeCounterScopedScreen,
                                arguments: CounterArguments(
                                  selectedCounter: 1,
                                  counterProvider: counterProvider,
                                ),
                              );
                            },
                            child: const Text(Strings.nextPage)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Selector<CounterProvider, Tuple2<int, bool>>(
                            selector: (context, provider) =>
                                Tuple2(provider.counterTwo, provider.colorTwo),
                            builder: (context, value, child) {
                              log("Counter Two rebuilds");
                              return Text(
                                value.item1.toString(),
                                style: TextStyle(
                                    color: (value.item2)
                                        ? Colors.red
                                        : Colors.black,
                                    fontWeight: FontWeight.bold),
                              );
                            }),
                        Builder(builder: (context) {
                          log("Counter Two Button rebuilds");
                          return Column(
                            children: [
                              Row(
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        counterProvider.decrementCounterTwo();
                                      },
                                      child: const Text("-")),
                                  TextButton(
                                      onPressed: () {
                                        counterProvider.incrementCounterTwo();
                                      },
                                      child: const Text("+")),
                                ],
                              ),
                              TextButton(
                                  onPressed: () {
                                    counterProvider.changeColorTwo();
                                  },
                                  child: const Text(Strings.changeColor)),
                            ],
                          );
                        }),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                RouteConstants.routeCounterScopedScreen,
                                arguments: CounterArguments(
                                  selectedCounter: 2,
                                  counterProvider: counterProvider,
                                ),
                              );
                            },
                            child: const Text(Strings.nextPage)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Selector<CounterProvider, Tuple2<int, bool>>(
                            selector: (context, provider) => Tuple2(
                                provider.counterThree, provider.colorThree),
                            builder: (context, value, child) {
                              log("Counter Three rebuilds");
                              return Text(
                                value.item1.toString(),
                                style: TextStyle(
                                    color: (value.item2)
                                        ? Colors.red
                                        : Colors.black,
                                    fontWeight: FontWeight.bold),
                              );
                            }),
                        Builder(builder: (context) {
                          log("Counter Three Button rebuilds");
                          return Column(
                            children: [
                              Row(
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        counterProvider.decrementCounterThree();
                                      },
                                      child: const Text("-")),
                                  TextButton(
                                      onPressed: () {
                                        counterProvider.incrementCounterThree();
                                      },
                                      child: const Text("+")),
                                ],
                              ),
                              TextButton(
                                  onPressed: () {
                                    counterProvider.changeColorThree();
                                  },
                                  child: const Text(Strings.changeColor)),
                            ],
                          );
                        }),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                RouteConstants.routeCounterScopedScreen,
                                arguments: CounterArguments(
                                  selectedCounter: 3,
                                  counterProvider: counterProvider,
                                ),
                              );
                            },
                            child: const Text(Strings.nextPage)),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(RouteConstants.routeCounterScreen);
                  },
                  child: const Text(Strings.nextPage)),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
