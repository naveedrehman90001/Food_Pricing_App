import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class crudMedthods {
  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  getData() async {
    return await Firestore.instance.collection('Add Products').snapshots();
  }

  getComplaintData() async {
    return await Firestore.instance.collection('Complaint Box').snapshots();
  }

  getShopProfileData() async {
    return await Firestore.instance.collection('Shopkeeper data').snapshots();
  }

  deleteData(docId) {
    Firestore.instance
        .collection('Complaint Box')
        .document(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }

  deleteItemData(docId) {
    Firestore.instance
        .collection('Add Products')
        .document(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }

  getFruitsData() async {
    return await Firestore.instance
        .collection('Add Products')
        .where('Category', isEqualTo: 'Fruits')
        .snapshots();
  }

  getVegetablesData() async {
    return await Firestore.instance
        .collection('Add Products')
        .where('Category', isEqualTo: 'Vegetables')
        .snapshots();
  }

  getGrainsData() async {
    return await Firestore.instance
        .collection('Add Products')
        .where('Category', isEqualTo: 'Grains')
        .snapshots();
  }

  getPoultryData() async {
    return await Firestore.instance
        .collection('Add Products')
        .where('Category', isEqualTo: 'Poultry')
        .snapshots();
  }

  getOilsData() async {
    return await Firestore.instance
        .collection('Add Products')
        .where('Category', isEqualTo: 'Oils')
        .snapshots();
  }

  getSweetsData() async {
    return await Firestore.instance
        .collection('Add Products')
        .where('Category', isEqualTo: 'Sweets')
        .snapshots();
  }

  getOthersData() async {
    return await Firestore.instance
        .collection('Add Products')
        .where('Category', isEqualTo: 'Others')
        .snapshots();
  }

  updateItemData(selectedDoc, newValues) {
    Firestore.instance
        .collection('Add Products')
        .document(selectedDoc)
        .updateData(newValues)
        .catchError((e) {
      print(e);
    });
  }
}
