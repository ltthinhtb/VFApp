import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as get_x;
import 'package:vf_app/configs/app_configs.dart';
import 'package:vf_app/generated/l10n.dart';
import 'package:vf_app/model/entities/index.dart';
import 'package:vf_app/model/params/check_account_request.dart';
import 'package:vf_app/model/params/index.dart';
import 'package:vf_app/model/response/account_status.dart';
import 'package:vf_app/model/response/check_account_response.dart';
import 'package:vf_app/model/response/list_account_response.dart';
import 'package:vf_app/model/response/portfolio.dart';
import 'package:vf_app/model/response/portfolio_account_status.dart';
import 'package:vf_app/model/stock_company_data/stock_company_data.dart';
import 'package:vf_app/model/stock_data/stock_data.dart';
import 'package:vf_app/router/route_config.dart';
import 'error_exception.dart';

abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  Future<TokenEntity> authLogin(RequestParams requestParams);

  //sign up
  Future<CheckAccountResponse> checkAccountStatus(CheckAccountRequest request);

  //Asset
  Future<AccountStatus> getAccountStatus(RequestParams requestParams);

  Future<PortfolioAccountStatus> getPortfolioAccountStatus(
      RequestParams requestParams);

  Future<ListAccountResponse> getListAccount(RequestParams requestParams);

  Future<Portfolio> getPortfolio(RequestParams requestParams);

  //Stock Data
  Future<List<StockCompanyData>> getAllStockCompanyData();

  Future<StockData> getStockData(String stockCode);

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
      var response = await request;
      var _mapData = _decodeMap(response.data!);
      var _rc = _mapData['rc'] ?? -999;

      /// kiểm tra điều kiện thành công
      if (_rc == 1) {
        return response;
      }

      ///kiểm tra điều kiện logOut
      else if (_rc == -1) {
        await get_x.Get.offNamed(RouteConfig.login);
        throw ErrorException(response.statusCode!, _mapData['rs']);
      } else {
        throw ErrorException(response.statusCode!, _mapData['rs']);
      }
    } catch (error) {
      throw _handleError(error);
    }
  }

  Future<Response> _getApi(Future<Response> request) async {
    try {
      var response = await request;
      return response;
    } catch (error) {
      throw _handleError(error);
    }
  }

  ErrorException _handleError(dynamic error) {
    /// xử lý exception
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
    } else if (error is ErrorException) {
      return error;
    } else {
      exception.message = S.current.error;
    }
    return exception;
  }

  Map<String, dynamic> _decodeMap(String value) {
    Map<String, dynamic> valueMap = json.decode(value);
    return valueMap;
  }

  // List<dynamic> _decodeList(String _value) {
  //   List<dynamic> list = json.decode(_value);
  //   return list;
  // }

  @override
  Future<TokenEntity> authLogin(RequestParams requestParams) async {
    Response _result = await _requestApi(
        _dio.post(AppConfigs.ENDPOINT_CORE, data: requestParams.toJson()));
    var _mapData = _decodeMap(_result.data!);
    final value = TokenEntity.fromJson(_mapData);
    return value;
  }

  @override
  Future<CheckAccountResponse> checkAccountStatus(
      CheckAccountRequest request) async {
    Response _result = await _getApi(
        _dio.post(AppConfigs.VF_HOST + 'core', data: request.toJson()));
    var _mapData = _result.data!;
    var _rc = _mapData['iRs'] ?? -999;
    if (_rc == 1) {
      final value = CheckAccountResponse.fromJson(_mapData);
      return value;
    } else {
      throw ErrorException(_mapData['sRs'], _mapData['rs']);
    }
  }

  @override
  Future signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<AccountStatus> getAccountStatus(RequestParams requestParams) async {
    Response _result = await _requestApi(
        _dio.post(AppConfigs.ENDPOINT_CORE, data: requestParams.toJson()));
    var _mapData = _decodeMap(_result.data!);
    final value = AccountStatus.fromJson(_mapData);
    return value;
  }

  @override
  Future<ListAccountResponse> getListAccount(
      RequestParams requestParams) async {
    Response _result = await _requestApi(
        _dio.post(AppConfigs.ENDPOINT_CORE, data: requestParams.toJson()));
    var _mapData = _decodeMap(_result.data!);
    final value = ListAccountResponse.fromJson(_mapData);
    return value;
  }

  @override
  Future<Portfolio> getPortfolio(RequestParams requestParams) async {
    Response _result = await _requestApi(
        _dio.post(AppConfigs.ENDPOINT_CORE, data: requestParams.toJson()));
    var _mapData = _decodeMap(_result.data!);
    final value = Portfolio.fromJson(_mapData);
    return value;
  }

  @override
  Future<List<StockCompanyData>> getAllStockCompanyData() async {
    try {
      Response _result =
          await _getApi(_dio.get(AppConfigs.URL_DATA_FEED + "getlistallstock"));
      final value = _result.data
          .map<StockCompanyData>((e) => StockCompanyData.fromJson(e))
          .toList();
      return value;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<StockData> getStockData(String stockCode) async {
    try {
      Response _result = await _getApi(
          _dio.get(AppConfigs.URL_DATA_FEED + "getliststockdata/$stockCode"));
      final value = StockData.fromJson(_result.data[0]);
      return value;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PortfolioAccountStatus> getPortfolioAccountStatus(
      RequestParams requestParams) async {
    Response _result = await _requestApi(
        _dio.post(AppConfigs.ENDPOINT_CORE, data: requestParams.toJson()));
    var _mapData = _decodeMap(_result.data!);
    final value = PortfolioAccountStatus.fromJson(_mapData);
    return value;
  }
}
