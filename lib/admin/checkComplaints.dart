import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kp_pricing_system/services/crud.dart';

class CheckComplaints extends StatefulWidget {
  @override
  _CheckComplaintsState createState() => _CheckComplaintsState();
}

class _CheckComplaintsState extends State<CheckComplaints> {
  var complaint;

  crudMedthods crudObj = new crudMedthods();

  @override
  void initState() {
    crudObj.getComplaintData().then((results) {
      setState(() {
        complaint = results;
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
          "Complaints",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        elevation: 0.0,
        backgroundColor: Colors.teal,
      ),
      body: _complaintList(),
    );
  }

  Widget _complaintList() {
    if (complaint != null) {
      return StreamBuilder(
        stream: complaint,
        builder: (context, snapshot){
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            padding: EdgeInsets.all(5.0),
            itemBuilder: (context, i) {
              return Card(
                child: new ListTile(
                  trailing: Icon(Icons.arrow_forward_ios),
                  title: Text(snapshot.data.documents[i].data['user Name']),
                  subtitle: Text(snapshot.data.documents[i].data['User Contact']),
                  onTap: () => navigateToDetail(snapshot.data.documents[i]),
                  onLongPress: (){
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
          widget.complaint.data['user Name'],
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'User Name',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 17.0,color: Colors.teal),
            ),
              Text(
                widget.complaint.data['user Name'],
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 17.0,
                ),
              ),

              SizedBox(height: 10.0,),
              Text(
                'User Contact',
                style: TextStyle(fontFamily: 'Montserrat', fontSize: 17.0,color: Colors.teal),
              ),
              Text(
                widget.complaint.data['User Contact'],
                style: TextStyle(fontFamily: 'Montserrat', fontSize: 17.0),
              ),

              SizedBox(height: 10.0,),
              Text(
                'User Address',
                style: TextStyle(fontFamily: 'Montserrat', fontSize: 17.0,color: Colors.teal),
              ),
              Text(
                widget.complaint.data['User Address'],
                style: TextStyle(fontFamily: 'Montserrat', fontSize: 17.0),
              ),

            SizedBox(height: 10.0,),
            Text(
              'Complaint Date',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 17.0,color: Colors.teal),
            ),
            Text(
              widget.complaint.data['Date'],
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 17.0),
            ),

              SizedBox(height: 20.0,),
            Text(
              'Complaint Details',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 17.0,color: Colors.teal),
            ),
              Text(
                widget.complaint.data['Complaint Details'],
                style: TextStyle(fontFamily: 'Montserrat', fontSize: 17.0),
              ),
          ],
        ),
            )),
      ),
    );
  }
}
