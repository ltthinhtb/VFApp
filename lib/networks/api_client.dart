import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as get_x;
import 'package:vf_app/configs/app_configs.dart';
import 'package:vf_app/generated/l10n.dart';
import 'package:vf_app/model/entities/index.dart';
import 'package:vf_app/model/params/check_account_request.dart';
import 'package:vf_app/model/order_data/inday_order.dart';
import 'package:vf_app/model/params/index.dart';
import 'package:vf_app/model/params/open_account_param.dart';
import 'package:vf_app/model/response/Image_orc_check.dart';
import 'package:vf_app/model/response/account_status.dart';
import 'package:vf_app/model/response/check_account_response.dart';
import 'package:vf_app/model/response/face_check_response.dart';
import 'package:vf_app/model/response/index_detail.dart';
import 'package:vf_app/model/response/list_account_response.dart';
import 'package:vf_app/model/response/open_account_response.dart';
import 'package:vf_app/model/response/portfolio.dart';
import 'package:vf_app/model/response/portfolio_account_status.dart';
import 'package:vf_app/model/stock_company_data/stock_company_data.dart';
import 'package:vf_app/model/stock_data/cash_balance.dart';
import 'package:vf_app/model/stock_data/stock_data.dart';
import 'package:vf_app/model/stock_data/stock_info.dart';
import 'package:vf_app/router/route_config.dart';
import 'package:vf_app/utils/error_message.dart';
import 'package:vf_app/utils/logger.dart';
import 'error_exception.dart';

abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  Future<TokenEntity> authLogin(RequestParams requestParams);

  //sign up
  Future<CheckAccountResponse> checkAccountStatus(CheckAccountRequest request);

  Future<String> uploadFile(File file, String key);

  Future<String> uploadSignature(Uint8List file);

  Future<ImageOrcCheck> checkOcr(String url);

  Future<FaceFPTCheck> checkFaceID(String faceUrl, String cmndUrl);

  Future<OpenAccountResponse> openAccount(OpenAccountRequest request);

  //Asset
  Future<AccountStatus> getAccountStatus(RequestParams requestParams);

  Future<AccountMStatus> getAccountMStatus(RequestParams requestParams);

  Future<PortfolioAccountStatus> getPortfolioAccountStatus(
      RequestParams requestParams);

  Future<List<Account>?> getListAccount(RequestParams requestParams);

  Future<Portfolio> getPortfolio(RequestParams requestParams);

  //Stock Data
  Future<List<StockCompanyData>> getAllStockCompanyData();

  Future<StockInfo> getStockInfo(RequestParams requestParams);

  Future<List<StockData>> getStockData(String stockCode);

  Future<CashBalance> getCashBalance(RequestParams requestParams);

  Future<void> newOrderRequest(RequestParams requestParams);

  Future<void> cancleOrder(RequestParams requestParams);

  Future<List<IndayOrder>> getIndayOrder(RequestParams requestParams);

  //home
  Future<List<IndexDetail>> getListIndexDetail(String listIndex);

  Future<String> getListStockCode(String market);

  Future<dynamic> signOut();

  Future<void> changePassword(RequestParams requestParams);
}

