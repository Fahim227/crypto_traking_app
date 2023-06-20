
class Currency {
  DateTime? _dateTime;
  String? _currencyName;
  double? _usd;

  Currency({String? currencyName, double? usd,DateTime? dateTime}) {
    if (dateTime != null) {
      this._dateTime = dateTime;
    }
    if (currencyName != null) {
      this._currencyName = currencyName;
    }
    if (usd != null) {
      this._usd = usd;
    }
  }

  DateTime? get dateTime => _dateTime;
  set dateTime(DateTime? value) {
    _dateTime = value;
  }
  String? get currencyName => _currencyName;
  set currencyName(String? currencyName) => _currencyName = currencyName;
  double? get usd => _usd;
  set usd(double? usd) => _usd = usd;

  Currency.fromJson(Map<String, dynamic> json) {
    _dateTime = DateTime.fromMillisecondsSinceEpoch(json['dateTime']);
    _currencyName = json['currencyName'];
    _usd = json['usd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currencyName'] = this._currencyName;
    data['usd'] = this._usd;
    data['dateTime'] = this._dateTime!.millisecondsSinceEpoch;
    return data;
  }
}