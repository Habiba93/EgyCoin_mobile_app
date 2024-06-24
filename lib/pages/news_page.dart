import 'package:egycoin_mobile_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bills Payments',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class NewsPage extends StatelessWidget {
  // Function to open URL
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Latest News'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            // news 1 tile
            Link(
              uri: Uri.parse(
                  'https://www.egypttoday.com/Article/3/129670/CBE-seeking-to-launch-government-issued-E-Pound-to-boost'),
              builder: (context, followLink) => GestureDetector(
                onTap: followLink,
                child: _buildBillTile(
                  'lib/icons/egypt today.png',
                  'Egypt Today',
                  "Check latest news",
                  //"E-Pound to boost LE’s competitiveness"
                ),
              ),
            ),

            SizedBox(height: 12),
            // news 2 tile
            Link(
              uri: Uri.parse(
                  'https://www.dailynewsegypt.com/2023/01/02/cbe-studies-using-central-bank-digital-currency/'),
              builder: (context, followLink) => GestureDetector(
                onTap: followLink,
                child: _buildBillTile(
                  'lib/icons/daily news.png',
                  'Daily News Egypt',
                  "Check latest news",
                ),
              ),
            ),

            SizedBox(height: 12),
            // news 3 tile
            Link(
              uri: Uri.parse(
                  'https://www.businesstodayegypt.com/Article/4/3897/CBE-issued-digital-currency-is-in-the-works-E-Pound'),
              builder: (context, followLink) => GestureDetector(
                onTap: followLink,
                child: _buildBillTile(
                  'lib/icons/Bt_Logo.png',
                  'Business today Egypt',
                  "Check latest news",
                ),
              ),
            ),

            SizedBox(height: 12),
            // news 4 tile
            Link(
              uri: Uri.parse(
                  'https://digitalpoundfoundation.com/egypt-sets-sight-on-2030-for-launching-e-pound-cbdc-aiming-for-complete-financial-inclusion/'),
              builder: (context, followLink) => GestureDetector(
                onTap: followLink,
                child: _buildBillTile(
                  'lib/icons/Logo-for-DPF.png',
                  'Digital Pound Foundation',
                  "Check latest news",
                ),
              ),
            ),

            SizedBox(height: 12),
            // news 5 tile
            Link(
              uri: Uri.parse(
                  'https://cbdctracker.org/'),
              builder: (context, followLink) => GestureDetector(
                onTap: followLink,
                child: _buildBillTile(
                  'lib/icons/CBDC tracker.png',
                  'CBDC tracker',
                  "Check latest news",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBillTile(String iconPath, String title, String subtitle) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                iconPath,
                width: 48,
                height: 48,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(subtitle),
                ],
              ),
            ],
          ),
          Icon(Icons.arrow_forward_ios, size: 30), // Changed the arrow icon
        ],
      ),
    );
  }
}
