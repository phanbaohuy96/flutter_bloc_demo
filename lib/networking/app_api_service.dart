import 'package:dio/dio.dart';
import 'package:flutter_bloc_demo/networking/remote_contract.dart';
import 'package:flutter_bloc_demo/networking/rest_client.dart';
import 'package:flutter_bloc_demo/utils/utils.dart';

class AppApiService {
  final _dio = Dio();
  ApiServiceHandler handlerEror;
  RestClient client;

  void create() {
    client = RestClient(_dio, baseUrl: RemoteContract.baseLayerUrl);

    addDioHeader();

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options) {
          log('''[AppApiService][${DateTime.now().toString().split(' ').last}]-> DioSTART\tonRequest \t${options.method} [${options.path}] ${options.contentType}''');

          return options; //continue
        },
        onResponse: (Response response) {
          log('''[AppApiService][${DateTime.now().toString().split(' ').last}]-> DioEND\tonResponse \t${response.statusCode} [${response.request.path}] ${response.request.method}  ${response.request.responseType}''');

          return response; // continue
        },
        onError: (DioError error) async {
          log('''[AppApiService][${DateTime.now().toString().split(' ').last}]-> DioEND\tonError \turl:[${error.request.baseUrl}] type:${error.type} message: ${error.message}''');

          handlError(error);
        },
      ),
    );
  }

  void addDioHeader({Map<String, String> headers}) {
    _dio.options.headers.clear();
    _dio.options.headers['''Content-Type'''] = '''application/json''';
    headers?.forEach((k, v) {
      _dio.options.headers[k] = v;
    });
  }

  dynamic handlError(DioError error) {
    if (handlerEror == null) {
      return null;
    }

    final result = ErrorData(type: ErrorType.UNKNOWN, message: error.message);

    switch (error.type) {
      case DioErrorType.RECEIVE_TIMEOUT:
      case DioErrorType.SEND_TIMEOUT:
      case DioErrorType.CONNECT_TIMEOUT:
        result.type = ErrorType.TIMED_OUT;
        break;
      case DioErrorType.RESPONSE:
        {
          log('''[AppApiService] _handleError DioErrorType.RESPONSE status code: ${error.response.statusCode}''');
          result.statusCode = error.response.statusCode;

          if (result.statusCode == 401) {
            result.type = ErrorType.UNAUTHORIZED;
          }
          if (result.statusCode == 403) {
            //refresh token
          } else if (result.statusCode >= 500 && result.statusCode < 600) {
            result.type = ErrorType.HTTP_EXCEPTION;
          } else {
            result.type = ErrorType.HTTP_EXCEPTION;
            // result.message = getErrorMessage(error.response.data);
          }
          break;
        }
      case DioErrorType.CANCEL:
        break;
      case DioErrorType.DEFAULT:
        log('''[AppApiService] _handleError DioErrorType.DEFAULT status code: error.response is null -> Server die or No Internet connection''');
        result.type = ErrorType.NO_INTERNET;

        if (error.message.contains('Unexpected character')) {
          result.type = ErrorType.SERVER_Unexpected_character;
        }
        break;
    }

    return handlerEror.onError(result); //continue
  }

  String getErrorMessage(Map<String, dynamic> dataRes) {
    if (dataRes.containsKey('message') && dataRes['message'] != null) {
      return dataRes['message']?.toString();
    }
    if (dataRes.containsKey('error') && dataRes['error'] != null) {
      return dataRes['error']?.toString();
    }
    return dataRes.toString();
  }
}

enum ErrorType {
  //ignore: constant_identifier_names
  NO_INTERNET,
  //ignore: constant_identifier_names
  HTTP_EXCEPTION,
  //ignore: constant_identifier_names
  TIMED_OUT,
  //ignore: constant_identifier_names
  UNAUTHORIZED,
  //ignore: constant_identifier_names
  UNKNOWN,
  //ignore: constant_identifier_names
  SERVER_Unexpected_character
}

class ErrorData {
  ErrorType type;
  String message;
  int statusCode;

  ErrorData({this.type, this.statusCode, this.message});
}

mixin ApiServiceHandler {
  void onError(ErrorData onError);
}
