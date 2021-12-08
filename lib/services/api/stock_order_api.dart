part of 'api_service.dart';

extension StockOrderService on ApiService {
  Future<List<StockCompanyData>> getAllStockCompanyData() async {
    return await _apiClient.getAllStockCompanyData();
  }

  Future<StockData> getStockData(String stockCode) async {
    return await _apiClient.getStockData(stockCode);
  }
}
