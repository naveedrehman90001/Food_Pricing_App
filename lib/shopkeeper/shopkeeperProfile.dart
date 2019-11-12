import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ShopkeeperProfile extends StatefulWidget {
  @override
  _ShopkeeperProfileState createState() => _ShopkeeperProfileState();
}

class _ShopkeeperProfileState extends State<ShopkeeperProfile> {
  final formKey = GlobalKey<FormState>();

  String filename;
  File sampleImage;
  var imageUrl;

  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      sampleImage = tempImage;
      filename = basename(sampleImage.path);
    });
  }

  @override
  void initState() {
    imageUrl = url;
    super.initState();
  }

  Future<String> uploadImg() async {
    StorageReference ref = FirebaseStorage.instance.ref().child(filename);
    StorageUploadTask uploadTask = ref.putFile(sampleImage);

    var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    var url = downUrl.toString();

    print('download url : $url');

    imageUrl = url;

    return url;
  }

  String _name;
  String _email;
  var _contact;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit(BuildContext context) {
    if (validateAndSave()) {
      uploadImg();
      Firestore.instance.collection('Shopkeeper data').add({
        'Name': _name,
        'Email': _email,
        'Contact No:': _contact,
        'image Url': imageUrl,
      }).then((value) {
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed('/shopkeeperDashboard');
      }).catchError((e) {
        print(e);
      });
    } else {
      print("error is occured");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ClipPath(
            child: Container(
              color: Colors.teal.withOpacity(0.8),
            ),
            clipper: getClipper(),
          ),
          Positioned(
            width: 350.0,
            top: MediaQuery.of(context).size.height / 5,
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 150.0,
                    width: 150.0,
                    child: sampleImage == null
                        ? Text('Select an image')
                        : enableUpload(),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 8.0,
                          color: Colors.teal,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 18.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 70.0, right: 70.0, bottom: 8.0),
                    child: Container(
                      height: 35.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(5.0),
                        shadowColor: Colors.teal,
                        color: Colors.teal,
                        elevation: 7.0,
                        child: InkWell(
                          onTap: getImage,
                          child: Center(
                            child: Text(
                              "SELECT IMAGE",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0, right: 14.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5.0, left: 4.0, right: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Name",
                                style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 18.0,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Text(
                                "نام",
                                style: TextStyle(
                                    color: Colors.teal, fontSize: 17.0),
                              ),
                            ],
                          ),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          keyboardAppearance: Brightness.dark,
                          decoration: InputDecoration(
                            hintText: 'Enter your name here....',
                            hintStyle:
                                TextStyle(fontSize: 17.0, color: Colors.grey),
                            contentPadding: EdgeInsets.all(10.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                          validator: (value) =>
                              value.isEmpty ? "Name can't be Empty" : null,
                          onSaved: (value) {
                            _name = value;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5.0, left: 4.0, right: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Email",
                                style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 18.0,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Text(
                                "ای میل",
                                style: TextStyle(
                                    color: Colors.teal, fontSize: 17.0),
                              ),
                            ],
                          ),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          keyboardAppearance: Brightness.dark,
                          decoration: InputDecoration(
                            hintText: 'Enter your email here....',
                            hintStyle:
                                TextStyle(fontSize: 17.0, color: Colors.grey),
                            contentPadding: EdgeInsets.all(10.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                          validator: (value) =>
                              value.isEmpty ? "Email can't be Empty" : null,
                          onSaved: (value) {
                            _email = value;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5.0, left: 4.0, right: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Contact No",
                                style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 18.0,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Text(
                                "رابطہ نمبر",
                                style: TextStyle(
                                    color: Colors.teal, fontSize: 17.0),
                              ),
                            ],
                          ),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          keyboardAppearance: Brightness.dark,
                          decoration: InputDecoration(
                            hintText: 'Enter your Contact here....',
                            hintStyle:
                                TextStyle(fontSize: 17.0, color: Colors.grey),
                            contentPadding: EdgeInsets.all(10.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                          validator: (value) =>
                              value.isEmpty ? "Contact can't be Empty" : null,
                          onSaved: (value) {
                            _contact = value;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, bottom: 20.0),
                    child: Container(
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(5.0),
                        shadowColor: Colors.teal,
                        color: Colors.teal,
                        elevation: 7.0,
                        child: InkWell(
                          onTap: () {
                            validateAndSubmit(context);
                          },
                          child: Center(
                            child: Text(
                              "SUBMIT",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget enableUpload() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(75.0),
            ),
            child: Image.file(
              sampleImage,
              height: 150.0,
              width: 150.0,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
