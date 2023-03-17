enum LoaderState { loaded, loading, error, networkError, noData }

abstract class ProviderHelperClass {
  LoaderState loaderState = LoaderState.loaded;
  void updateLoadState(LoaderState state);
  bool enableLoaderState = true;
}
