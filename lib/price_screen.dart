import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedValue = 'USD';
  String bitCoinValue = '?';
  String coin = 'BTC';

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
      value: selectedValue,
      items: getDropDownItem(),
      onChanged: (value) {
        setState(() {
          selectedValue = value as String;
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

  void getData() async {
    bitCoinValue = '?';
    CoinData coinData = CoinData(coin: coin, currency: selectedValue);
    double data = await coinData.getCoinData();
    setState(() {
      bitCoinValue = data.toStringAsFixed(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 $coin = $bitCoinValue $selectedValue',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          TextButton(
              onPressed: getData,
              child: Container(
                color: Colors.amber,
                height: 30,
                width: 30,
              )),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child:
                Platform.isAndroid ? getDropDownButton() : getCupertinoPicker(),
          ),
        ],
      ),
    );
  }
}
