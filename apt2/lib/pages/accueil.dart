import 'dart:ffi';
import 'dart:convert';
import 'package:apt2/pages/home.dart';
import 'package:flutter/material.dart';
//mport 'LocalStorage.dart';
//
//import 'Transferpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Homepage(),
    ),
  );
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final List<Map<String, dynamic>> transactions = [
    {
      "name": "Breakfast",
      "image": 'images/1.png',
      "date": "22 jan 2025",
      'montant': 100000,
      "heure": "20h 19",
    },
    {
      "name": "Breakfast",
      "image": 'images/1.png',
      "date": "22 jan 2025",
      "montant": 7500,
      "heure": "20h 19",
    },
    {
      "name": "Breakfast",
      "image": 'images/1.png',
      "date": "22 jan 2025",
      "montant": 20200,
      "heure": "20h 19",
    },
    {
      "name": "Breakfast",
      "image": 'images/1.png',
      "date": "22 jan 2025",
      "montant": 20,
      "heure": "20h 19",
    },
    {
      "name": "Breakfast",
      "image": 'images/1.png',
      "date": "22 jan 2025",
      "montant": 1000,
      "heure": "20h 19",
    },
    {
      "name": "Breakfast",
      "image": 'images/1.png',
      "date": "22 jan 2025",
      "montant": 0,
      "heure": "20h 19",
    },
    {
      "name": "Breakfast",
      "image": 'images/1.png',
      "date": "22 jan 2025",
      "montant": 1000,
      "heure": "20h 19",
    },
    {
      "name": "Breakfast",
      "image": 'images/1.png',
      "date": "22 jan 2025",
      "montant": 0,
      "heure": "20h 19",
    },
  ];
  int? selIndex = 0;
  double _solde = 10000;
  @override
  void iniState() {
    super.initState();
    _chargerSolde();
  }

  Future<void> _chargerSolde() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _solde = prefs.getDouble('solde') ?? 1000;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text("fredi")),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              width: screenWidth * 0.95,
              height: screenHeight * 0.35,
              child: Card(
                elevation: 15,
                color: Colors.blue,
                child: Padding(
                  padding: EdgeInsets.all(16),

                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Fredi account",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "Arian zesan",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Center(
                        child: Text(
                          '$_solde \$',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      SizedBox(),
                      Center(
                        child: Text(
                          "Total balance",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Added cart 05",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "Ac no 2234521",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),

                      // ElevatedButton(
                      //   onPressed: () {},
                      //   child: Text("tranferer de largent"),
                      // ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Features",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "See all",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: Colors.black.withAlpha(50),
                    width: screenWidth * 0.25,
                    height: screenHeight * 0.05,
                    child: Row(
                      children: [Icon(Icons.arrow_downward), Text("send")],
                    ),
                  ),
                  Container(
                    color: Colors.black.withAlpha(50),
                    width: screenWidth * 0.3,
                    height: screenHeight * 0.05,
                    child: Row(
                      children: [Icon(Icons.arrow_downward), Text("Receive")],
                    ),
                  ),
                  Container(
                    color: Colors.black.withAlpha(50),
                    width: screenWidth * 0.3,
                    height: screenHeight * 0.05,
                    child: Row(
                      children: [
                        Icon(
                          Icons.card_giftcard_sharp,
                          color: Colors.black.withAlpha(100),
                        ),
                        Text("Rewards"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recent activity",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "All",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,

                itemBuilder: (context, index) {
                  var transaction = transactions[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(child: Image.asset('image/1.png')),
                              SizedBox(width: 20),
                              Column(
                                children: [
                                  Text(
                                    transaction["name"],
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    transaction["date"],
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w100,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),

                      Column(
                        children: [
                          Text(
                            transaction["montant"].toString(),
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            transaction["heure"].toString(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
