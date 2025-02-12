import 'package:flutter/material.dart';
import 'package:flutter_mvvm_architecture/services/get_it.dart';
import 'package:flutter_mvvm_architecture/utils/helpers/multi_provider.dart';
import 'package:flutter_mvvm_architecture/utils/routes/route_constants.dart';
import 'package:flutter_mvvm_architecture/utils/routes/route_generator.dart';
import 'package:provider/provider.dart';

void main() async {
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: MultiProviderClass.providerLists,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Riverpod',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: RouteConstants.routeInitialScreen,
        onGenerateRoute: RouteGenerator.generateRoute,
        navigatorKey: navigatorKey,
      ),
    );
  }
}
