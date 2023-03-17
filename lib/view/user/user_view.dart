import 'package:flutter/material.dart';
import 'package:flutter_mvvm_architecture/model/user/user.dart';
import 'package:flutter_mvvm_architecture/utils/common_widgets/switch_state.dart';
import 'package:flutter_mvvm_architecture/utils/provider_helper_class.dart';
import 'package:flutter_mvvm_architecture/view/user/widgets/user_details_view.dart';
import 'package:flutter_mvvm_architecture/view_model/user/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class UserView extends StatefulWidget {
  const UserView({Key? key}) : super(key: key);

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  UserProvider userProvider = UserProvider();

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
                    userProvider.getCompleteDetails(loaderStateEnabled: false);
                  },
                  child: const Text("Refresh")),
            ],
          ),
        ),
      ),
    );
  }
}
