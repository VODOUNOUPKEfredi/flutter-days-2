//import 'dart:ffi';
//import 'dart:convert';
//import 'package:apt2/pages/home.dart';
import 'package:apt2/pages/envoi.dart';
import 'package:flutter/material.dart';
//import 'package:apt2/pages/provider/transaction_provider.dart';
//import 'package:apt2/pages/models/transaction.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:apt2/pages/widget/transaction_list.dart';

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
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  double _solde = 10000;

  get provider => null;

  get selectedFilter => null;

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('images/1.png'),
            ),
            SizedBox(width: 10),
            Text(
              "Hello fredi !",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: screenWidth * 0.95,
              height: screenHeight * 0.3,
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
                      SizedBox(height: 15),
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
                      SizedBox(height: 15),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EnvoiPage()),
                    );
                  },
                  child: Text("Send"),
                ),
                ElevatedButton(onPressed: () {}, child: Text("Receive")),
                ElevatedButton(onPressed: () {}, child: Text("Rewards")),
              ],
            ),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recent activity",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  value: selectedFilter,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      provider.filterTransactions(newValue);
                    }
                  },
                  items:
                      <String>[
                        "All",
                        "Income",
                        "Expenses",
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                ),
              ],
            ),
            SizedBox(height: 5),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage('images/1.png'),
                              ),
                              SizedBox(width: 10),
                              Column(
                                children: [
                                  Text("Miradie"),
                                  Text("25 jan 2025"),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              "\$ 118985",
                              style: TextStyle(color: Colors.blue),
                            ),
                            Text("22h 42"),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage('images/1.png'),
                              ),
                              SizedBox(width: 10),
                              Column(
                                children: [
                                  Text("Miradie"),
                                  Text("25 jan 2025"),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              "\$ 118985",
                              style: TextStyle(color: Colors.blue),
                            ),
                            Text("22h 42"),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage('images/1.png'),
                              ),
                              SizedBox(width: 10),
                              Column(
                                children: [
                                  Text("Miradie"),
                                  Text("25 jan 2025"),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              "-\$ 985",
                              style: TextStyle(color: Colors.red),
                            ),
                            Text("22h 42"),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage('images/1.png'),
                              ),
                              SizedBox(width: 10),
                              Column(
                                children: [
                                  Text("Miradie"),
                                  Text("25 jan 2025"),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              "\$ 585",
                              style: TextStyle(color: Colors.blue),
                            ),
                            Text("22h 42"),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage('images/1.png'),
                              ),
                              SizedBox(width: 10),
                              Column(
                                children: [
                                  Text("Miradie"),
                                  Text("25 jan 2025"),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              "-\$5189",
                              style: TextStyle(color: Colors.red),
                            ),
                            Text("22h 42"),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage('images/1.png'),
                              ),
                              SizedBox(width: 10),
                              Column(
                                children: [
                                  Text("Miradie"),
                                  Text("25 jan 2025"),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              " -\$118985",
                              style: TextStyle(color: Colors.red),
                            ),
                            Text("22h 42"),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // TransactionList(),
            ),
          ],
        ),
      ),
    );
  }
}
