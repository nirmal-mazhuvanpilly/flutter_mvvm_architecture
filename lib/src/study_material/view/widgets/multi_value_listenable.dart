import 'package:flutter/foundation.dart';

class MultiValueListenable implements ValueListenable<bool> {
  final List<ValueListenable> valueListenable;
  late final Listenable listenable;
  bool val = false;

  MultiValueListenable(this.valueListenable) {
    listenable = Listenable.merge(valueListenable);
    listenable.addListener(onNotified);
  }

  @override
  void addListener(VoidCallback listener) {
    listenable.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    listenable.removeListener(listener);
  }

  @override
  bool get value => val;

  void onNotified() {
    val = !val;
  }
}
