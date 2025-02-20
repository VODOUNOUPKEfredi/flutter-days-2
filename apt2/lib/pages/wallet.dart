import 'package:u_credit_card/u_credit_card.dart';
import 'package:flutter/material.dart';
import 'package:apt2/pages/graphique.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const WalletPage(),
    );
  }
}

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
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
              "Hello Fredi !",
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
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
           Center(
        child: CreditCardUi(
          width: 300,
          cardHolderFullName: 'John Doe',
          cardNumber: '1234567812345678',
          validFrom: '01/23',
          validThru: '01/28',
          topLeftColor: Colors.blue,
          doesSupportNfc: true,
          placeNfcIconAtTheEnd: true,
          cardType: CardType.debit,
          cardProviderLogo: FlutterLogo(),
          cardProviderLogoPosition: CardProviderLogoPosition.right,
          showBalance: true,
          balance: 128.32434343,
          autoHideBalance: true,
          enableFlipping: true,
          cvvNumber: '123',
           )),
          SizedBox(height: 20),
          Row(children: [Text("Total spending")]),
          SizedBox(height: 10),
          Container(
            width: screenWidth * 1,
            height: screenHeight * 0.1,
            color: Colors.grey.withAlpha(50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Day"),
                Text("Week"),
                Text("Month"),
                Text("Custom rang"),
              ],
            ),
          ),

          LineChartSample2(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  width: screenWidth * 0.3,
                  child: Card(
                    elevation: 1,
                    color: Colors.white.withAlpha(180),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(
                            "Weekly spend",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),

                          Text(
                            "\$1.454.00",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Container(
                  width: screenWidth * 0.3,
                  child: Card(
                    elevation: 1,
                    color: Colors.white.withAlpha(180),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(
                            "Shopping",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),

                          Text(
                            "\$890.00",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: screenWidth * 0.3,
                  child: Card(
                    elevation: 1,
                    color: Colors.white.withAlpha(180),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(
                            "Others",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),

                          Text(
                            "\$564.00",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Weekly spend ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("\$ 2.960.00"),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, top: 5),
                  width: screenWidth * 0.3,
                  height: screenHeight * 0.05,
                  color: Colors.black.withAlpha(50),
                  child: Center(
                    child: Text(
                      "See details",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
