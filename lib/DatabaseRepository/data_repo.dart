

import 'dart:convert';

import 'package:crypto_traking_app/Model/CurrencyListModel.dart';
import 'package:crypto_traking_app/Model/currency_model.dart';
import 'package:http/http.dart';
import 'package:sqflite/sqflite.dart';

import '../APIServices/service_api.dart';
import '../DatabaseProvider/offlineDatabase.dart';

class DataRepository{
  final _apiServices = ServiceAPI.APIService!;


  Future<CurrencyListModel> getAllCurrencyData() async {
    DatabaseHelper? dbHelper = await DatabaseHelper.instance;
    CurrencyListModel currencyListModel = CurrencyListModel();
    List<Currency> allCurrencyPrice = [];
    Response response = await _apiServices.getAllCurrencyPrice();
    if (response.statusCode == 200){

      final data = json.decode(response.body);
      print((data as Map).keys);
      for (var key in (data as Map).keys){
        Currency currency = Currency(dateTime: DateTime.now(),currencyName: key.toString(),usd: double.parse(data[key.toString()]['usd'].toString()));
        allCurrencyPrice.add(currency);
      }

      currencyListModel.dataList = allCurrencyPrice;
      int code = await dbHelper.insertCurrencyPrice(currencyListModel);
      currencyListModel = await dbHelper.getCurrencyPriceHistory();
      print(code);
    }
    return currencyListModel;
  }


}