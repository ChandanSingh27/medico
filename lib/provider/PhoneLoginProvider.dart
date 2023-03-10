

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:medico/firebase_services/fetch_user_details.dart';

import '../Pages/Authentication_pages/verifyOtp.dart';


class PhoneLoginProvider with ChangeNotifier{

  String countryCode = "+91";
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isPhoneLoading = false;

  void changeCountryCode(code){
    countryCode = code;
    notifyListeners();
  }
  toggleIsLoading(){
    isPhoneLoading = !isPhoneLoading;
    notifyListeners();
  }

  loginWithPhoneNumber(BuildContext context,String phoneNumber){
    toggleIsLoading();
    String number = countryCode + phoneNumber;
    auth.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: (phoneAuthCredential) {

        },
        verificationFailed: (error) {
          toggleIsLoading();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
        },
        codeSent: (verificationId, forceResendingToken) {
          toggleIsLoading();
          // Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyOtpScreen(verificationId: verificationId,phoneNumber: number),));
          Get.to(VerifyOtpScreen(verificationId: verificationId,phoneNumber: number),transition: Transition.leftToRight,duration: const Duration(milliseconds: 500));
        },
        codeAutoRetrievalTimeout: (verificationId) {

        },
    ).then((value) => null).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
    },);

  }

  loginWithCredential(String verificationId,String smsCode,BuildContext context){
    toggleIsLoading();
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
    auth.signInWithCredential(credential).then((value) => {
      toggleIsLoading(),
      FetchUserDetail().fetchUser(context)
    })
        .catchError((error){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
      toggleIsLoading();
    });
  }

}