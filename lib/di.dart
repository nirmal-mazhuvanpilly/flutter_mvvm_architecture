import 'package:flutter_mvvm_architecture/src/user/repo/user_repo.dart';
import 'package:get_it/get_it.dart';

Future<void> setUp() async {
  GetIt.instance.registerFactory<UserRepo>(() => UserRepoImplements());
}
