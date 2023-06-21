import 'package:flutter_mvvm_architecture/data/local/hive/hive_storage.dart';
import 'package:flutter_mvvm_architecture/data/local/local_storage.dart';
import 'package:flutter_mvvm_architecture/src/user/repo/user_repo.dart';
import 'package:get_it/get_it.dart';

Future<void> setUp() async {
  GetIt.instance.registerFactory<UserRepo>(() => UserRepoImplements());
  GetIt.instance.registerFactory<LocalStorage>(() => HiveStorage());
}























