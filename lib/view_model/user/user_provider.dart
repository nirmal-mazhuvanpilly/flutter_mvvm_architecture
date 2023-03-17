import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mvvm_architecture/model/user/user.dart';
import 'package:flutter_mvvm_architecture/repositories/user_repo/user_services.dart';
import 'package:flutter_mvvm_architecture/utils/provider_helper_class.dart';
import 'package:get_it/get_it.dart';

class UserProvider extends ChangeNotifier
    with UserVariables, ProviderHelperClass {
  final services = GetIt.instance<UserServices>();

  @override
  UserModel? get userModel => _userModel;

  UserModel? _userModel;

  @override
  void updateLoadState(LoaderState state) {
    loaderState = state;
    notifyListeners();
  }

  @override
  Future<void> getCompleteDetails({bool loaderStateEnabled = true}) async {
    enableLoaderState = loaderStateEnabled;
    if (enableLoaderState) updateLoadState(LoaderState.loading);
    Future.delayed(const Duration(seconds: 3), () async {
      await services.getDetailedResponse().fold((left) {
        debugPrint(left.key.toString());
        debugPrint(left.message);
        if (enableLoaderState) updateLoadState(LoaderState.networkError);
      }, (right) {
        if (right == null) {
          if (enableLoaderState) updateLoadState(LoaderState.noData);
        } else {
          _userModel = right;
          if (enableLoaderState) updateLoadState(LoaderState.loaded);
        }
      }).catchError((error) {
        debugPrint(error.toString());
        if (enableLoaderState) updateLoadState(LoaderState.error);
      });
    });
  }
}

abstract class UserVariables {
  UserModel? userModel;
  Future<void> getCompleteDetails();
}
