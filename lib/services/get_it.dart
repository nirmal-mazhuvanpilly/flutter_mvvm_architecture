import 'package:flutter_mvvm_architecture/data/local/local_base_services.dart';
import 'package:flutter_mvvm_architecture/data/local/sembast_services.dart';
import 'package:flutter_mvvm_architecture/data/remote/network_base_services.dart';
import 'package:flutter_mvvm_architecture/data/remote/network_services.dart';
import 'package:flutter_mvvm_architecture/src/passenger/repo/passenger_repo.dart';
import 'package:flutter_mvvm_architecture/src/study_material/repo/feed_repo.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerLazySingleton<LocalBaseServices>(() => HiveServices());
  getIt.registerLazySingleton<NetWorkBaseServices>(() => NetworkServices());
  getIt.registerLazySingleton<PassengerRepo>(() => PassengerRepoImplements());
  getIt.registerLazySingleton<FeedRepo>(() => FeedRepoTestImplements());
}
