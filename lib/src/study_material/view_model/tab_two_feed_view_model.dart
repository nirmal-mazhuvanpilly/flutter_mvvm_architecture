import 'package:either_dart/either.dart';
import 'package:flutter_mvvm_architecture/res/enums/enums.dart';
import 'package:flutter_mvvm_architecture/src/study_material/model/feed_model.dart';
import 'package:flutter_mvvm_architecture/src/study_material/repo/feed_repo.dart';
import 'package:flutter_mvvm_architecture/utils/helpers/auto_dispose_view_model.dart';
import 'package:flutter_mvvm_architecture/utils/helpers/common_functions.dart';

class TabTwoFeedViewModel extends AutoDisposeViewModel with FeedStates {
  late final FeedRepo repo;
  TabTwoFeedViewModel({required this.repo});

  @override
  void changeLoaderState(LoaderState state, bool isPaginating) {
    this.isPaginating = isPaginating;
    if (!this.isPaginating) {
      loaderState = state;
    }
    notifyListeners();
  }

  void getFeeds({bool isPaginating = false}) async {
    if (this.isPaginating) return;

    changeLoaderState(LoaderState.loading, isPaginating);

    try {
      await repo.getFeed(page: pageCount).fold(
        (left) {
          LoaderState state = handleResponseError(left.key);
          changeLoaderState(state, isPaginating);
        },
        (right) {
          if (right?.isNotEmpty ?? false) {
            updateTabOneData(right, isPaginating);
          } else {
            changeLoaderState(LoaderState.error, isPaginating);
          }
        },
      );
    } catch (e) {
      changeLoaderState(LoaderState.error, isPaginating);
    }
  }

  updateTabOneData(List<FeedModel>? data, bool isPaginating) {
    if (data != null) {
      final tempList = data ?? [];

      if (tempList.isNotEmpty) {
        feedList = [...feedList, ...tempList];
        pageCount++;
        changeLoaderState(LoaderState.loaded, false);
      } else if (tempList.isEmpty && feedList.isEmpty) {
        changeLoaderState(LoaderState.noData, false);
      } else if (feedList.isNotEmpty) {
        changeLoaderState(LoaderState.loaded, false);
      }
    } else {
      changeLoaderState(LoaderState.noData, false);
    }
    this.isPaginating = false;
    notifyListeners();
  }

  clearFeedData() {
    pageCount = 1;
    totalPageCount = 1;
    feedList = [];
    loaderState = LoaderState.loading;
    enableLoaderState = true;
  }
}

mixin FeedStates {
  int pageCount = 1;
  int? totalPageCount;
  List<FeedModel> feedList = [];
  LoaderState? loaderState;
  bool? enableLoaderState;
  bool isPaginating = false;

  changeLoaderState(LoaderState state, bool isPaginating);
}
