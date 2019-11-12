import 'package:flutter/material.dart';
import 'package:kp_pricing_system/admin/shopProfiles.dart';
import 'package:kp_pricing_system/admin/updateProduct.dart';
import 'package:kp_pricing_system/mainPages/complaintBox.dart';

import '../HomePage.dart';
import 'addProduct.dart';
import 'adminSignUp.dart';
import 'checkComplaints.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin Dashboard',
          style: TextStyle(
            fontFamily: 'Montserrat',
          ),
        ),
        backgroundColor: Colors.teal,
        elevation: 0.3,
      ),

// ADMIN DRAWER STARTS FROM HERE

      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            //Drawer header
            UserAccountsDrawerHeader(
              accountName: Text("Naveed bangash"),
              accountEmail: Text("naveedbangash172@gmail.com"),
              currentAccountPicture: GestureDetector(
                  child: Container(
                height: 60.0,
                width: 60.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(37.0),
                    color: Colors.grey,
                    image: DecorationImage(
                      image: AssetImage('images/kps.jpg'),
                      fit: BoxFit.cover,
                    )),
              )),
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
            ),

            // Drawer body
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text("Home Page"),
                leading: Icon(Icons.home, color: Colors.teal),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text("Add Member"),
                leading: Icon(
                  Icons.perm_identity,
                  color: Colors.teal,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text("Update Items"),
                leading: Icon(Icons.edit, color: Colors.teal),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text("Categories"),
                leading: Icon(Icons.dashboard, color: Colors.teal),
              ),
            ),

            Divider(),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text("About"),
                leading: Icon(
                  Icons.help,
                  color: Colors.teal,
                ),
              ),
            ),
          ],
        ),
      ),

      body: Stack(
        children: <Widget>[
          Container(
            height: 130.0,
            width: double.infinity,
            color: Colors.teal,
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 50.0, left: 8.0, right: 8.0, bottom: 8.0),
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
                    height: 60.0,
                    width: 60.0,
                    child: Center(child: Image.asset(image))),
              ),
              SizedBox(height: 10.0),
              Text(
                name,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                uname,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
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
      childAspectRatio: 1.0,
      mainAxisSpacing: 1.0,
      crossAxisSpacing: 6.0,
      children: <Widget>[
        InkWell(
          child: makeGridCell(
              "Add Products", 'مصنوعات شامل کریں', 'images/addproducts.png'),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => AddProducts()));
          },
        ),
        InkWell(
            child: makeGridCell(
                "Update Products", 'مصنوعات کو اپ ڈیٹ کریں', 'images/update.ico'),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => UpdateProduct()));
          },
        ),
        InkWell(
            child: makeGridCell(
                "Add Members", 'رکن شامل کریں', 'images/addmem.png'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => AdminSignUp()));
            }),
        InkWell(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => ShopProfile()));
          },
          child: makeGridCell(
              "Profiles", 'دکاندار پروفائل', 'images/shopkeeperprofile.png'),
        ),
        InkWell(
          child: makeGridCell(
              "Complaint Box", 'شکایت کا باکس ', 'images/complaint.png'),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => CheckComplaints()));
          },
        ),
        makeGridCell("Statistics", 'اعداد و شمار اور گراف', 'images/statistics.png'),
        makeGridCell("Cities Price List", 'رکن شامل کریں', 'images/history.png'),
      ],
    );
  }
}
