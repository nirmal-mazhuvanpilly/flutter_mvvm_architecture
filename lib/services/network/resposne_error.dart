enum Error {
  notFound,
  badRequest,
  serverError,
  badResponse,
  jsonParsing,
}

class ResponseError {
  final Error key;
  final String? message;

  const ResponseError({
    required this.key,
    this.message,
  });
}