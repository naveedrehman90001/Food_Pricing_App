import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kp_pricing_system/services/crud.dart';

class ShopProfile extends StatefulWidget {
  @override
  _ShopProfileState createState() => _ShopProfileState();
}

class _ShopProfileState extends State<ShopProfile> {
  var profile;

  crudMedthods crudObj = new crudMedthods();

  @override
  void initState() {
    crudObj.getShopProfileData().then((results) {
      setState(() {
        profile = results;
      });
    });
    super.initState();
  }

  navigateToDetail(DocumentSnapshot complaint) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailPage(
                  complaint: complaint,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        elevation: 0.0,
        backgroundColor: Colors.teal,
      ),
      body: _complaintList(),
    );
  }

  Widget _complaintList() {
    if (profile != null) {
      return StreamBuilder(
        stream: profile,
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            padding: EdgeInsets.all(5.0),
            itemBuilder: (context, i) {
              return Card(
                child: new ListTile(
                  leading:Image.network(
                        snapshot.data.documents[i].data['image Url']),

                  trailing: Icon(Icons.arrow_forward_ios),
                  title: Text(snapshot.data.documents[i].data['Name']),
                  subtitle: Text(snapshot.data.documents[i].data['Email']),
                  onTap: () => navigateToDetail(snapshot.data.documents[i]),
                  onLongPress: () {
                    crudObj.deleteData(snapshot.data.documents[i].documentID);
                  },
                ),
              );
            },
          );
        },
      );
    } else {
      return Text('Loading, Please wait..');
    }
  }
}

class DetailPage extends StatefulWidget {
  final DocumentSnapshot complaint;

  DetailPage({this.complaint});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.complaint.data['Name'],
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        child: Card(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              Container(
                height: 180.0,
                width: 180.0,
                child: Image.network(
                    widget.complaint.data['image Url']),
              ),

              SizedBox(height: 20.0,),
              Text(
                ' Name',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 17.0,
                    color: Colors.teal),
              ),
              SizedBox(height: 10.0,),
              Text(
                widget.complaint.data['Name'],
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 17.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Email',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 17.0,
                    color: Colors.teal),
              ),
              Text(
                widget.complaint.data['Email'],
                style: TextStyle(fontFamily: 'Montserrat', fontSize: 17.0),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
