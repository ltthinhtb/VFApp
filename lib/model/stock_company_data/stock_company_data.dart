class StockCompanyData {
  String? stockCode;
  String? nameVn;
  String? nameEn;
  String? postTo;
  String? nameShort;

  StockCompanyData(
      {this.stockCode, this.nameVn, this.nameEn, this.postTo, this.nameShort});

  StockCompanyData.fromJson(Map<String, dynamic> json) {
    stockCode = json['stock_code'];
    nameVn = json['name_vn'];
    nameEn = json['name_en'];
    postTo = json['post_to'];
    nameShort = json['name_short'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stock_code'] = stockCode;
    data['name_vn'] = nameVn;
    data['name_en'] = nameEn;
    data['post_to'] = postTo;
    data['name_short'] = nameShort;
    return data;
  }
}
