import 'package:flutter/material.dart';
import 'package:flutter_mvvm_architecture/repositories/user/user_services.dart';
import 'package:flutter_mvvm_architecture/services/network/base_services.dart';
import 'package:flutter_mvvm_architecture/services/network/services.dart';
import 'package:flutter_mvvm_architecture/view/user/user_view.dart';
import 'package:get_it/get_it.dart';

void setUp() {
  GetIt.instance.registerLazySingleton<BaseServices>(() => Services());
  GetIt.instance.registerFactory<UserServices>(() => UserServices());
}

void main() {
  setUp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const UserView(),
    );
  }
}
