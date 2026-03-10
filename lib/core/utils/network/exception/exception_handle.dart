import 'dart:io';

import 'package:dio/dio.dart';

import 'error_status.dart';

class ExceptionHandle {
  static String globalError = "Some Thing Wrong Happened...";

  static NetError handleException(dynamic error) {
    if (error is DioException) {
      if (error.type == DioExceptionType.unknown ||
          error.type == DioExceptionType.badResponse) {
        dynamic e = error.error;

        if (e is SocketException) {
          return NetError(ErrorStatus.sOCKETERROR, e.message);
        }

        if (e is HttpException) {
          return NetError(ErrorStatus.sERVERERROR, e.message);
        }

        return NetError(ErrorStatus.nETWORKERROR, error.message ?? "Network Error: ${error.type}");
      } else if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        return NetError(ErrorStatus.tIMEOUTERROR, "Connection Timeout: ${error.type}");
      } else if (error.type == DioExceptionType.cancel) {
        return NetError(ErrorStatus.cACCELERATOR, "");
      } else {
        return NetError(ErrorStatus.uNKNOWNERROR, error.message ?? "Unknown Error: ${error.type}");
      }
    } else {
      return NetError(ErrorStatus.uNKNOWNERROR, error.toString());
    }
  }
}

class NetError {
  int code;
  String msg;

  NetError(this.code, this.msg);
}
