import 'package:either_dart/either.dart';
import 'package:flutter_mvvm_architecture/model/passengers/passengers_model.dart';
import 'package:flutter_mvvm_architecture/res/enums/enums.dart';
import 'package:flutter_mvvm_architecture/src/passenger/repo/passenger_repo.dart';
import 'package:flutter_mvvm_architecture/utils/helpers/auto_dispose_view_model.dart';

class PassengerProvider extends AutoDisposeViewModel with PassengerStates {
  late final PassengerRepo repo;
  PassengerProvider({required this.repo});

  @override
  void changeLoaderState(LoaderState state) {
    loaderState = state;
    notifyListeners();
  }

  void getPassengers({bool enableLoaderState = true, int? page}) async {
    if (enableLoaderState) {
      changeLoaderState(LoaderState.loading);
    }
    try {
      await repo.getPassengers(page: page).fold(
        (left) {
          if (enableLoaderState) {
            changeLoaderState(LoaderState.networkError);
          }
        },
        (right) {
          final currentData = passengersList;
          if (currentData == null || (currentData.isEmpty)) {
            passengersList = right?.data;
            if (enableLoaderState) {
              changeLoaderState(LoaderState.loaded);
            }
          } else {
            final List<PassengerData> passengers = [
              ...currentData,
              ...right?.data ?? []
            ];
            passengersList = passengers;
            if (enableLoaderState) {
              changeLoaderState(LoaderState.loaded);
            }
          }
          pageCount = pageCount + 1;
          totalPageCount = right?.totalPages;
        },
      );
    } catch (e) {
      error = e.toString();
      if (enableLoaderState) {
        changeLoaderState(LoaderState.error);
      }
    }
  }
}

mixin PassengerStates {
  int pageCount = 1;
  int? totalPageCount;
  List<PassengerData>? passengersList;
  String? error;
  LoaderState? loaderState;
  bool? enableLoaderState;

  changeLoaderState(LoaderState state);
}
