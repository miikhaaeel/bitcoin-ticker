import 'package:http/http.dart' as http;
import 'dart:convert';

const kHeader = 'X-CoinAPI-Key';
const kApiKey = 'D0963E8F-25F0-4774-B282-62A2ABDC4E58';
//99B3277D-DEFF-4C5E-8E94-42D7FC46EE2E
//D0963E8F-25F0-4774-B282-62A2ABDC4E58
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
  'BCH',
  'MATIC',
  'OCEAN'
];

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};

    for (var crypto in cryptoList) {
      http.Response response = await http.get(
        Uri.parse(
            "https://rest.coinapi.io/v1/exchangerate/$crypto/$selectedCurrency"),
        headers: {kHeader: kApiKey},
      );

      if (response.statusCode == 200) {
        String data = response.body;
        var decodedData = jsonDecode(data);
       // print(decodedData);
        double lastPrice = decodedData['rate'];
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}
