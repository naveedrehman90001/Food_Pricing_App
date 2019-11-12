import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kp_pricing_system/admin/adminDashboard.dart';
import 'package:kp_pricing_system/shopkeeper/shopkeeperDashboard.dart';

class UserManagement{

  bool isloading = false;

  storeNewShopkeeper(user,context){
    String role = "shopkeeper";
    Firestore.instance.collection('/users').add({
      'email': user.email,
      'uid': user.uid,
      'role': role,

    }).then((value){
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/shopkeeperProfile');
    })
        .catchError((e){
      print(e);
    });
  }

  storeNewAdmin(user,context){
    String role = "admin";
    Firestore.instance.collection('/users').add({
      'email': user.email,
      'uid': user.uid,
      'role': role,
    }).then((value){
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/adminHomePage');
    })
        .catchError((e){
      print(e);
    });
  }

  adminAuthorizationAccess(BuildContext context){
    isloading = true;
    FirebaseAuth.instance.currentUser().then((user){
      Firestore.instance.collection('/users')
          .where('uid' , isEqualTo: user.uid)
          .getDocuments()
          .then((docs){
        if(docs.documents[0].exists){
          if(docs.documents[0].data['role'] == 'admin'){
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context)=> AdminDashboard()));
          }else{
            showSnackBar(context, "you are not authorized to access this page");
          }
        }else{
          print("No Data found");
        }
      });
    });
    isloading = false;
  }

  shopkeeperAuthorizationAccess(BuildContext context){
    isloading = true;
    FirebaseAuth.instance.currentUser().then((user){
      Firestore.instance.collection('/users')
          .where('uid',isEqualTo: user.uid)
          .getDocuments()
          .then((docs){
        if(docs.documents[0].exists){
          if(docs.documents[0].data['role'] == 'shopkeeper'){
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context)=> ShopkeeperDashboard()));
          }else{
            showSnackBar(context, "you are not authorized to access this page");
          }
        }else{
          print("No Data found");
        }
        showSnackBar(context, "you are not authorized to access this page");

      });

    });
  }

  void showSnackBar(BuildContext context , String value){
    var snackbar = SnackBar(content: Text(value));
    Scaffold.of(context).showSnackBar(snackbar);
  }
}