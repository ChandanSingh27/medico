
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medico/Pages/formpage.dart';
import 'package:medico/Pages/home_page.dart';
import 'package:medico/provider/user_data_provider.dart';
import 'package:provider/provider.dart';

class FetchUserDetail{

  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  fetchUser(BuildContext context) async{
    DocumentSnapshot patientDocument = await fireStore.collection("patientProfile").doc(auth.currentUser!.uid.toString()).get();
    DocumentSnapshot doctorDocument = await fireStore.collection("doctorProfile").doc(auth.currentUser!.uid.toString()).get();
    DocumentSnapshot chemistDocument = await fireStore.collection("chemistProfile").doc(auth.currentUser!.uid.toString()).get();
    if(patientDocument.exists){
      Provider.of<UserDataProvider>(context,listen: false).assignData("patientProfile",auth.currentUser!.uid.toString());
      Get.off(const HomeScreen(),transition: Transition.leftToRight,duration: const Duration(seconds: 2));
      return;
    }else if(doctorDocument.exists){
      Provider.of<UserDataProvider>(context,listen: false).assignData("doctorProfile",auth.currentUser!.uid.toString());
      Get.off(const HomeScreen(),transition: Transition.leftToRight,duration: const Duration(seconds: 2));
      return;
    }else if(chemistDocument.exists){
      Provider.of<UserDataProvider>(context,listen: false).assignData("chemistProfile",auth.currentUser!.uid.toString());
      Get.off(const HomeScreen(),transition: Transition.leftToRight,duration: const Duration(seconds: 2));
      return;
    }else{
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FormScreen(),));
      Get.off(const FormScreen(),transition: Transition.leftToRight,duration: const Duration(seconds: 2));
      return;
    }
  }

}
