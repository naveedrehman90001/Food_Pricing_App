import 'package:flutter/material.dart';
import 'package:kp_pricing_system/categories/Sweets.dart';
import 'package:kp_pricing_system/categories/fruits.dart';
import 'package:kp_pricing_system/categories/grains.dart';
import 'package:kp_pricing_system/categories/oils.dart';
import 'package:kp_pricing_system/categories/others.dart';
import 'package:kp_pricing_system/categories/poultry.dart';
import 'package:kp_pricing_system/categories/vegetables.dart';

class MainCategories extends StatefulWidget {
  @override
  _MainCategoriesState createState() => _MainCategoriesState();
}

class _MainCategoriesState extends State<MainCategories> with SingleTickerProviderStateMixin{

  TabController tabController;

  @override
  void initState() {
    super.initState();
   tabController = TabController(length: 7, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[

//THIS SECTION CONTAINS THE TAB VIEW OF THE MAIN SCREEN

          Padding(
            padding: EdgeInsets.only(top: 0.0,left: 20.0,right: 20.0,bottom: 0.0),
            child: TabBar(
              controller: tabController,
              indicatorColor: Colors.teal,
              labelColor: Colors.teal,
              unselectedLabelColor: Colors.grey,
              isScrollable: true,
              tabs: <Widget>[
                Tab(
                  child: Text(
                    'Fruits',
                    style: TextStyle(fontSize: 17.0),
                  ),
                ),
                Tab(
                  child: Text(
                    'vegetable',
                    style: TextStyle(fontSize: 17.0),
                  ),
                ),
                Tab(
                  child: Text(
                    'Grains',
                    style: TextStyle(fontSize: 17.0),
                  ),
                ),
                Tab(
                  child: Text(
                    'poultry',
                    style: TextStyle(fontSize: 17.0),
                  ),
                ),

                Tab(
                  child: Text(
                    'Oils',
                    style: TextStyle(fontSize: 17.0),
                  ),
                ),
                Tab(
                  child: Text(
                    'Sweets',
                    style: TextStyle(fontSize: 17.0),
                  ),
                ),
                Tab(
                  child: Text(
                    'others',
                    style: TextStyle(fontSize: 17.0),
                  ),
                )
              ],
            ),
          ),

          // THE CONTAINER FOR THE TAB VIEW TO BE DISPLAYED

          Container(
            height: MediaQuery.of(context).size.height,
            child: TabBarView(
              controller: tabController,
              children: <Widget>[
                Fruits(),
                Vegetables(),
                Grains(),
                Poultry(),
                Oils(),
                Sweets(),
                Others(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
