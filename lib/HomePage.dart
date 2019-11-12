import 'package:flutter/material.dart';
import 'package:kp_pricing_system/mainPages/mainCategories.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kohat Pricing System',
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        elevation: 0.0,
        backgroundColor: Colors.teal,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Icon(Icons.notifications),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: InkWell(
                onTap: (){
                  Navigator.of(context).pushNamed('/complaintBox');
                },
                child: Icon(Icons.add)),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            //Drawer header
            UserAccountsDrawerHeader(
              accountName: Text("Kohat Pricing System"),
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
              onTap: () {
                Navigator.of(context).pushNamed('/adminSignIn');
              },
              child: ListTile(
                title: Text("Admin"),
                leading: Icon(
                  Icons.perm_identity,
                  color: Colors.teal,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('/shopkeeperSignIn');
              },
              child: ListTile(
                title: Text("Shopkeeper"),
                leading: Icon(Icons.person, color: Colors.teal),
              ),
            ),

            Divider(),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('/complaintBox');
              },
              child: ListTile(
                title: Text("Complaint Box"),
                leading: Icon(Icons.comment, color: Colors.teal),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('/shopkeeperProfile');
              },
              child: ListTile(
                title: Text("Cities Price List"),
                leading: Icon(Icons.list, color: Colors.teal),
              ),
            ),

            Divider(),
            InkWell(
              onTap: (){
               // Navigator.of(context).pushNamed('/adminDashboard');
              },
              child: ListTile(
                title: Text("About"),
                leading: Icon(Icons.help, color: Colors.teal),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: <Widget>[
            Container(
              height: 90.0,
              width: double.infinity,
              color: Colors.teal,
              child: Padding(
                padding: const EdgeInsets.only(top: 23, left: 23, right: 20),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Search here....',
                    hintStyle: TextStyle(fontSize: 17.0, color: Colors.white70),
                    contentPadding: EdgeInsets.all(10.0),
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1.0),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide:
                            BorderSide(color: Colors.white, width: 1.0)),
                  ),
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              child: MainCategories(),
            )
          ],
        ),
      ),
    );
  }
}
