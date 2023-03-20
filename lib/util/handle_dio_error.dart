import 'package:dio/dio.dart';

String handleDioError(DioError error) {
  switch (error.type) {
    case DioErrorType.cancel:
      return "Request to API server was cancelled";
    case DioErrorType.receiveTimeout:
      return "Receive timeout in connection with API server";
    case DioErrorType.sendTimeout:
      return "Send timeout in connection with API server";
    case DioErrorType.connectionError:
      return "Connection Error";
    default:
      return "Something went wrong";
  }
}
