
import 'dart:convert';

import 'package:crypto_traking_app/APIServices/app_services.dart';
import 'package:crypto_traking_app/Model/currency_model.dart';
import 'package:crypto_traking_app/res/api_url/api_url.dart';
import 'package:http/http.dart' as http;

class AppServicesImplement extends AppServices{



  @override
  Future<dynamic> getAllCurrencyPrice() async {
    final url = Uri.parse(APIUrl.priceUrl);
    http.Response response = await http.get(url);
    return response;
  }

}