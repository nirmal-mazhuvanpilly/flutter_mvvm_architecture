import 'dart:io';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mvvm_architecture/res/enums/enums.dart';
import '../../data/remote/network_base_services.dart';

Future<bool> isInternetAvailable() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } on SocketException catch (_) {
    return false;
  }
  return false;
}

void afterInit(Function function) {
  SchedulerBinding.instance.addPostFrameCallback((_) {
    function.call();
  });
}

LoaderState handleResponseError(ApiErrorTypes errorType) {
  switch (errorType) {
    case ApiErrorTypes.noInternet:
      return LoaderState.networkError;
    case ApiErrorTypes.internalServerError:
      return LoaderState.serverError;
    case ApiErrorTypes.cancel:
      return LoaderState.error;
    case ApiErrorTypes.connectionTimeout:
      return LoaderState.error;
    case ApiErrorTypes.sendTimeout:
      return LoaderState.error;
    case ApiErrorTypes.receiveTimeout:
      return LoaderState.error;
    case ApiErrorTypes.badCertificate:
      return LoaderState.error;
    case ApiErrorTypes.badResponse:
      return LoaderState.error;
    case ApiErrorTypes.connectionError:
      return LoaderState.error;
    case ApiErrorTypes.unknown:
      return LoaderState.error;
    case ApiErrorTypes.unAuthorized:
      return LoaderState.error;
    case ApiErrorTypes.badRequest:
      return LoaderState.error;
    case ApiErrorTypes.serviceUnavailable:
      return LoaderState.error;
    case ApiErrorTypes.notFound:
      return LoaderState.error;
    case ApiErrorTypes.jsonParsing:
      return LoaderState.error;
    case ApiErrorTypes.oops:
      return LoaderState.error;
  }
}
