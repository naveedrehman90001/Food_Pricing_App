import 'package:flutter/material.dart';
import 'package:kp_pricing_system/categories/Sweets.dart';
import 'package:kp_pricing_system/categories/fruits.dart';
import 'package:kp_pricing_system/categories/grains.dart';
import 'package:kp_pricing_system/categories/oils.dart';
import 'package:kp_pricing_system/categories/others.dart';
import 'package:kp_pricing_system/categories/poultry.dart';
import 'package:kp_pricing_system/categories/vegetables.dart';
import 'addProduct.dart';
import 'adminNotification.dart';
import 'adminSignUp.dart';
import 'checkComplaints.dart';

class UpdateProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Categories',
          style: TextStyle(
            fontFamily: 'Montserrat',
          ),
        ),
        backgroundColor: Colors.teal,
        elevation: 0.3,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: 130.0,
            width: double.infinity,
            color: Colors.teal,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  Text(
                    "Select Categories*",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontFamily: 'Montserrat',
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Text(
                    "زمرہ منتخب کریں۔",
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 22.0,
                        color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 130.0, left: 8.0, right: 8.0, bottom: 8.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: TheGridView().build(context),
            ),
          )
        ],
      ),
    );
  }
}

class TheGridView {
  Card makeGridCell(String name, String uname, String image) {
    return Card(
      elevation: 4.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  height: 80.0,
                  width: 80.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(75.0),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8.0,
                        color: Colors.teal,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                name,
                style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                uname,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  GridView build(BuildContext context) {
    return GridView.count(
      primary: true,
      padding: EdgeInsets.all(18.0),
      crossAxisCount: 2,
      childAspectRatio: 0.85,
      mainAxisSpacing: 1.0,
      crossAxisSpacing: 6.0,
      children: <Widget>[
        InkWell(
          child: makeGridCell("Fruits", 'پھل', 'images/fruits.jpg'),
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) => Fruits()));
          },
        ),
        InkWell(
          child: makeGridCell("Vegetables", 'سبزیاں', 'images/vegetables.jpg'),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => Vegetables()));
          },
        ),
        InkWell(
            child:
                makeGridCell("Poultry", 'مرغی اور گوشت', 'images/poultry.jpg'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Poultry()));
            }),
        InkWell(
          child: makeGridCell("Grains", 'اناج', 'images/grains.jpg'),
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) => Grains()));
          },
        ),
        InkWell(
          child: makeGridCell("Oils", 'تیل اور گھی', 'images/oils.jpg'),
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) => Oils()));
          },
        ),
        InkWell(
          child: makeGridCell("Sweets", 'مٹھائیاں', 'images/sweets.jpg'),
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) => Sweets()));
          },
        ),
        InkWell(
          child: makeGridCell("Others", 'متفرق', 'images/others.png'),
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) => Others()));
          },
        ),
      ],
    );
  }
}
