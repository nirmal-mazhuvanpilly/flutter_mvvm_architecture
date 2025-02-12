import 'package:flutter/cupertino.dart';
import 'package:flutter_mvvm_architecture/src/counter/view/counter_scoped_screen.dart';
import 'package:flutter_mvvm_architecture/src/counter/view/counter_screen.dart';
import 'package:flutter_mvvm_architecture/src/home/view/home_screen.dart';
import 'package:flutter_mvvm_architecture/src/passenger/view/passenger_screen.dart';
import 'package:flutter_mvvm_architecture/utils/common_widgets/empty_screen.dart';
import 'package:flutter_mvvm_architecture/utils/routes/arguments/counter_arguments.dart';
import 'package:flutter_mvvm_architecture/utils/routes/route_constants.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class RouteGenerator {
  static Route generateRoute(
    RouteSettings settings,
  ) {
    var args = settings.arguments;
    switch (settings.name) {
      case RouteConstants.routeInitialScreen:
        return _buildRoute(
            RouteConstants.routeInitialScreen, const HomeScreen());
      case RouteConstants.routeCounterScreen:
        return _buildRoute(RouteConstants.routeCounterScreen, CounterScreen());
      case RouteConstants.routeCounterScopedScreen:
        return _buildRoute(RouteConstants.routeCounterScreen,
            CounterScopedScreen(arguments: args as CounterArguments));
      case RouteConstants.routePassengerScreen:
        return _buildRoute(
            RouteConstants.routePassengerScreen, const PassengerScreen());

      default:
        return _buildRoute(
            RouteConstants.routeEmptyScreen, const EmptyScreen());
    }
  }
}

Route _buildRoute(String route, Widget widget,
    {bool enableFullScreen = false}) {
  return CupertinoPageRoute(
      fullscreenDialog: enableFullScreen,
      settings: RouteSettings(name: route),
      builder: (_) => widget);
}
