// ignore_for_file: prefer_typing_uninitialized_variables, avoid_dynamic_calls

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fifthlab_assessment/ui/ui_helpers/helpers.dart';
import 'package:http/http.dart' as http;
import 'package:validators/sanitizers.dart';

class ApiClient {
  late http.Client client;
  bool showError = false;

  ApiClient({
    http.Client? client,
    this.showError = true,
  }) : client = client ?? http.Client();

  Future<dynamic> get(String url, {Map<String, dynamic>? queries}) async {
    if (queries != null) {
      url += queries.keys.fold(
        '?',
        (previousValue, key) => '$previousValue$key=${queries[key]}&',
      );
      url = trim(url, '&');
    }

    var responseJson;
    try {
      final response = await client.get(
        Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
        },
      ).timeout(const Duration(seconds: 30));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw TimeoutException("Connection Timed Out");
    }

    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    try {
      return _getResponse(response);
    } on AppException catch (e) {
      Helpers.logc("code::${response.statusCode}");
      Helpers.logc(">>>>> error is $e");
      rethrow;
    }
  }

  dynamic _getResponse(http.Response response) {
    int code = response.statusCode;
    if (response.body.startsWith('{"status":"error"')) {
      // handle v1 fake 200 errors
      if (response.statusCode != 401) code = 400;
    }

    try {
      switch (code) {
        case 400:
          throw BadRequestException(processError(response));
        case 401:
          // if (locator.get<Application>().user.apiToken == null) return;
          throw InvalidTokenException(processError(response));
        case 402:
          throw GeneralErrorException(processError(response));
        case 403:
          throw UnauthorisedException(json.decode(processError(response)));
        case 404:
          throw GeneralErrorException(processError(response));
        case 405:
          throw GeneralErrorException(processError(response));
        case 406:
          throw GeneralErrorException(processError(response));
        case 408:
          throw GeneralErrorException(processError(response));
        case 409:
          throw GeneralErrorException(processError(response));
        case 410:
          throw GeneralErrorException(processError(response));
        case 421:
          throw GeneralErrorException(processError(response));
        case 422:
          throw BadRequestException(processError(response));
        case 423:
          throw GeneralErrorException(processError(response));
        case 424:
          throw GeneralErrorException(processError(response));
        case 425:
          throw GeneralErrorException(processError(response));
        case 426:
          throw GeneralErrorException(processError(response));
        case 429:
          throw GeneralErrorException(processError(response));

        // 500 CASES
        case 500:
          throw ServerErrorException(processError(response));
        case 501:
          throw GeneralErrorException(processError(response));
        case 502:
          throw GeneralErrorException(processError(response));
        case 503:
          throw GeneralErrorException(processError(response));
        case 504:
          throw GeneralErrorException(processError(response));
        case 505:
          throw GeneralErrorException(processError(response));
        case 506:
          throw GeneralErrorException(processError(response));
        case 507:
          throw GeneralErrorException(processError(response));
        case 508:
          throw GeneralErrorException(processError(response));
        case 509:
          throw GeneralErrorException(processError(response));
        case 510:
          throw GeneralErrorException(processError(response));
        case 511:
          throw GeneralErrorException(processError(response));

        default:
          if (!isResponseOk(response.statusCode)) {
            throw FetchDataException(
              '\n StatusCode : ${response.statusCode}.'
              '\n Response: ${response.body}',
            );
          }
          final responseJson = json.decode(response.body);
          return responseJson;
      }
    } catch (e) {
      throw BadRequestException(processError(response));
    }
  }

  bool isResponseOk(int statusCode) {
    return statusCode >= 200 && statusCode <= 299;
  }

  dynamic processError(http.Response response) {
    return json.decode(response.body);
  }
}

class AppException implements Exception {
  AppException([this.message, this._prefix]);
  final dynamic message;
  // ignore: unused_field, use_late_for_private_fields_and_variables
  final _prefix;
  @override
  String toString() {
    return "$message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String message = ""])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidTokenException extends AppException {
  InvalidTokenException([message]) : super(message, "Invalid Token: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([String message = ""])
      : super(message, "Invalid Input: ");
}

class ServerErrorException extends AppException {
  ServerErrorException([
    String message =
        "Oh no! We encountered an error and our technical staff have been automatically notified and will be looking into this with the utmost urgency.",
  ]) : super(message, "Notice");
}

class GeneralErrorException extends AppException {
  GeneralErrorException([
    String message =
        "Oh no! We encountered an error and our technical staff have been automatically notified and will be looking into this with the utmost urgency.",
  ]) : super(message, "Notice");
}
