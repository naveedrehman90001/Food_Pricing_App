import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kp_pricing_system/services/crud.dart';

class Vegetables extends StatefulWidget {
  @override
  _VegetablesState createState() => _VegetablesState();
}

class _VegetablesState extends State<Vegetables> {
  var product;

  var _price;

  crudMedthods crudObj = new crudMedthods();

  @override
  void initState() {
    crudObj.getVegetablesData().then((results) {
      setState(() {
        product = results;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 10.0,
          left: 18.0,
          right: 18.0,
          bottom: 8.0,
        ),
        child: StreamBuilder(
            stream: product,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Text('"Loading...');
              }
              int length = snapshot.data.documents.length;

              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    mainAxisSpacing: 2.0,
                    crossAxisSpacing: 6.0, //space largo de cada card
                  ),
                  itemCount: length,
                  // padding: EdgeInsets.all(2.0),
                  itemBuilder: (_, i) {
                    final DocumentSnapshot doc = snapshot.data.documents[i];
                    return Container(
                      child: GestureDetector(
                        onDoubleTap: () {
                          updateDialog(
                              context, snapshot.data.documents[i].documentID);
                        },

                        onLongPress: (){
                          crudObj.deleteItemData(snapshot.data.documents[i].documentID);
                        },
                        child: Card(
                          elevation: 4.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            verticalDirection: VerticalDirection.down,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3.0),
                                    child: Container(
                                        height: 80.0,
                                        width:
                                        MediaQuery.of(context).size.width,
                                        child: Stack(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 20.0),
                                              child: Container(
                                                height: 40.0,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                color: Colors.teal,
                                              ),
                                            ),
                                            Center(
                                              child: Container(
                                                height: 86.0,
                                                width: 86.0,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        doc.data['image Url']),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      75.0),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 8.0,
                                                      color: Colors.teal,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    doc.data["product Name"],
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3.0,
                                  ),
                                  Text(
                                    doc.data["Urdu Name"],
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.teal,
                                    ),
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(left: 20.0),
                                        child: Text(
                                          "Rs",
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(left: 20.0),
                                        child: Text(
                                          doc.data["Product Price"],
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.teal,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        "/",
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        doc.data["Unit"],
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }),
      ),
    );
  }

  Future<bool> updateDialog(BuildContext context, selectedDoc) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update Data', style: TextStyle(fontSize: 15.0)),
            content: Container(
              height: 125.0,
              width: 150.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(hintText: 'Enter price'),
                    onChanged: (value) {
                      _price = value;
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Update'),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                  crudObj.updateItemData(selectedDoc, {
                    'Product Price': _price,
                  }).then((result) {
                    showSnackBar(context, "Item Updated Successfully");
                  }).catchError((e) {
                    print(e);
                  });
                },
              )
            ],
          );
        });
  }

  void showSnackBar(BuildContext context, String value) {
    var snackbar = SnackBar(content: Text(value));
    Scaffold.of(context).showSnackBar(snackbar);
  }
}
