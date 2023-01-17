class NetworkResponse {
  dynamic response;
  ErrorResponse? error;

  NetworkResponse({this.response, this.error});

  bool hasError() => error != null;
}

class ErrorResponse {
  String message;
  dynamic data;

  ErrorResponse({required this.message, this.data});
}