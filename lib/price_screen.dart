import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'crypto_card.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String coinValue = '?';

  @override
  void initState() {
    super.initState();
    getData();
  }

  List<DropdownMenuItem<String>> getDropDownItem() {
    List<DropdownMenuItem<String>> dropDownItems = [];

    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );

      dropDownItems.add(newItem);
    }
    return dropDownItems;
  }

  List<Text> getPickerItem() {
    List<Text> pickerItems = [];

    for (String currency in currenciesList) {
      pickerItems.add(
        Text(currency),
      );
    }
    return pickerItems;
  }

  DropdownButton getDropDownButton() {
    return DropdownButton(
      value: selectedCurrency,
      items: getDropDownItem(),
      onChanged: (value) {
        setState(() {
          selectedCurrency = value as String;
        });
        getData();
      },
    );
  }

  CupertinoPicker getCupertinoPicker() {
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: getPickerItem(),
    );
  }

  bool isWaiting = false;
  Map<String, String> coinValues = {};
  void getData() async {
    isWaiting = true;
    CoinData coinData = CoinData();
    var data = await coinData.getCoinData(selectedCurrency);
    isWaiting = false;
    setState(() {
      coinValues = data;
    });
  }

  Column makeCards() {
    List<CryptoCard> cryptoCards = [];
    for (String crypto in cryptoList) {
      cryptoCards.add(
        CryptoCard(
          cryptoCurrency: crypto,
          currency: selectedCurrency,
          coinValue: isWaiting ? '?' : coinValues[crypto] as String,
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cryptoCards,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          makeCards(),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 150, right: 150, bottom: 10),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFF0D47A1),
                          Color(0xFF1976D2),
                          Color(0xFF42A5F5),
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(10.0),
                      primary: Colors.white,
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      getData();
                    },
                    child: const Text('Reload'),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isAndroid
                  ? getDropDownButton()
                  : getCupertinoPicker(),
            ),
          ),
        ],
      ),
    );
  }
}
//  TextButton(style: ButtonStyle(),
//             onPressed: getData,
//             child: Container(
//               color: Colors.amber,
//               child: Center(child: Text('Reload',style: ,),),
              
//               height: 30,
//               width: 100,
//             ),
//           ),