class _ApiClient implements ApiClient {
  _ApiClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://vftrade.vn/';
  }

  final Dio _dio;

  String? baseUrl;

  Future<Response> _requestApi(Future<Response> request) async {
    try {
      var response = await request;

      var _mapData = _decodeMap(response.data!);

      var _rc = _mapData['rc'] ?? -999;
      var _rs = _mapData['rs'] ?? "FOException.InvalidSessionException";

      /// kiểm tra điều kiện thành công
      if (_rc == 1) {
        return response;
      }

      ///kiểm tra điều kiện logOut
      else if (_rc == -1 && _rs == "FOException.InvalidSessionException") {
        await get_x.Get.offNamed(RouteConfig.login);
        throw ErrorException(response.statusCode!, _mapData['rs']);
      } else {
        throw ErrorException(response.statusCode!, _mapData['rs']);
      }
    } catch (error) {
      logger.e(error.toString());
      throw _handleError(error);
    }
  }

  Future<Response> _requestVFApi(Future<Response> request) async {
    try {
      var response = await request;
      var _mapData = response.data!;
      var _rc = _mapData['iRs'] ?? -999;

      /// kiểm tra điều kiện thành công
      if (_rc == 1) {
        return response;
      } else {
        throw ErrorException(response.statusCode!, _mapData['sRs']);
      }
    } catch (error) {
      logger.e(error.toString());
      throw _handleError(error);
    }
  }

  Future<Response> _requestOrderApi(Future<Response> request) async {
    try {
      var response = await request;

      var _mapData = response.data!;

      var _rc = _mapData['rc'] ?? -999;
      var _rs = _mapData['rs'] ?? "FOException.InvalidSessionException";

      /// kiểm tra điều kiện thành công
      if (_rc == 1) {
        return response;
      }

      ///kiểm tra điều kiện logOut
      else if (_rc == -1 && _rs == "FOException.InvalidSessionException") {
        await get_x.Get.offNamed(RouteConfig.login);
        throw ErrorException(response.statusCode!, _mapData['rs']);
      } else {
        // print("_handleOrderError(_rc) ${_handleOrderError(_rc)}");
        throw _handleOrderError(_rc);
      }
    } catch (error) {
      // print("error $error");
      // throw _handleError(error);
      rethrow;
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

  String _handleOrderError(int error) {
    /// xử lý exception
    String exception = MessageOrder.mapError(error.toString());
    return exception;
  }

  Map<String, dynamic> _decodeMap(dynamic value) {
    if (value.runtimeType == String) {
      Map<String, dynamic> valueMap = json.decode(value);
      return valueMap;
    } else {
      return value;
    }
  }

  @override
  Future<TokenEntity> authLogin(RequestParams requestParams) async {
    Response _result = await _requestApi(
      _dio.post(
        AppConfigs.ENDPOINT_CORE,
        data: requestParams.toJson(),
      ),
    );
    var _mapData = _decodeMap(_result.data!);
    // var _result = await http.post(
    //   Uri.parse(baseUrl! + AppConfigs.ENDPOINT_CORE),
    //   body: requestParams.toJson(),
    // );
    // var res = jsonDecode(const Utf8Codec().decode(_result.bodyBytes));
    final value = TokenEntity.fromJson(_mapData);
    return value;
  }

  @override
  Future<CheckAccountResponse> checkAccountStatus(
      CheckAccountRequest request) async {
    Response _result = await _requestVFApi(
        _dio.post(AppConfigs.VF_HOST + 'core', data: request.toJson()));
    var _mapData = _result.data!;
    final value = CheckAccountResponse.fromJson(_mapData);
    return value;
  }

  @override
  Future<String> uploadFile(File file, String key) async {
    var formData = FormData.fromMap(
        {key: await MultipartFile.fromFile(file.path, filename: '$key.jpg')});
    Response _result = await _requestVFApi(
        _dio.post(AppConfigs.VF_HOST + 'uploadFile', data: formData));
    return _result.data['data'][key];
  }

  @override
  Future<String> uploadSignature(Uint8List file) async {
    List<int> bytes = List.from(file);
    var formData = FormData.fromMap(
        {'chuKy': MultipartFile.fromBytes(bytes, filename: 'chuKy.jpg')});
    Response _result = await _requestVFApi(
        _dio.post(AppConfigs.VF_HOST + 'uploadFile', data: formData));
    return _result.data['data']['chuKy'];
  }

  @override
  Future<ImageOrcCheck> checkOcr(String url) async {
    Response _result = await _requestVFApi(
        _dio.post(AppConfigs.VF_HOST + 'ocrPlatform', data: {"image": url}));
    var _mapData = _result.data!;
    final value = ImageOrcCheck.fromJson(_mapData);
    var errorCode = value.data!.errorCode ?? 1;
    if (errorCode == 0) {
      return value;
    } else {
      throw ErrorException(
          errorCode, value.data!.errorMessage ?? S.current.error);
    }
  }

  @override
  Future<FaceFPTCheck> checkFaceID(String faceUrl, String cmndUrl) async {
    Response _result = await _requestVFApi(_dio.post(
        AppConfigs.VF_HOST + 'faceIdPlatform',
        data: {"anhTrucDien": faceUrl, "anhCmtTruoc": cmndUrl}));
    var _mapData = _result.data!;
    final value = FaceFPTCheck.fromJson(_mapData);
    var errorCode = value.data?.code ?? "407";
    if (errorCode == '200') {
      return value;
    } else {
      throw ErrorException(
          int.parse(errorCode), value.data!.message ?? S.current.error);
    }
  }

  @override
  Future<OpenAccountResponse> openAccount(OpenAccountRequest request) async {
    Response _result = await _requestVFApi(
        _dio.post(AppConfigs.VF_HOST + 'core', data: request.toJson()));
    var _mapData = _result.data!;
    final value = OpenAccountResponse.fromJson(_mapData);
    return value;
  }

  @override
  Future signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<void> changePassword(RequestParams requestParams) async {
    try {
      await _requestApi(
          _dio.post(AppConfigs.ENDPOINT_CORE, data: requestParams.toJson()));
      return;
    } catch (e) {
      rethrow;
    }
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
  Future<AccountMStatus> getAccountMStatus(RequestParams requestParams) async {
    Response _result = await _requestApi(
        _dio.post(AppConfigs.ENDPOINT_CORE, data: requestParams.toJson()));
    var _mapData = _decodeMap(_result.data!);
    final value = AccountMStatus.fromJson(_mapData['data']);
    return value;
  }

  @override
  Future<List<Account>?> getListAccount(RequestParams requestParams) async {
    Response _result = await _requestApi(
        _dio.post(AppConfigs.ENDPOINT_CORE, data: requestParams.toJson()));

    var _mapData = _decodeMap(_result.data!);
    final value = ListAccountResponse.fromJson(_mapData);
    return value.data;
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
  Future<StockInfo> getStockInfo(RequestParams requestParams) async {
    try {
      Response _result = await _requestApi(
        _dio.post(
          AppConfigs.ENDPOINT_CORE,
          data: requestParams.toJson(),
        ),
      );
      var _mapData = _decodeMap(_result.data);
      final _value = StockInfo.fromJson(_mapData['data']);
      return _value;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CashBalance> getCashBalance(RequestParams requestParams) async {
    try {
      Response _result = await _requestApi(
        _dio.post(
          AppConfigs.ENDPOINT_CORE,
          data: requestParams.toJson(),
        ),
      );
      var _mapData = _decodeMap(_result.data);
      final _value = CashBalance.fromJson(_mapData['data']);
      return _value;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> newOrderRequest(RequestParams requestParams) async {
    try {
      await _requestOrderApi(
        _dio.post(
          AppConfigs.ENDPOINT_CORE,
          data: requestParams.toJson(),
        ),
      );
      return;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> cancleOrder(RequestParams requestParams) async {
    try {
      await _requestOrderApi(
        _dio.post(
          AppConfigs.ENDPOINT_CORE,
          data: requestParams.toJson(),
        ),
      );
      return;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<IndayOrder>> getIndayOrder(RequestParams requestParams) async {
    try {
      Response _result = await _requestApi(_dio.post(
        AppConfigs.ENDPOINT_CORE,
        data: requestParams.toJson(),
      ));
      List<dynamic> _listDataDynamic = _decodeMap(_result.data!)['data'];
      List<IndayOrder> _listData =
          _listDataDynamic.map((e) => IndayOrder.fromJson(e)).toList();
      return _listData;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<StockData>> getStockData(String stockCode) async {
    try {
      Response _result = await _getApi(
          _dio.get(AppConfigs.URL_DATA_FEED + "getliststockdata/$stockCode"));
      List _mapData = _result.data;
      List<StockData> listStock = [];
      _mapData.forEach((element) {
        listStock.add(StockData.fromJson(element));
      });
      return listStock;
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

  @override
  Future<List<IndexDetail>> getListIndexDetail(String listIndex) async {
    Response _result = await _getApi(
        _dio.get(AppConfigs.URL_DATA_FEED + 'getlistindexdetail/' + listIndex));
    List _mapData = _result.data;
    List<IndexDetail> listStock = [];
    _mapData.forEach((element) {
      listStock.add(IndexDetail.fromJson(element));
    });
    return listStock;
  }

  @override
  Future<String> getListStockCode(String market) async {
    Response _result = await _getApi(_dio.get(
      AppConfigs.INFO_SBSI + 'list30.pt',
      queryParameters: {"market": market},
    ));
    var _mapData = _result.data;
    return _mapData['list'];
  }
}
