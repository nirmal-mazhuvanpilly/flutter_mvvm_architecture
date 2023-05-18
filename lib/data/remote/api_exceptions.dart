import 'package:flutter_mvvm_architecture/data/remote/resposne_error.dart';

class ApiExceptions implements Exception {
  final String? message;
  final ApiErrorTypes errorType;

  ApiExceptions(
      {this.message = "Unknown", this.errorType = ApiErrorTypes.unknown});

  factory ApiExceptions.noInternet() => ApiExceptions(
      message: "No Internet", errorType: ApiErrorTypes.noInternet);

  factory ApiExceptions.oops() =>
      ApiExceptions(message: "Oops", errorType: ApiErrorTypes.oops);
}
