
import 'package:crypto_traking_app/DatabaseRepository/data_repo.dart';
import 'package:crypto_traking_app/Model/CurrencyListModel.dart';
import 'package:get/get.dart';

class CurrencyPriceViewModel extends GetxController{
  final _dataRepository = DataRepository();

  final currencyList = CurrencyListModel().obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;


  void getAllCurrencyPrice(){
    isLoading.value = true;
    update();
    _dataRepository.getAllCurrencyData().then((value) {
      print(value.dataList!.length);
      currencyList.value = value;
      Future.delayed(Duration(milliseconds: 700),(){
        isLoading.value = false;
        update();
      });
    }).onError((error, stackTrace) {
      errorMessage.value = error.toString();
      update();
      print(error);
    });
  }

}