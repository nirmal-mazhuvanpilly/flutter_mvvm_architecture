import 'package:flutter/material.dart';
import 'package:flutter_mvvm_architecture/src/user/model/user.dart';

class UserDetailsView extends StatelessWidget {
  final UserModel? userModel;
  const UserDetailsView({Key? key, this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("User Details"),
        Text(userModel?.userId?.toString() ?? ""),
        Text(userModel?.id?.toString() ?? ""),
        Text(userModel?.title?.toString() ?? ""),
        Text(userModel?.completed?.toString() ?? ""),
      ],
    );
  }
}
