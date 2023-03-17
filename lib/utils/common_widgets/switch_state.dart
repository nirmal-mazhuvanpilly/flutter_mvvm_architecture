import 'package:flutter/material.dart';
import 'package:flutter_mvvm_architecture/utils/helpers/provider_helper_class.dart';

class SwitchState extends StatelessWidget {
  final LoaderState loaderState;
  final Widget? loadedView;
  final Widget? loadingView;
  final Widget? errorView;
  final Widget? networkErrorView;
  final Widget? noDataView;
  const SwitchState({
    Key? key,
    this.loaderState = LoaderState.loaded,
    this.loadedView,
    this.loadingView,
    this.errorView,
    this.networkErrorView,
    this.noDataView,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (loaderState) {
      case LoaderState.loaded:
        return loadedView ?? const SizedBox.shrink();
      case LoaderState.loading:
        return loadingView ?? const SizedBox.shrink();
      case LoaderState.error:
        return errorView ?? const SizedBox.shrink();
      case LoaderState.networkError:
        return networkErrorView ?? const SizedBox.shrink();
      case LoaderState.noData:
        return noDataView ?? const SizedBox.shrink();
    }
  }
}
