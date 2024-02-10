class AppException implements Exception {
  final String? message;
  final String? prefix;
  AppException([this.message, this.prefix]);

  // ignore: annotate_overrides
  String toString() {
    return "$prefix$message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([
    String? message,
  ]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}

class ApiNotRespondingException extends AppException {
  ApiNotRespondingException([
    String? message,
  ]) : super(message, 'Api not responded in time');
}
