import 'package:http/http.dart' as http;
import 'dart:convert';

const kHeader = 'X-CoinAPI-Key';
const kApiKey = '99B3277D-DEFF-4C5E-8E94-42D7FC46EE2E';

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
  final String? currency;
  final String? coin;
  CoinData({this.coin, this.currency});

  Future getCoinData() async {
    http.Response response = await http.get(
      Uri.parse("https://rest.coinapi.io/v1/exchangerate/$coin/$currency"),
      headers: {kHeader: kApiKey},
    );
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      var lastPrice = decodedData['rate'];
      return lastPrice;
    } else {
      print(response.statusCode);
    }
  }
}
