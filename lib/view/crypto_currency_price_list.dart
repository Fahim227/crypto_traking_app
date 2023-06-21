import 'dart:async';

import 'package:crypto_traking_app/view_model/currency_price_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import '../DatabaseProvider/offlineDatabase.dart';

class CryptoCurrencyPrice extends StatefulWidget {
  const CryptoCurrencyPrice({Key? key}) : super(key: key);

  @override
  State<CryptoCurrencyPrice> createState() => _CryptoCurrencyPriceState();
}

class _CryptoCurrencyPriceState extends State<CryptoCurrencyPrice> {


  final currencyPriceViewModel = Get.put(CurrencyPriceViewModel());

  DatabaseHelper? DBHelper;
  Database? _dataBase;

  final scrollController = ScrollController();

  void _createDB() async {
    DBHelper = await DatabaseHelper.instance;
    _dataBase = await DBHelper!.database;
  }

  @override
  void initState() {
    super.initState();
    _createDB();
    currencyPriceViewModel.getAllCurrencyPrice();
    Timer.periodic(Duration(minutes: 5), (Timer t) => currencyPriceViewModel.getAllCurrencyPrice());

    scrollController.addListener(() {
      print(scrollController.position.outOfRange);
      if(scrollController.position.maxScrollExtent == scrollController.offset){
        Future.delayed(Duration(milliseconds: 300),(){
          currencyPriceViewModel.getAllCurrencyPrice();
        });
      }
      if (scrollController.offset >= scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        print("reach the bottom");
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CurrencyPriceViewModel>(

        builder: (controller){
          return Scaffold(
              appBar: AppBar(title: Text("Crypto Tracking App"),),
              body:
              controller.isLoading.value && controller.errorMessage.value.isEmpty ?
              Center(child: CircularProgressIndicator()):
              controller.errorMessage.value.isEmpty == false ? AlertDialog(
                title: null,
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text(controller.errorMessage.value),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Ok'),
                    onPressed: () {
                      // Navigator.of(context).pop();
                    },
                  ),

                ],
              ): Container(
                child: ListView.builder(
                    controller: scrollController,
                    itemCount: controller.currencyList.value.dataList!.length +1,
                    itemBuilder: (BuildContext context,int index){
                      if (index < controller.currencyList.value.dataList!.length){
                        return Card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(controller.currencyList.value.dataList![index].dateTime!.toString().split(' ').first),
                                  Text(controller.currencyList.value.dataList![index].dateTime!.toString().split(' ').last),
                                ],
                              ),

                              Column(
                                children: [
                                  Text(controller.currencyList.value.dataList![index].currencyName!),
                                  SizedBox(height: 10.0,),
                                  Text(controller.currencyList.value.dataList![index].usd!.toString()),
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                      else if (!scrollController.hasClients){
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 32.0),
                          child: Center(child: const CircularProgressIndicator())
                        );
                      }
                    } ),
              )
          );
        }
    );
  }
}
