import 'package:crypto_traking_app/view/crypto_currency_price_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto Currency Price Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CryptoCurrencyPrice(),
    );
  }
}
