import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ExceptionHandlers {
  static String getExceptionString(error) {
    try {
      if (error is SocketException) {
        return 'Socket Error, $error.';
      } else if (error is HttpException) {
        return 'HTTP error occured.';
      } else if (error is FormatException) {
        return 'FormatException, silahkan coba lagi.';
      } else if (error is TimeoutException) {
        return 'Koneksi Gagal, Server tidak dapat merespon, silahkan coba lagi. (RTO).';
      } else if (error is BadRequestException) {
        return 'Bad Request Exception.';
      } else if (error is UnAuthorizedException) {
        return 'UnAuthorized Exception.';
      } else if (error is NotFoundException) {
        return 'Not Found Exception.';
      } else if (error is FetchDataException) {
        return 'Fetch Data Exception.';
      } else {
        return 'Terjadi kesalahan,\n$error';
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return error.toString();
    }
  }
}

class AppException implements Exception {
  final String? message;
  final String? prefix;
  final String? url;

  AppException([this.message, this.prefix, this.url]);
}

class BadRequestException extends AppException {
  BadRequestException([String? message, String? url])
      : super(message, 'Bad request', url);
}

class FetchDataException extends AppException {
  FetchDataException([String? message, String? url])
      : super(message, 'Unable to process the request', url);
}

class ApiNotRespondingException extends AppException {
  ApiNotRespondingException([String? message, String? url])
      : super(message, 'Api not responding', url);
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException([String? message, String? url])
      : super(message, 'Unauthorized request', url);
}

class NotFoundException extends AppException {
  NotFoundException([String? message, String? url])
      : super(message, 'Page not found', url);
}

class ErrorHandlers {
  int code = 0;
  String message = "";

  ErrorHandlers(response) {
    if (response) {
      code = response.statusCode;
    }
    message = getErrorMessage(response);
  }

  static String getErrorMessage(response) {
    try {
      if (response) {
        switch (response.statusCode) {
          case 200:
          case 201:
          case 202:
            return "Success";
          case 400:
            return "You are not registered.";
          case 401:
            return "You are unauthenticated";
          case 404:
            return "The resource you are looking is temporarily unavailable.\nPlease try again later";
          case 405:
            return "Method not allowed";
          case 500:
            return "There is a problem with our server, it will be fixed soon.\nPlease try again later";
          default:
            return 'Unknown error.';
        }
      } else {
        return json.decode(response.body)['message'];
      }
    } catch (e) {
      return json.decode(response.body)['message'];
    }
  }
}
