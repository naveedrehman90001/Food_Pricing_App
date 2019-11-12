import 'package:flutter/material.dart';
import 'package:kp_pricing_system/customShapeClipper.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ClipPath(
                clipper: CustomShapeClipper(),
                child: Container(
                  height: 30.0,
                  width: 30.0,
                  color: Color(0xFF399D63),
                ),
              ),
            ],
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Image.asset(
                  'images/notifi.png',
                  scale: 2.5,
                ),
              ),
              Text(
                "You don't have any Notification",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              Text(
                '       you should be Notified \n when any changes or event occure',
                style: TextStyle(fontSize: 13.0, color: Colors.grey),
              )
            ],
          ),
        ],
      ),
    );
  }
}
