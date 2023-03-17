import 'package:either_dart/either.dart';
import 'package:flutter_mvvm_architecture/model/user/user.dart';
import 'package:flutter_mvvm_architecture/services/network/base_services.dart';
import 'package:flutter_mvvm_architecture/services/network/resposne_error.dart';
import 'package:get_it/get_it.dart';

class UserServices {
  final services = GetIt.instance<BaseServices>();

  Future<Either<ResponseError, UserModel?>> getDetailedResponse(){
    return services.getDetailedResponse();
  }
}
