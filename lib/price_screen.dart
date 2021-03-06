// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bitcoin/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  late String selectedCurrency = 'USD';
  late List prices = [0, 0, 0];

  DropdownButton<String> androidDropdownButton() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (int i = 0; i < currenciesList.length; i++) {
      String currency = currenciesList[i];
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) async {
        setState(() {
          selectedCurrency = value!;
        });
        await getData();
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: pickerItems,
    );
  }

  Future<void> getData() async {
    for (int i = 0; i < cryptoList.length; i++) {
      var crypto = await CoinData(
              selectedCurrency: selectedCurrency, selectedCrypto: cryptoList[i])
          .getPrice();
      setState(() {
        prices[i] = crypto['rate'].toString().substring(0, 8);
      });
      print(prices[i]);
    }
    return;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
              child: Column(
                children: [
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cryptoList.length,
                      itemBuilder: (BuildContext context, int index) {
                        // return cardWidget(cryptoList[index]);
                        return Card(
                          color: Colors.lightBlueAccent,
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 28.0),
                            child: Text(
                              '1 ${cryptoList[index]} = ${prices[index]} $selectedCurrency',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
          height: 150.0,
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: 30.0),
          color: Colors.lightBlue,
          child: Platform.isIOS ? iOSPicker() : androidDropdownButton()),
    );
  }
}
