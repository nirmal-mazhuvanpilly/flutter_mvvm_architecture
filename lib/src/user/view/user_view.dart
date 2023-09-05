import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mvvm_architecture/data/local/hive/user_details.dart';
import 'package:flutter_mvvm_architecture/src/global_view_model/app_data_provider.dart';
import 'package:flutter_mvvm_architecture/src/user/model/user.dart';
import 'package:flutter_mvvm_architecture/src/user/repo/user_repo.dart';
import 'package:flutter_mvvm_architecture/src/user/view/widgets/user_details_view.dart';
import 'package:flutter_mvvm_architecture/utils/common_widgets/switch_state.dart';
import 'package:flutter_mvvm_architecture/utils/helpers/provider_helper_class.dart';
import 'package:flutter_mvvm_architecture/src/user/view_model/user_provider.dart';
import 'package:flutter_mvvm_architecture/utils/routes/route_generator.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class UserView extends StatefulWidget {
  const UserView({Key? key}) : super(key: key);

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  UserProvider userProvider = UserProvider(
    services: GetIt.instance<UserRepo>(),
  );

  @override
  void initState() {
    super.initState();
    userProvider.getCompleteDetails(loaderStateEnabled: true);
  }

  @override
  void dispose() {
    userProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: userProvider,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Selector<UserProvider, Tuple2<UserModel?, LoaderState>>(
                  selector: (context, provider) =>
                      Tuple2(provider.userModel, provider.loaderState),
                  builder: (context, value, child) {
                    return SwitchState(
                      loaderState: value.item2,
                      loadingView: const CircularProgressIndicator(),
                      loadedView: UserDetailsView(userModel: value.item1),
                      networkErrorView: const Text("Network Error"),
                      errorView: const Text("Error"),
                      noDataView: const Text("No Details Found"),
                    );
                  }),
              TextButton(
                  onPressed: () {
                    userProvider.getCompleteDetails(loaderStateEnabled: true);
                  },
                  child: const Text("Refresh")),
              TextButton(
                  onPressed: () async {
                    final user = User(
                      name: "Nirmal Mazhuvanpilly",
                      age: Random().nextInt(40),
                      friends: [
                        "Risto",
                        "Laiju",
                      ],
                    );

                    userProvider.addUserDetails(user);
                  },
                  child: const Text("Add")),
              ValueListenableBuilder<Box>(
                  valueListenable: Hive.box<User>('userBox').listenable(),
                  builder: (context, box, child) {
                    User? user = box.get("CurrentUser");
                    return Column(
                      children: [
                        Text(user?.name ?? ""),
                        Text(user?.age.toString() ?? ""),
                      ],
                    );
                  }),
              NextPageButton(userRepo: GetIt.instance<UserRepo>()),
              NextPageButton(userRepo: GetIt.instance<UserRepo>()),
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(RouteGenerator.routeUserView);
                  },
                  child: const Text("User view")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                        RouteGenerator.routeUserSubView,
                        arguments: userProvider);
                  },
                  child: const Text("User sub view")),
            ],
          ),
        ),
      ),
    );
  }
}

class NextPageButton extends StatefulWidget {
  final UserRepo userRepo;
  const NextPageButton({Key? key, required this.userRepo}) : super(key: key);

  @override
  State<NextPageButton> createState() => _NextPageButtonState();
}

class _NextPageButtonState extends State<NextPageButton> {
  @override
  void dispose() {
    widget.userRepo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appDataModel = context.read<AppDataProvider>();
    return ValueListenableBuilder<LoaderState>(
        valueListenable: widget.userRepo.navigateLoaderState,
        builder: (context, value, child) {
          return GestureDetector(
            onTap: () async {
              if (value == LoaderState.loading) return;
              final res =
                  await widget.userRepo.navigateToNextPage(value: "Rasta");
              appDataModel.userName = res;
              SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.of(context)
                    .pushNamed(RouteGenerator.routeNftDetailsView);
              });
            },
            child: Container(
              alignment: Alignment.center,
              height: 40,
              width: double.maxFinite,
              color: Colors.blue,
              child: value == LoaderState.loading
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.white))
                  : const Text(
                      "Next Page",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
            ),
          );
        });
  }
}
