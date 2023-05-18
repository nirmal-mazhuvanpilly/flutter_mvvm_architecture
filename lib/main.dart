import 'package:flutter/material.dart';
import 'package:flutter_mvvm_architecture/src/user/repo/user_repo.dart';
import 'package:flutter_mvvm_architecture/src/user/view/user_view.dart';
import 'package:get_it/get_it.dart';

void setUp() {
  GetIt.instance.registerFactory<UserRepo>(() => UserRepoImplements());
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
