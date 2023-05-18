enum ApiErrorTypes {
  connectionTimeout,
  sendTimeout,
  receiveTimeout,
  badCertificate,
  badResponse,
  cancel,
  connectionError,
  unknown,
  unAuthorized,
  badRequest,
  internalServerError,
  serviceUnavailable,
  notFound,
  jsonParsing,
  noInternet,
  oops,
}

class ResponseError {
  final ApiErrorTypes key;
  final String? message;

  const ResponseError({
    required this.key,
    this.message,
  });
}
