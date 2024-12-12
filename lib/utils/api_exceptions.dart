class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() => 'ApiException($statusCode): $message';
}

class UnauthorizedException extends ApiException {
  UnauthorizedException(super.message) : super(statusCode: 401);
}

class ServerException extends ApiException {
  ServerException(super.message, {int super.statusCode = 500});
}

class BadRequestException extends ApiException {
  BadRequestException(super.message, {int super.statusCode = 400});
}