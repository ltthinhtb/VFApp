import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:vf_app/configs/app_configs.dart';
import 'package:vf_app/generated/l10n.dart';
import 'package:vf_app/model/entities/index.dart';
import 'package:vf_app/model/params/index.dart';

import 'package:vf_app/utils/logger.dart';

import 'error_exception.dart';

abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  Future<TokenEntity> authLogin(RequestParams requestParams);

  Future<dynamic> signOut();
}

class _ApiClient implements ApiClient {
  _ApiClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://vftrade.vn:8888/';
  }

  final Dio _dio;

  String? baseUrl;

  Future<Response> _requestApi(Future<Response> request) async {
    try {
      return await request;
    } catch (error) {
      logger.e("Exception occured: ${error.toString()}");
      throw _handleError(error);
    }
  }

  ErrorException _handleError(dynamic error) {
    ErrorException exception = ErrorException(500, "");
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.sendTimeout:
          return exception..message = error.message;
        case DioErrorType.cancel:
          return exception..message = error.message;
        case DioErrorType.connectTimeout:
          return exception..message = error.message;
        case DioErrorType.other:
          return exception..message = S.current.network_error;
        case DioErrorType.receiveTimeout:
          return exception..message = error.message;
        case DioErrorType.response:
          exception.statusCode = error.response!.statusCode ?? 500;
          exception.message = error.response!.data;
          break;
        default:
          exception.message = error.response!.data;
      }
    } else {
      exception.message = S.current.error;
    }
    return exception;
  }

  Map<String, dynamic> _decodeMap(String value) {
    Map<String, dynamic> valueMap = json.decode(value);
    return valueMap;
  }

  @override
  Future<TokenEntity> authLogin(RequestParams requestParams) async {
    Response _result = await _requestApi(
        _dio.post(AppConfigs.ENDPOINT_CORE, data: requestParams.toJson()));
    var _mapData = _decodeMap(_result.data!);
    var _rc = _mapData['rc'] ?? -1;
    if (_rc == 1) {
      final value = TokenEntity.fromJson(_mapData);
      return value;
    } else {
      throw ErrorException(_result.statusCode!, _mapData['rs']);
    }
  }

  @override
  Future signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
