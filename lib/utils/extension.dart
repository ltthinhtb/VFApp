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
}
