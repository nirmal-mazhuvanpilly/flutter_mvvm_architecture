import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_mvvm_architecture/data/remote/api_exceptions.dart';
import 'package:flutter_mvvm_architecture/data/remote/resposne_error.dart';
import 'package:flutter_mvvm_architecture/res/app_config.dart';
import 'package:flutter_mvvm_architecture/utils/helpers/common_functions.dart';
import 'dio_functions.dart';

const kConnectTimeOut = Duration(milliseconds: 5000);
const kReceiveTimeOut = Duration(milliseconds: 3000);

final Dio dio = Dio(
  BaseOptions(
    baseUrl: AppConstants.baseUrl,
    connectTimeout: kConnectTimeOut,
    receiveTimeout: kReceiveTimeOut,
  ),
);

Future<Either<ResponseError, Response>> safe(Future<Response> request) async {
  try {
    return Right(await request);
  } on ApiExceptions catch (error) {
    return Left(ResponseError(key: error.errorType, message: error.message));
  } catch (e) {
    return Left(ResponseError(
        key: ApiErrorTypes.unknown, message: "Unknown Error : $e"));
  }
}

Either<ResponseError, Response> checkHttpStatus(Response response) {
  return getStatus(response);
}

Future<Either<ResponseError, dynamic>> parseJson(Response response) async {
  try {
    return Right(response.data);
  } catch (e) {
    return const Left(ResponseError(
        key: ApiErrorTypes.jsonParsing, message: "Failed on json Parsing"));
  }
}

Future<Response> getRequest({required String endPoint}) async {
  if (!(await isInternetAvailable())) {
    throw ApiExceptions.noInternet();
  }
  try {
    Response response =
        await dio.get(endPoint).timeout(kReceiveTimeOut, onTimeout: () {
      throw ApiExceptions.oops();
    });
    return response;
  } on DioError catch (error) {
    throw getException(error);
  } catch (e) {
    throw ApiExceptions.oops();
  }
}
