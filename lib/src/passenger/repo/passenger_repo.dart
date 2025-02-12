import 'package:either_dart/either.dart';
import 'package:flutter_mvvm_architecture/data/remote/network_base_services.dart';
import 'package:flutter_mvvm_architecture/model/passengers/passengers_model.dart';
import 'package:flutter_mvvm_architecture/res/constants/app_constants.dart';

import 'package:get_it/get_it.dart';

abstract class PassengerRepo {
  Future<Either<ResponseError, PassengersModel?>> getPassengers(
      {int? page = 0});
}

class PassengerRepoImplements extends PassengerRepo {
  final dio = GetIt.instance<NetWorkBaseServices>();

  @override
  Future<Either<ResponseError, PassengersModel?>> getPassengers(
      {int? page = 0}) {
    return dio
        .safe(
            dio.getRequest(endPoint: "${AppConstants.passengerList}page=$page"))
        .thenRight(dio.checkHttpStatus)
        .thenRight(dio.parseJson)
        .mapRight((right) => PassengersModel.fromJson(right));
  }
}
