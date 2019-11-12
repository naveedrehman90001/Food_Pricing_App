import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kp_pricing_system/HomePage.dart';
import 'package:kp_pricing_system/admin/adminDashboard.dart';
import 'package:kp_pricing_system/admin/adminSignIn.dart';
import 'package:kp_pricing_system/shopkeeper/shopkeeperDashboard.dart';
import 'package:kp_pricing_system/shopkeeper/shopkeeperProfile.dart';
import 'package:kp_pricing_system/shopkeeper/shopkeeperSignIn.dart';
import 'package:kp_pricing_system/shopkeeper/shopkeeperSignUp.dart';

import 'admin/addProduct.dart';
import 'admin/adminNotification.dart';
import 'admin/adminSignUp.dart';
import 'admin/checkComplaints.dart';
import 'admin/updateProduct.dart';
import 'mainPages/complaintBox.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: ThemeData(
          primaryColor: Color(0xFF399D63), brightness: Brightness.light),
      routes: <String, WidgetBuilder>{
        '/homePage': (BuildContext context) => HomePage(),
        '/adminSignIn': (BuildContext context) => AdminSignIn(),
        '/shopkeeperSignIn': (BuildContext context) => ShopkeeperSignIn(),
        '/shopkeeperDashboard': (BuildContext context) => ShopkeeperDashboard(),
        '/shopkeeperSignUp': (BuildContext context) => ShopkeeperSignUp(),
        '/complaintBox': (BuildContext context) => ComplaintBox(),
        '/adminDashboard': (BuildContext context) => AdminDashboard(),
        '/addProducts': (BuildContext context) => AddProducts(),
        '/adminSignUp': (BuildContext context) => AdminSignUp(),
        '/checkComplaints': (BuildContext context) => CheckComplaints(),
        '/updateProduct': (BuildContext context) => UpdateProduct(),
        '/details': (BuildContext context) => Details(),
        '/shopkeeperProfile': (BuildContext context) => ShopkeeperProfile(),

      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      Duration(milliseconds: 3000),
      () => Navigator.of(context).pushReplacementNamed('/homePage'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/backk.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.7),
          ),

          Positioned(
            top: 150.0,
            left: 130.0,
            child: Container(
              height: 90.0,
              width: 90.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(46.0),
                  color: Colors.grey,
                  image: DecorationImage(
                    image: AssetImage('images/kps.jpg'),
                    fit: BoxFit.cover,
                  )),
            ),
          ),

          Positioned(
            top: 280,
            left: 55,
            child: Text(
              'Kohat Pricing System',
              style: TextStyle(fontSize: 30.0, color: Colors.white),
            ),
          ),
          Positioned(
            bottom: 100.0,
            right: 160.0,
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
