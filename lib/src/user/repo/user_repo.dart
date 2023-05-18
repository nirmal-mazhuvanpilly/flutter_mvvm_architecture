import 'dart:math';

import 'package:either_dart/either.dart';
import 'package:flutter_mvvm_architecture/data/remote/api_request.dart';
import 'package:flutter_mvvm_architecture/data/remote/resposne_error.dart';
import 'package:flutter_mvvm_architecture/src/user/model/user.dart';

abstract class UserRepo {
  Future<Either<ResponseError, UserModel?>> getDetailedResponse();
}

class UserRepoImplements extends UserRepo {
  @override
  Future<Either<ResponseError, UserModel?>> getDetailedResponse() {
    Random random = Random();
    int randomNumber = random.nextInt(100);
    return safe(getRequest(endPoint: "todos/$randomNumber"))
        .thenRight(checkHttpStatus)
        .thenRight(parseJson)
        .mapRight((right) {
      return UserModel.fromJson(right);
    });
  }
}
