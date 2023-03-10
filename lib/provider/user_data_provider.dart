import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UserDataProvider with ChangeNotifier{
  var snapshot;
  bool dataLoaded = false;

  assignData(String collection,String uid) async {
    await FirebaseFirestore.instance.collection(collection).doc(uid).get().then((value) => {
      snapshot = value.data(),
      dataLoaded = true,
    });
    notifyListeners();
  }

}