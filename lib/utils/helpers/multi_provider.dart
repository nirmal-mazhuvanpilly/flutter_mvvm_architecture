import 'package:flutter_mvvm_architecture/src/counter/view_model/counter_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class MultiProviderClass {
  static List<SingleChildWidget> providerLists = [
    ChangeNotifierProvider(create: (context) => CounterGlobalProvider()),
  ];
}
