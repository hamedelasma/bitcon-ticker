import 'networking.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  late String selectedCurrency;
  late String selectedCrypto;
  final String apikey = '0EB942FF-9EF8-49C5-B2DC-04E7711EA017';
  final String apiUrl = 'https://rest.coinapi.io/v1/exchangerate/';

  CoinData({required this.selectedCurrency, required this.selectedCrypto});

  getPrice() async {
    NetworkHelper networkHelper = NetworkHelper(
        '$apiUrl$selectedCrypto/$selectedCurrency?apikey=$apikey');
    var priceData = await networkHelper.getData();
    return priceData;
  }
}
//https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=0EB942FF-9EF8-49C5-B2DC-04E7711EA017
