import 'package:flutter/material.dart';
import 'package:flutter_mvvm_architecture/src/nft_details/view/nft_deatils_view.dart';
import 'package:flutter_mvvm_architecture/src/user/view/user_sub_view.dart';
import 'package:flutter_mvvm_architecture/src/user/view/user_view.dart';
import 'package:flutter_mvvm_architecture/src/user/view_model/user_provider.dart';
import 'package:flutter_mvvm_architecture/utils/common_widgets/error_view.dart';

class RouteGenerator {
  static const String routeInitial = "/";
  static const String routeError = "/error";
  static const String routeUserView = "/userView";
  static const String routeUserSubView = "/userSubView";
  static const String routeNftDetailsView = "/nftDetailsView";

  static Route generateRoute(
    RouteSettings settings,
  ) {
    var args = settings.arguments;
    switch (settings.name) {
      case routeInitial:
        return _buildRoute(routeInitial, const UserView());
      case routeUserView:
        return _buildRoute(routeUserView, const UserView());
      case routeUserSubView:
        final routeArgs = args as UserProvider;
        return _buildRoute(routeInitial, UserSubView(userProvider: routeArgs));
      case routeNftDetailsView:
        return _buildRoute(routeNftDetailsView, NftDetailsView());
      default:
        return _buildRoute(routeError, const ErrorView());
    }
  }
}

Route _buildRoute(String route, Widget widget,
    {bool enableFullScreen = false}) {
  return MaterialPageRoute(
      fullscreenDialog: enableFullScreen,
      settings: RouteSettings(name: route),
      builder: (_) => widget);
}
