import 'package:flutter_mvvm_architecture/model/user/user.dart';
import 'package:flutter_mvvm_architecture/services/network/api_request.dart';
import 'package:flutter_mvvm_architecture/services/network/base_services.dart';
import 'package:flutter_mvvm_architecture/services/network/resposne_error.dart';
import 'package:either_dart/either.dart';

class Services implements BaseServices {
  @override
  Future<Either<ResponseError, UserModel?>> getDetailedResponse() async {
    return safe(getRequest(endPoint: "todos/5"))
        .thenRight(checkHttpStatus)
        .thenRight(parseJson)
        .mapRight((right) {
      return UserModel.fromJson(right);
    });
  }
}
