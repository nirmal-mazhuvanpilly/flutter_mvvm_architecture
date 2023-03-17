import 'dart:convert';
import 'dart:io';
import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_mvvm_architecture/res/app_config.dart';
import 'package:flutter_mvvm_architecture/services/network/resposne_error.dart';
import 'package:http/http.dart' as http;

Future<Either<ResponseError, http.Response>> safe(
    Future<http.Response> request) async {
  try {
    return Right(await request);
  } catch (e) {
    return Left(ResponseError(
        key: Error.badRequest, message: "Request executing with errors:$e"));
  }
}

Either<ResponseError, http.Response> checkHttpStatus(http.Response response) {
  switch (response.statusCode) {
    case 200:
      return Right(response);

    case 500:
      return Left(ResponseError(
          key: Error.serverError,
          message: "Bad status ${response.statusCode}"));

    default:
      return Left(ResponseError(
          key: Error.badResponse,
          message: "Bad status ${response.statusCode}"));
  }
}

Future<Either<ResponseError, dynamic>> parseJson(http.Response response) async {
  try {
    return Right(json.decode(response.body));
  } catch (e) {
    return const Left(ResponseError(
        key: Error.jsonParsing, message: "Failed on json parsing"));
  }
}

Future<http.Response> getRequest({required String endPoint}) async {
  dynamic response;
  try {
    final url = Uri.parse(AppConstants.baseUrl + endPoint);
    Map<String, String> parameters = <String, String>{
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
    };
    response = await http
        .get(url, headers: parameters)
        .timeout(const Duration(seconds: 30));
  } on Exception catch (error) {
    debugPrint(error.toString());
    if (error.toString().contains('SocketException')) {
      debugPrint("Error occurred while communicating with Server!");
    }
  }
  return response;
}
