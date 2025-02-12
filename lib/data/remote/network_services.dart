import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_mvvm_architecture/data/remote/network_base_services.dart';
import 'package:flutter_mvvm_architecture/res/constants/app_constants.dart';
import 'package:flutter_mvvm_architecture/utils/helpers/common_functions.dart';

class NetworkServices extends NetWorkBaseServices {
  static const kConnectTimeOut = Duration(milliseconds: 60000);
  static const kReceiveTimeOut = Duration(milliseconds: 60000);

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.baseURL,
      receiveDataWhenStatusError: true,
      headers: {"Content-Type": "application/json"},
    ),
  );

  @override
  Either<ResponseError, BaseResponse> checkHttpStatus(BaseResponse response) {
    return getStatus(response);
  }

  @override
  Future<BaseResponse> getRequest(
      {required String endPoint, Map<String, dynamic>? parameters}) async {
    if (!(await isInternetAvailable())) {
      throw ApiExceptions.noInternet();
    }
    try {
      if (AppConstants.accessToken.isNotEmpty) {
        dio.options.headers["Authorization"] =
            "Bearer ${AppConstants.accessToken}";
      } else {
        dio.options.headers["Authorization"] = '';
      }
      log("URL : / ${dio.options.baseUrl}$endPoint");
      log('Params: $parameters');
      log("Headers : // API Key :: ${dio.options.headers["Api-key"]}");
      log("Headers : // Token :: ${dio.options.headers["Authorization"]}");
      Response response = await dio
          .get(endPoint, data: parameters)
          .timeout(kReceiveTimeOut, onTimeout: () {
        throw ApiExceptions.oops();
      });
      log("Response : /// ${response.data}");
      return BaseResponse(statusCode: response.statusCode, data: response.data);
    } on DioException catch (error) {
      log("Error : // ${error.message}");
      if (error.response?.statusCode == 401) {
        return await callRefreshToken(
            error: error, request: getRequest(endPoint: endPoint));
      }
      throw ApiExceptions(message: error.message, response: error.response);
    } catch (e) {
      log("Error : // $e");
      throw ApiExceptions.oops();
    }
  }

  @override
  Future<BaseResponse> postRequest(
      {required String endPoint, Map<String, dynamic>? parameters}) async {
    if (!(await isInternetAvailable())) {
      throw ApiExceptions.noInternet();
    }
    try {
      if (AppConstants.accessToken.isNotEmpty) {
        dio.options.headers["Authorization"] =
            "Bearer ${AppConstants.accessToken}";
      } else {
        dio.options.headers["Authorization"] = '';
      }
      log("URL : / ${dio.options.baseUrl}$endPoint");
      log("Headers : // API Key :: ${dio.options.headers["Api-key"]}");
      log("Headers : // Token :: ${dio.options.headers["Authorization"]}");
      log("POST BODY : // $parameters");
      Response response = await dio
          .post(endPoint, data: parameters)
          .timeout(kReceiveTimeOut, onTimeout: () {
        throw ApiExceptions.oops();
      });
      log("Response : /// ${response.data}");
      log("Response CODE : /// ${response.statusCode}");
      return BaseResponse(statusCode: response.statusCode, data: response.data);
    } on DioException catch (error) {
      if (error.response?.statusCode == 401) {
        return await callRefreshToken(
            error: error,
            request: postRequest(endPoint: endPoint, parameters: parameters));
      }
      return BaseResponse(
          statusCode: error.response?.statusCode, data: error.response?.data);
    } catch (e) {
      log("Exception Error : // $e");
      throw ApiExceptions.oops();
    }
  }

  @override
  Future<BaseResponse> putRequest(
      {required String endPoint, Map<String, dynamic>? parameters}) async {
    if (!(await isInternetAvailable())) {
      throw ApiExceptions.noInternet();
    }
    try {
      if (AppConstants.accessToken.isNotEmpty) {
        dio.options.headers["Authorization"] =
            "Bearer ${AppConstants.accessToken}";
      } else {
        dio.options.headers["Authorization"] = '';
      }
      log("URL : / ${dio.options.baseUrl}$endPoint");
      log("Headers : // API Key :: ${dio.options.headers["Api-key"]}");
      log("Headers : // Token :: ${dio.options.headers["Authorization"]}");
      log("POST BODY : // $parameters");
      Response response = await dio.put(endPoint, data: parameters);
      return BaseResponse(statusCode: response.statusCode, data: response.data);
    } on DioException catch (error) {
      if (error.response?.statusCode == 401) {
        return await callRefreshToken(
            error: error,
            request: putRequest(endPoint: endPoint, parameters: parameters));
      }
      return BaseResponse(
          statusCode: error.response?.statusCode, data: error.response?.data);
    } catch (e) {
      log("Exception Error : // $e");
      throw ApiExceptions.oops();
    }
  }

  @override
  Future<BaseResponse> deleteRequest(
      {required String endPoint, Map<String, dynamic>? parameters}) async {
    if (!(await isInternetAvailable())) {
      throw ApiExceptions.noInternet();
    }
    try {
      if (AppConstants.accessToken.isNotEmpty) {
        dio.options.headers["Authorization"] =
            "Bearer ${AppConstants.accessToken}";
      } else {
        dio.options.headers["Authorization"] = '';
      }
      log("URL : / ${dio.options.baseUrl}$endPoint");
      log("Headers : // API Key :: ${dio.options.headers["Api-key"]}");
      log("Headers : // Token :: ${dio.options.headers["Authorization"]}");
      log("POST BODY : // $parameters");
      Response response = await dio.delete(endPoint, data: parameters);
      return BaseResponse(statusCode: response.statusCode, data: response.data);
    } on DioException catch (error) {
      if (error.response?.statusCode == 401) {
        return await callRefreshToken(
            error: error,
            request: putRequest(endPoint: endPoint, parameters: parameters));
      }
      return BaseResponse(
          statusCode: error.response?.statusCode, data: error.response?.data);
    } catch (e) {
      log("Exception Error : // $e");
      throw ApiExceptions.oops();
    }
  }

  @override
  Future<BaseResponse> putMultipartRequest(
      {Function(int, int)? onSendProgress,
      FormData? formData,
      required String endPoint}) async {
    if (!(await isInternetAvailable())) {
      throw ApiExceptions.noInternet();
    }
    try {
      if (AppConstants.accessToken.isNotEmpty) {
        dio.options.headers["Authorization"] =
            "Bearer ${AppConstants.accessToken}";
      } else {
        dio.options.headers["Authorization"] = '';
      }
      log("URL : / ${dio.options.baseUrl}$endPoint");
      log("Headers : // API Key :: ${dio.options.headers["Api-key"]}");
      log("Headers : // Token :: ${dio.options.headers["Authorization"]}");

      Response response = await dio.put(endPoint,
          data: formData, onSendProgress: onSendProgress);
      return BaseResponse(statusCode: response.statusCode, data: response.data);
    } on DioException catch (error) {
      if (error.response?.statusCode == 401) {
        return await callRefreshToken(
            request: putMultipartRequest(
              endPoint: endPoint,
              formData: formData,
              onSendProgress: onSendProgress,
            ),
            error: error);
      }
      return BaseResponse(
          statusCode: error.response?.statusCode, data: error.response?.data);
    } catch (e) {
      log("Exception Error : // $e");
      throw ApiExceptions.oops();
    }
  }

  @override
  Either<ResponseError, BaseResponse> getStatus(BaseResponse response) {
    switch (response.statusCode) {
      case 200:
        return Right(response);
      case 400:
        return Right(response);
      case 401:
        return Left(ResponseError(
            key: ApiErrorTypes.unAuthorized,
            message: "UnAuthorized",
            response: response.data));
      case 403:
        _logout(); //TODO Logout Functionality
        return Left(ResponseError(
            key: ApiErrorTypes.unAuthorized,
            message: "Forbidden",
            response: response.data));
      case 404:
        return Left(ResponseError(
            key: ApiErrorTypes.notFound,
            message: "Not Found",
            response: response.data));
      case 422:
        return Left(ResponseError(
            key: ApiErrorTypes.unAuthorized,
            message: "UnAuthorized",
            response: response.data));
      case 500:
        return Left(ResponseError(
            key: ApiErrorTypes.internalServerError,
            message: "Internal Server Error",
            response: response.data));
      case 503:
        return Left(ResponseError(
            key: ApiErrorTypes.serviceUnavailable,
            message: "Service Unavailable",
            response: response.data));
      default:
        return Left(ResponseError(
            key: ApiErrorTypes.unknown,
            message: "Unknown",
            response: response.data));
    }
  }

  @override
  Future<Either<ResponseError, dynamic>> parseJson(
      BaseResponse response) async {
    try {
      return Right(response.data);
    } catch (e) {
      return const Left(ResponseError(
          key: ApiErrorTypes.jsonParsing, message: "Failed on json Parsing"));
    }
  }

  @override
  Future<Either<ResponseError, BaseResponse>> safe(
      Future<BaseResponse> request) async {
    try {
      return Right(await request);
    } on ApiExceptions catch (error) {
      return Left(ResponseError(
          key: error.errorType,
          message: error.message,
          response: error.response));
    } catch (e) {
      return Left(ResponseError(
          key: ApiErrorTypes.unknown, message: "Unknown Error : $e"));
    }
  }

  Future<BaseResponse> callRefreshToken(
      {required DioException error,
      required Future<BaseResponse> request}) async {
    AppConstants.accessToken = "";
    return await safe(postRequest(
        endPoint: AppConstants.refreshTokenApi,
        parameters: {"refresh": AppConstants.refreshToken})).fold(
      (left) async {
        return BaseResponse(
            statusCode: error.response?.statusCode, data: error.response?.data);
      },
      (right) async {
        //TODO Handle Refresh Tokens
        return await request;
      },
    ).catchError((error) {
      return BaseResponse(
          statusCode: error.response?.statusCode, data: error.response?.data);
    });
  }

  _logout() async {}
}
