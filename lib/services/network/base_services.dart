import 'package:either_dart/either.dart';
import 'package:flutter_mvvm_architecture/model/user/user.dart';
import 'package:flutter_mvvm_architecture/services/network/resposne_error.dart';

 abstract class BaseServices {
   Future<Either<ResponseError, UserModel?>> getDetailedResponse();
}
