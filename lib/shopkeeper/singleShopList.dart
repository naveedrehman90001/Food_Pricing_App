import 'package:flutter/material.dart';
import 'package:kp_pricing_system/customShapeClipper.dart';

class SingleList extends StatefulWidget {
  @override
  _SingleListState createState() => _SingleListState();
}

class _SingleListState extends State<SingleList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 5.0,left: 14.0,right: 14.0,bottom: 10.0),
                child: Text("Daliy Price List", style: TextStyle(fontSize: 30.0)),
              ),

              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Container(
                      height: 30.0,
                      width: 80.0,
                      //  color: Colors.teal,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          Text("Kohat",style: TextStyle(fontSize: 20.0,color: Colors.black),),
                          // SizedBox(width: 08.0),
                          Icon(Icons.keyboard_arrow_down,color: Colors.black),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(left: 20.0,right: 170.0),
            child: Container(
                color: Colors.green.withOpacity(0.6),
                child: Text('Fruits Shop',style: TextStyle(fontSize: 30.0),)),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  getFruitCard(
                      'images/banana.jpg', 'Banana','کیلا', 'Rs:200 / Dzn', true),
                  getFruitCard(
                      'images/orange.jpg', 'Orange','کینوا', 'Rs:150 / Dzn', false),
                  getFruitCard(
                      'images/apricots.jpg', 'Apricots','خوبانی' ,'Rs:90 / Kg', true),

                  getFruitCard(
                      'images/pinapple.jpg', 'PineApple','انناس', 'Rs:180 / each', true),
                  getFruitCard(
                      'images/apple.jpg', 'Apple','سیب', 'Rs:80 / Kg', false),
                  getFruitCard(
                      'images/peach.jpg', 'Peach','آڑو' ,'Rs:120 / Kg', true),

                  SizedBox(height: 15.0),
                ],
              ),
              Column(
                children: <Widget>[
                  SizedBox(height: 25.0),
                  getFruitCard(
                      'images/pinapple.jpg', 'PineApple','انناس', 'Rs:180 / each', true),
                  getFruitCard(
                      'images/apple.jpg', 'Apple','سیب', 'Rs:80 / Kg', false),
                  getFruitCard(
                      'images/peach.jpg', 'Peach','آڑو' ,'Rs:120 / Kg', true),

                  getFruitCard(
                      'images/banana.jpg', 'Banana','کیلا', 'Rs:200 / Dzn', true),
                  getFruitCard(
                      'images/orange.jpg', 'Orange','کینوا', 'Rs:150 / Dzn', false),
                  getFruitCard(
                      'images/apricots.jpg', 'Apricots','خوبانی' ,'Rs:90 / Kg', true),
                ],
              )
            ],
          ),

        ],
      ),
    );
  }
  // GENERATE A CARD FOR THE CATEGORY IN MAIN SCREEN
  Widget getFruitCard(
      String imgPath, String fruitName,String fruitUrduName, String price, bool isFav) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
      child: Container(
        height: 210.0,
        width: (MediaQuery.of(context).size.width / 2) - 20,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                blurRadius: 2.0,
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2.0,
              )
            ]),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 115.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0)),
                      image: DecorationImage(
                          image: AssetImage(imgPath), fit: BoxFit.cover)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: isFav
                        ? Icon(Icons.favorite, color: Colors.red)
                        : Icon(Icons.favorite_border, color: Colors.red),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.0),
            Text(
              fruitUrduName,
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            Text(
              fruitName,
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4.0),
            Text(
              price,
              style: TextStyle(fontSize: 17.0, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}


