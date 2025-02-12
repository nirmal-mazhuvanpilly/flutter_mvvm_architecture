import 'package:flutter_mvvm_architecture/utils/helpers/auto_dispose_view_model.dart';

class CounterGlobalProvider extends AutoDisposeViewModel
    with GlobalCounterStates {
  @override
  void incrementCounter() {
    counter = counter + 1;
    notifyListeners();
  }

  @override
  void decrementCounter() {
    counter = counter - 1;
    notifyListeners();
  }
}

class CounterProvider extends AutoDisposeViewModel with CounterStates {
  @override
  void incrementCounterOne() {
    counterOne = counterOne + 1;
    notifyListeners();
  }

  @override
  void decrementCounterOne() {
    counterOne = counterOne - 1;
    notifyListeners();
  }

  @override
  void incrementCounterTwo() {
    counterTwo = counterTwo + 1;
    notifyListeners();
  }

  @override
  void decrementCounterTwo() {
    counterTwo = counterTwo - 1;
    notifyListeners();
  }

  @override
  void incrementCounterThree() {
    counterThree = counterThree + 1;
    notifyListeners();
  }

  @override
  void decrementCounterThree() {
    counterThree = counterThree - 1;
    notifyListeners();
  }

  @override
  void changeColorOne() {
    colorOne = !colorOne;
    notifyListeners();
  }

  @override
  void changeColorTwo() {
    colorTwo = !colorTwo;
    notifyListeners();
  }

  @override
  void changeColorThree() {
    colorThree = !colorThree;
    notifyListeners();
  }
}

mixin GlobalCounterStates {
  int counter = 0;
  void incrementCounter();

  void decrementCounter();
}

mixin CounterStates {
  int counterOne = 0;
  int counterTwo = 0;
  int counterThree = 0;
  bool colorOne = false;
  bool colorTwo = false;
  bool colorThree = false;

  void incrementCounterOne();

  void decrementCounterOne();

  void incrementCounterTwo();

  void decrementCounterTwo();

  void incrementCounterThree();

  void decrementCounterThree();

  void changeColorOne();

  void changeColorTwo();

  void changeColorThree();
}
