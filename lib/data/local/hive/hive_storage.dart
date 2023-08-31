import 'package:flutter_mvvm_architecture/data/local/hive/user_details.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
}

Future<void> openHiveBoxes() async {
  await Hive.openBox<User>('userBox');
}
