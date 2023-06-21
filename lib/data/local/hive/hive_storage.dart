import 'package:flutter_mvvm_architecture/data/local/hive/user_details.dart';
import 'package:flutter_mvvm_architecture/data/local/local_storage.dart';
import 'package:hive_flutter/adapters.dart';

class HiveStorage extends LocalStorage {
  HiveStorage() {
    init();
  }

  Box<User>? box;

  void init() {
    box = Hive.box<User>('userBox');
  }

  @override
  Future<User?> getUserDetails() async {
    return box?.get("CurrentUser");
  }

  @override
  Future<void> addUserDetails(User user) async {
    await box?.put("CurrentUser", user);
  }
}

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
}

Future<void> openHiveBoxes() async {
  await Hive.openBox<User>('userBox');
}
