import 'package:egycoin_mobile_app/pages/bills.dart';
import 'package:egycoin_mobile_app/pages/connectWallet.dart';
import 'package:egycoin_mobile_app/pages/news_page.dart';
import 'package:egycoin_mobile_app/pages/transfer_history.dart';
import 'package:flutter/material.dart';
import 'package:egycoin_mobile_app/pages/settings.dart';
import 'package:egycoin_mobile_app/pages/account_screen.dart';
//import 'package:egycoin_mobile_app/pages/pay_bill.dart';
import 'package:egycoin_mobile_app/pages/transfer_money.dart';
import 'package:egycoin_mobile_app/pages/transfer_money_abroad.dart';
import 'package:egycoin_mobile_app/util/my_button.dart';
import 'package:egycoin_mobile_app/util/my_card.dart';
import 'package:egycoin_mobile_app/util/my_list_tile.dart';
import 'package:local_auth/local_auth.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web3modal_flutter/pages/connect_wallet_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = PageController();


  late final LocalAuthentication auth;
  bool _supportState =false;

  @override
  void initState(){
    super.initState();
    auth=LocalAuthentication();
    auth.isDeviceSupported().then(
      (bool isSupported) => setState(() {
        _supportState=isSupported;
      }),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.pink,
        child: Icon(
          Icons.monetization_on,
          size: 32,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ConnectWalletPage()),
                  );
                },
                icon: Icon(
                  Icons.home,
                  size: 32,
                  color: Colors.pink[200],
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                  );
                },
                icon: Icon(
                  Icons.settings,
                  size: 32,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'My',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Cards',
                        style: TextStyle(fontSize: 28),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.add),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            Container(
              height: 200,
              child: PageView(
                scrollDirection: Axis.horizontal,
                controller: _controller,
                children: [
                  MyCard(
                    balance: 5250.20,
                    cardNumber: 12345678,
                    expiryMonth: 10,
                    expiryYear: 24,
                    color: Colors.deepPurple[300],
                  ),
                  MyCard(
                    balance: 342.23,
                    cardNumber: 12345678,
                    expiryMonth: 11,
                    expiryYear: 22,
                    color: Colors.blue[300],
                  ),
                  MyCard(
                    balance: 420.42,
                    cardNumber: 12345678,
                    expiryMonth: 8,
                    expiryYear: 25,
                    color: Colors.green[300],
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            SmoothPageIndicator(
              controller: _controller,
              count: 3,
              effect: ExpandingDotsEffect(
                activeDotColor: Colors.grey.shade800,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyButton(
                    iconImagePath: 'lib/icons/send-money.png',
                    buttonText: 'Transfer',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TransferMoneyScreen()),
                      );
                    },
                  ),
                  MyButton(
                    iconImagePath: 'lib/icons/credit-card.png',
                    buttonText: 'Money Abroad',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TransferMoneyAbroadScreen()),
                      );
                    },
                  ),
                  MyButton(
                    iconImagePath: 'lib/icons/wallet.png',
                    buttonText: 'CBDC',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => wallet()),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  MyListTile(
                    iconImagePath: 'lib/icons/statistics.png',
                    titleSubtitle: 'News',
                    titleTitle: 'CBDC recent news',
                    onTap: () {
                      // Navigate to a page displaying recent CBDC news
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NewsPage()),
                      );
                    },
                  ),
                  MyListTile(
                    iconImagePath: 'lib/icons/transaction.png',
                    titleSubtitle: 'Transactions',
                    titleTitle: 'Transaction History',
                    onTap: () {
                      // Navigate to a page displaying transaction history
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TransactionHistoryScreen()),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
