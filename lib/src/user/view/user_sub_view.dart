import 'package:flutter/material.dart';
import 'package:flutter_mvvm_architecture/src/user/model/user.dart';
import 'package:flutter_mvvm_architecture/src/user/view/widgets/user_details_view.dart';
import 'package:flutter_mvvm_architecture/utils/common_widgets/switch_state.dart';
import 'package:flutter_mvvm_architecture/utils/helpers/provider_helper_class.dart';
import 'package:flutter_mvvm_architecture/src/user/view_model/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class UserSubView extends StatelessWidget {
  const UserSubView({
    Key? key,
    required this.userProvider,
  }) : super(key: key);

  final UserProvider userProvider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: userProvider,
      child: Scaffold(
        body: Center(
          child: Container(
            width: double.infinity,
            color: Colors.red,
            child: Selector<UserProvider, Tuple2<UserModel?, LoaderState>>(
                selector: (context, provider) =>
                    Tuple2(provider.userModel, provider.loaderState),
                builder: (context, value, child) {
                  return SwitchState(
                    loaderState: value.item2,
                    loadingView:
                        const Center(child: CircularProgressIndicator()),
                    loadedView: UserDetailsView(userModel: value.item1),
                    networkErrorView: const Text("Network Error"),
                    errorView: const Text("Error"),
                    noDataView: const Text("No Details Found"),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
