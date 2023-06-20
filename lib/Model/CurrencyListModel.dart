import 'package:crypto_traking_app/Model/currency_model.dart';

class CurrencyListModel {
  int? _page;
  int? _perPage;
  int? _total;
  int? _totalPages;
  List<Currency>? _dataList;

  CurrencyListModel(
      {int? page,
        int? perPage,
        int? total,
        int? totalPages,
        List<Currency>? dataList}) {
    if (page != null) {
      this._page = page;
    }
    if (perPage != null) {
      this._perPage = perPage;
    }
    if (total != null) {
      this._total = total;
    }
    if (totalPages != null) {
      this._totalPages = totalPages;
    }
    if (dataList != null) {
      this._dataList = dataList;
    }
  }

  int? get page => _page;
  set page(int? page) => _page = page;
  int? get perPage => _perPage;
  set perPage(int? perPage) => _perPage = perPage;
  int? get total => _total;
  set total(int? total) => _total = total;
  int? get totalPages => _totalPages;
  set totalPages(int? totalPages) => _totalPages = totalPages;
  List<Currency>? get dataList => _dataList;
  set dataList(List<Currency>? dataList) => _dataList = dataList;

  CurrencyListModel.fromJson(Map<String, dynamic> json) {
    _page = json['page'];
    _perPage = json['perPage'];
    _total = json['total'];
    _totalPages = json['totalPages'];
    if (json['dataList'] != null) {
      _dataList = <Currency>[];
      json['dataList'].forEach((v) {
        _dataList!.add(new Currency.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this._page;
    data['perPage'] = this._perPage;
    data['total'] = this._total;
    data['totalPages'] = this._totalPages;
    if (this._dataList != null) {
      data['dataList'] = this._dataList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}