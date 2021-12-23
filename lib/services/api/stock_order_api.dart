part of 'api_service.dart';

extension StockOrderService on ApiService {
  Future<List<StockCompanyData>> getAllStockCompanyData() async {
    return await _apiClient.getAllStockCompanyData();
  }

  Future<AccountMStatus> getAccountMStatus(RequestParams requestParams) async {
    return await _apiClient.getAccountMStatus(requestParams);
  }

  Future<List<StockData>> getStockData(String stockCode) async {
    return await _apiClient.getStockData(stockCode);
  }

  Future<StockInfo> getStockInfo(RequestParams requestParams) async {
    return await _apiClient.getStockInfo(requestParams);
  }

  Future<CashBalance> getCashBalance(RequestParams requestParams) async {
    return await _apiClient.getCashBalance(requestParams);
  }

  Future<void> newOrderRequest(RequestParams requestParams) async {
    return await _apiClient.newOrderRequest(requestParams);
  }

  Future<void> cancleOrder(RequestParams requestParams) async {
    return await _apiClient.cancleOrder(requestParams);
  }

  Future<List<IndayOrder>> getIndayOrder(RequestParams requestParams) async {
    return await _apiClient.getIndayOrder(requestParams);
  }
}
