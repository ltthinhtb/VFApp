import 'package:vf_app/model/order_data/inday_order.dart';
import 'package:vf_app/ui/pages/stock_order/stock_order_logic.dart';
import 'package:vf_app/utils/error_message.dart';
import 'package:vf_app/utils/order_utils.dart';

extension StringX on String {
  bool isIn(List<String> list) {
    if (list.contains(this)) {
      return true;
    } else {
      return false;
    }
  }

  bool isNotIn(List<String> list) {
    if (list.contains(this)) {
      return false;
    } else {
      return true;
    }
  }

  bool get isPositive {
    return RegExp(r'^[^-]([0-9]+\.?[0-9]*|\.[0-9]+)$').hasMatch(this);
  }

  bool get isNotPositive {
    return !RegExp(r'^[^-]([0-9]+\.?[0-9]*|\.[0-9]+)$').hasMatch(this);
  }

  bool get isMultipleOfTen {
    return RegExp(r'^[^-]([0-9]+0(\.?[0]*|\.[0]+)?)$').hasMatch(this);
  }

  bool get isMultipleOfHundred {
    return RegExp(r'^([1-9]+[0-9]*[00]+(\.[0]+)?)$').hasMatch(this);
  }

  bool get isANumber {
    return RegExp(r'^[+-]?([0-9]+\.?[0-9]*|\.[0-9]+)$').hasMatch(this);
  }

  bool get isNotANumber {
    return !RegExp(r'^[+-]?([0-9]+\.?[0-9]*|\.[0-9]+)$').hasMatch(this);
  }

  bool get isATO {
    if (this == "ATO") {
      return true;
    } else {
      return false;
    }
  }

  bool get isATC {
    if (this == "ATC") {
      return true;
    } else {
      return false;
    }
  }

  bool get isMP {
    if (this == "MP") {
      return true;
    } else {
      return false;
    }
  }

  bool get isPriceType {
    String? priceType = _priceType[this];
    if (priceType != null) {
      return true;
    } else {
      return false;
    }
  }
}

Map<PricesType, String> get _priceType => {
      PricesType.MP: "MP",
      PricesType.ATO: "ATO",
      PricesType.ATC: "ATC",
      PricesType.MTL: "MTL",
      PricesType.MOK: "MOK",
      PricesType.MAK: "MAK",
      PricesType.PLO: "PLO",
    };

extension IndatOrderX on IndayOrder {
  bool get canFix {
    String _status = MessageOrder.getStatusOrder(this);
    if (_status == "Khớp 1 phần" || _status == "Chờ khớp") {
      return true;
    } else {
      return false;
    }
  }
}
