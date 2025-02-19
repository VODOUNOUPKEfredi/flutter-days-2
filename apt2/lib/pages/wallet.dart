import 'package:u_credit_card/u_credit_card.dart';
import 'package:flutter/material.dart';
import 'package:apt2/pages/graphique.dart';


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
      appBar: AppBar(
        title: const Text("Wallets"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.add_circle_outline)),
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
            ),
          ),
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
   

        ],
      ),
    );
  }
}
