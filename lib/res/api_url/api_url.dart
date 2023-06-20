
class APIUrl{
  static const String baseUrl = 'https://api.coingecko.com/api/v3/simple';

  static const String priceUrl = "$baseUrl/price?ids=bitcoin,ethereum,litecoin&vs_currencies=usd";
}