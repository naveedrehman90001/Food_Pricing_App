import 'dart:io';
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class AddProducts extends StatefulWidget {
  @override
  _AddProductsState createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
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


  Future<String> uploadImg() async{
    StorageReference ref = FirebaseStorage.instance.ref().child(filename);
    StorageUploadTask uploadTask = ref.putFile(sampleImage);

    var downUrl = await(await uploadTask.onComplete).ref.getDownloadURL();
    var url = downUrl.toString();

    print('download url : $url');

    imageUrl = url;
    
    return url;
  }


  var _units = ['kg', 'doz', 'gram','each','lit'];

  var _categories = ['Vegetables', 'Fruits', 'Grains','Poultry','Oils', 'Sweets', 'Others'];
  var _currentItemSelected = 'kg';

  var _currentCategoryItemSelected = 'Vegetables';

  String _productName;
  String _urduName;
  var _productPrice;
  var unit;

  var category;

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
      Firestore.instance.collection('Add Products').add({
        'product Name': _productName,
        'Urdu Name': _urduName,
        'Product Price': _productPrice,
        'Unit': _currentItemSelected,
        'Category': _currentCategoryItemSelected,
        'image Url': imageUrl,
      }).then((value){
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed('/adminHomePage');
      print('added');
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
      appBar: AppBar(
        title: Text(
          "Add Product",
          style: TextStyle(
            fontFamily: 'Montserrat',
          ),
        ),
        backgroundColor: Colors.teal,
        elevation: 0.1,
      ),
      body: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
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
                            "Create Product*",
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
                            "مصنوعات تخلیق کریں",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 22.0,
                                color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.0),
              Container(
                width: double.infinity,
                child: Form(
                  key: formKey,
                  child: Padding(
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
                                "Product Name",
                                style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 18.0,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Text(
                                "پروڈکٹ کا نام",
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
                            hintText: 'Enter product name here....',
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
                          validator: (value) => value.isEmpty
                              ? "Product Name can't be Empty"
                              : null,
                          onSaved: (value) {
                            _productName = value;
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5.0, left: 4.0, right: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Urdu Name",
                                style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 18.0,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Text(
                                "اردو نام",
                                style: TextStyle(
                                    color: Colors.teal, fontSize: 17.0),
                              ),
                            ],
                          ),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          textDirection: TextDirection.rtl,
                          keyboardAppearance: Brightness.dark,
                          decoration: InputDecoration(
                            hintText: 'Enter Urdu name here....',
                            hintStyle: TextStyle(
                              fontSize: 17.0,
                              color: Colors.grey,
                            ),
                            contentPadding: EdgeInsets.all(10.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                          validator: (value) =>
                              value.isEmpty ? "Urdu name can't be Empty" : null,
                          onSaved: (value) {
                            _urduName = value;
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5.0, left: 4.0, right: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Product Price",
                                style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 18.0,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Text(
                                "پروڈکٹ کی قیمت",
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
                            hintText: 'Enter Product Price here....',
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
                          validator: (value) => value.isEmpty
                              ? "Product Price can't be Empty"
                              : null,
                          onSaved: (value) {
                            _productPrice = value;
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              height: 40.0,
                              width: 165.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                      width: 1.0, color: Colors.grey)),
                              padding: EdgeInsets.all(10.0),
                              child: DropdownButton<String>(
                                items: _units.map((String dropDownStringItem) {
                                  return DropdownMenuItem<String>(
                                    value: dropDownStringItem,
                                    child: Text(dropDownStringItem),
                                  );
                                }).toList(),
                                onChanged: (String newValueSelected) {
                                  setState(() {
                                    this._currentItemSelected =
                                        newValueSelected;
                                  });
                                },
                                value: _currentItemSelected,
                              ),
                            ),
                            SizedBox(
                              width: 2.0,
                            ),
                            Container(
                              height: 40.0,
                              width: 165.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                      width: 1.0, color: Colors.grey)),
                              padding: EdgeInsets.all(10.0),
                              child: DropdownButton<String>(
                                items: _categories
                                    .map((String dropDownStringItem) {
                                  return DropdownMenuItem<String>(
                                    value: dropDownStringItem,
                                    child: Text(dropDownStringItem),
                                  );
                                }).toList(),
                                onChanged: (String newValueSelected) {
                                  setState(() {
                                    this._currentCategoryItemSelected =
                                        newValueSelected;
                                  });
                                },
                                value: _currentCategoryItemSelected,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          height: 300.0,
                          width: double.infinity,
                          child: sampleImage == null
                              ? Text('Select an image')
                              : enableUpload(),
                        ),
                        SizedBox(height: 10.0),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 1.0, right: 1.0, bottom: 10.0),
                          child: Container(
                            height: 40.0,
                            child: Material(
                              borderRadius: BorderRadius.circular(5.0),
                              shadowColor: Colors.teal,
                              color: Colors.teal,
                              elevation: 7.0,
                              child: InkWell(
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
                                onTap: getImage,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 1.0, right: 1.0, bottom: 20.0),
                          child: Container(
                            height: 40.0,
                            child: Material(
                              borderRadius: BorderRadius.circular(5.0),
                              shadowColor: Colors.teal,
                              color: Colors.teal,
                              elevation: 7.0,
                              child: InkWell(
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
                                onTap: (){
                                  validateAndSubmit(context);
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget enableUpload() {
    return Container(
      child: Column(
        children: <Widget>[
          Image.file(
            sampleImage,
            height: 300.0,
            width: 300.0,
          ),
        ],
      ),
    );
  }
}
