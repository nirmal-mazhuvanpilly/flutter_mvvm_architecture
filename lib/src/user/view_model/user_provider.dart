import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mvvm_architecture/data/local/hive/user_details.dart';
import 'package:flutter_mvvm_architecture/src/user/model/user.dart';
import 'package:flutter_mvvm_architecture/src/user/repo/user_repo.dart';
import 'package:flutter_mvvm_architecture/utils/helpers/provider_helper_class.dart';

class UserProvider extends ChangeNotifier
    with UserVariables, ProviderHelperClass {
  bool _isDisposed = false;

  UserRepo services;

  UserProvider({required this.services});

  @override
  UserModel? get userModel => _userModel;
  UserModel? _userModel;

  @override
  User? get userDetails => _userDetails;
  User? _userDetails;

  @override
  void updateLoadState(LoaderState state) {
    loaderState = state;
    notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (_isDisposed) return;
    super.notifyListeners();
  }

  @override
  Future<void> getCompleteDetails({bool loaderStateEnabled = true}) async {
    enableLoaderState = loaderStateEnabled;
    if (enableLoaderState) updateLoadState(LoaderState.loading);
    Future.delayed(const Duration(seconds: 1), () async {
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

  LoaderState? userDetailsLoaderState;
  updateUserDetailsLoaderState(LoaderState state) {
    userDetailsLoaderState = state;
    notifyListeners();
  }

  @override
  Future<void> getUserDetails() async {
    services.getUserDetails();
  }

  @override
  Future<void> addUserDetails(User user) async {
    services.addUserDetails(user);
  }
}

abstract class UserVariables {
  UserModel? userModel;
  User? userDetails;
  Future<void> getCompleteDetails();
  Future<void> getUserDetails();
  Future<void> addUserDetails(User user);
}
