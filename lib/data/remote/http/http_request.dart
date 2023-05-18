import 'dart:convert';
import 'dart:io';
import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_mvvm_architecture/data/remote/api_exceptions.dart';
import 'package:flutter_mvvm_architecture/data/remote/http/http_functions.dart';
import 'package:flutter_mvvm_architecture/data/remote/resposne_error.dart';
import 'package:flutter_mvvm_architecture/res/app_config.dart';
import 'package:flutter_mvvm_architecture/utils/helpers/common_functions.dart';
import 'package:http/http.dart' as http;

Future<Either<ResponseError, http.Response>> safe(
    Future<http.Response> request) async {
  try {
    return Right(await request);
  } on ApiExceptions catch (error) {
    return Left(ResponseError(key: error.errorType, message: error.message));
  } catch (e) {
    return Left(ResponseError(
        key: ApiErrorTypes.unknown, message: "Unknown Error : $e"));
  }
}

Either<ResponseError, http.Response> checkHttpStatus(http.Response response) {
  return getStatus(response);
}

Future<Either<ResponseError, dynamic>> parseJson(http.Response response) async {
  try {
    return Right(json.decode(response.body));
  } catch (e) {
    return const Left(ResponseError(
        key: ApiErrorTypes.jsonParsing, message: "Failed on json parsing"));
  }
}

Future<http.Response> getRequest({required String endPoint}) async {
  if (!(await isInternetAvailable())) {
    throw ApiExceptions.noInternet();
  }
  dynamic response;
  try {
    final url = Uri.parse(AppConstants.baseUrl + endPoint);
    Map<String, String> parameters = <String, String>{
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
    };
    response = await http
        .get(url, headers: parameters)
        .timeout(const Duration(seconds: 30), onTimeout: () {
      throw ApiExceptions.oops();
    });
  } on Exception catch (error) {
    debugPrint(error.toString());
    if (error.toString().contains('SocketException')) {
      debugPrint("Error occurred while communicating with Server!");
    }
  }
  return response;
}
