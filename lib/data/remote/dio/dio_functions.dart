import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_mvvm_architecture/data/remote/api_exceptions.dart';
import 'package:flutter_mvvm_architecture/data/remote/resposne_error.dart';

Either<ResponseError, Response> getStatus(Response response) {
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

ApiExceptions getException(DioError error) {
  switch (error.type) {
    case DioErrorType.connectionTimeout:
      throw ApiExceptions(
          message: error.message, errorType: ApiErrorTypes.connectionTimeout);
    case DioErrorType.sendTimeout:
      throw ApiExceptions(
          message: error.message, errorType: ApiErrorTypes.sendTimeout);
    case DioErrorType.receiveTimeout:
      throw ApiExceptions(
          message: error.message, errorType: ApiErrorTypes.receiveTimeout);
    case DioErrorType.badCertificate:
      throw ApiExceptions(
          message: error.message, errorType: ApiErrorTypes.badCertificate);
    case DioErrorType.badResponse:
      throw ApiExceptions(
          message: error.message, errorType: ApiErrorTypes.badResponse);
    case DioErrorType.cancel:
      throw ApiExceptions(
          message: error.message, errorType: ApiErrorTypes.cancel);
    case DioErrorType.connectionError:
      throw ApiExceptions(
          message: error.message, errorType: ApiErrorTypes.connectionError);
    case DioErrorType.unknown:
      throw ApiExceptions(
          message: error.message, errorType: ApiErrorTypes.unknown);
  }
}
