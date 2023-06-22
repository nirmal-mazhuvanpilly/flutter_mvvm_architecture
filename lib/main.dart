import 'package:flutter/material.dart';
import 'package:flutter_mvvm_architecture/data/local/hive/hive_storage.dart';
import 'package:flutter_mvvm_architecture/src/global_view_model/app_data_provider.dart';
import 'package:flutter_mvvm_architecture/src/user/view/user_view.dart';
import 'package:provider/provider.dart';
import 'di.dart';

void main() async {
  await initHive();
  await setUp();
  await openHiveBoxes();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppDataProvider()),
      ],
      child: MaterialApp(
        title: '',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const UserView(),
      ),
    );
  }
}
