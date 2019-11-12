import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:kp_pricing_system/services/userManagement.dart';
import 'package:kp_pricing_system/shopkeeper/shopkeeperSignUp.dart';

class ShopkeeperSignIn extends StatefulWidget {
  @override
  _ShopkeeperSignInState createState() => _ShopkeeperSignInState();
}

class _ShopkeeperSignInState extends State<ShopkeeperSignIn> {
  bool isloading = false;
  final formkey = GlobalKey<FormState>();
  String _email;
  String _password;

  bool validateAndSave() {
    final form = formkey.currentState;
    form.save();
    if (form.validate()) {
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit() {
    if (validateAndSave()) {
      isloading = true;
      FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email,
          password: _password)
          .then((FirebaseUser user) {
        UserManagement().shopkeeperAuthorizationAccess(context);
      }).catchError((e) {
        print(e);
      });
    } else {
      print("error occured");
    }
    isloading = false;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "",
          style: TextStyle(
            fontFamily: 'Montserrat',
          ),
        ),
        backgroundColor: Colors.teal,
        elevation: 0.0,
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
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 80.0,
                          width: 80.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.0),
                              color: Colors.grey,
                              image: DecorationImage(
                                image: AssetImage('images/kps.jpg'),
                                fit: BoxFit.cover,
                              )),
                        ),
                        Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.0),
              Container(
                width: double.infinity,
                child: Form(
                  key: formkey,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 14.0, right: 14.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Shopkeeper Sign In",
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontFamily: 'Montserrat',
                                    color: Colors.black54,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5.0, left: 4.0, right: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Shopkeeper Email",
                                style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 18.0,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Text(
                                "دکاندار کا ای میل۔",
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
                          value.isEmpty ? "email can't be Empty" : null,
                          onSaved: (value) {
                            _email = value;
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
                                "Password",
                                style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 18.0,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Text(
                                "پاس ورڈ",
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
                            hintText: 'Enter your password here....',
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
                              ? "password can't be Empty"
                              : null,
                          onSaved: (value) {
                            _password = value;
                          },
                          obscureText: true,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(height: 25.0),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16.0, bottom: 20.0),
                          child: Container(
                            height: 40.0,
                            child: isloading ? CircularProgressIndicator() : Material(
                              borderRadius: BorderRadius.circular(5.0),
                              shadowColor: Colors.teal,
                              color: Colors.teal,
                              elevation: 7.0,
                              child: InkWell(
                                onTap: validateAndSubmit,
                                child: Center(
                                  child: Text(
                                    "SIGN IN",
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Don't have an account",
                              style: TextStyle(
                                fontSize: 19.0,
                              ),
                            ),
                            SizedBox(width: 5.0),
                            InkWell(
                              onTap: (){
                                Navigator.of(context).pushNamed('/shopkeeperSignUp');
                              },
                              child: Text("Register",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19.0,
                                  color: Colors.teal,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            )
                          ],
                        )
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
}
