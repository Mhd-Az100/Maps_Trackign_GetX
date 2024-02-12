class AppException implements Exception {
  final String? message;
  final String? prefix;

  AppException([this.message, this.prefix]);

  // Override the toString method to format the exception message
  @override
  String toString() {
    return "$prefix$message";
  }
}

class FetchDataException extends AppException {
  // Exception for errors during communication
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class UnauthorisedException extends AppException {
  // Exception for unauthorized access
  UnauthorisedException([String? message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends AppException {
  // Exception for invalid input
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}

class ApiNotRespondingException extends AppException {
  // Exception for API not responding in time
  ApiNotRespondingException([String? message])
      : super(message, 'Api not responded in time');
}
