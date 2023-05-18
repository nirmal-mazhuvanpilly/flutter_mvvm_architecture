import 'package:either_dart/either.dart';
import 'package:flutter_mvvm_architecture/data/remote/resposne_error.dart';
import 'package:http/http.dart' as http;

Either<ResponseError, http.Response> getStatus(http.Response response) {
  switch (response.statusCode) {
    case 200:
      return Right(response);
    case 400:
      return const Left(
          ResponseError(key: ApiErrorTypes.badRequest, message: "Bad Request"));
    case 401:
      return const Left(ResponseError(
          key: ApiErrorTypes.unAuthorized, message: "UnAuthorized"));
    case 403:
      return const Left(ResponseError(
          key: ApiErrorTypes.unAuthorized, message: "UnAuthorized"));
    case 404:
      return const Left(
          ResponseError(key: ApiErrorTypes.notFound, message: "Not Found"));
    case 500:
      return const Left(ResponseError(
          key: ApiErrorTypes.internalServerError,
          message: "Internal Server Error"));
    case 503:
      return const Left(ResponseError(
          key: ApiErrorTypes.serviceUnavailable,
          message: "Service Unavailable"));
    default:
      return const Left(
          ResponseError(key: ApiErrorTypes.unknown, message: "Unknown"));
  }
}
