import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:medico/Pages/home_page.dart';
import 'package:medico/firebase_services/fetch_user_details.dart';
import 'package:medico/provider/formprovider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


//create profile of user code here...
//And Store the details of user in fireStore database code is also here...
class CreateProfile {

  createPatientProfile(BuildContext context)async{
    //root references
    Reference referenceStorage =  FirebaseStorage.instance.ref();
    //directory references
    Reference referenceImageFolder = referenceStorage.child("user_profile_photos");
    //Assign photo name
    Reference referenceOfImage = referenceImageFolder.child(FirebaseAuth.instance.currentUser!.uid);

    try{

      final prefs = await SharedPreferences.getInstance();
      //here the photo of the user store in firebase storage
      await referenceOfImage.putFile(Provider.of<FormPageProvider>(context,listen: false).imageFile);
      final provider = Provider.of<FormPageProvider>(context,listen: false);
      provider.imageUrl = await referenceOfImage.getDownloadURL();

      //here according to the role of user. User profile created  in database
      if(provider.userRole == "Patient"){

        await FirebaseFirestore.instance.collection("patientProfile").doc(FirebaseAuth.instance.currentUser!.uid.toString())
            .set(PatientProfile(FirebaseAuth.instance.currentUser!.uid.toString(),provider.imageUrl, provider.nameController.text.toString(), provider.phoneNumberController.text.toString(), provider.emergencyContactNumberController.text.toString(), provider.emailController.text.toString(), provider.addressController.text.toString(), provider.dobController.text.toString(), provider.userGender, provider.userRole,provider.aboutController.text.toString()).toJson());

        Future.delayed(const Duration(seconds: 3),() {
          // Navigator.popUntil(context, (route) => route.isFirst);
          // Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
          // Get.offAll(const HomeScreen(),transition: Transition.leftToRight,duration: const Duration(milliseconds: 500));
          FetchUserDetail().fetchUser(context);
        },);

      }else if(provider.userRole=="Doctor"){

        await FirebaseFirestore.instance.collection("doctorProfile").doc(FirebaseAuth.instance.currentUser!.uid.toString())
            .set(DoctorProfile(FirebaseAuth.instance.currentUser!.uid.toString(),provider.imageUrl, provider.nameController.text.toString(), provider.phoneNumberController.text.toString(), provider.emergencyContactNumberController.text.toString(), provider.emailController.text.toString(), provider.addressController.text.toString(), provider.dobController.text.toString(), provider.userGender, provider.userRole,provider.hospitalNameController.text.toString(),provider.hospitalAddressController.text.toString(),provider.aboutController.text.toString()).toJson());

        Future.delayed(const Duration(seconds: 3),() {
          // Navigator.popUntil(context, (route) => route.isFirst);
          // Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
          // Get.offAll(const HomeScreen(),transition: Transition.leftToRight,duration: const Duration(milliseconds: 500));
          FetchUserDetail().fetchUser(context);
        },);

      }else{

        await FirebaseFirestore.instance.collection("chemistProfile").doc(FirebaseAuth.instance.currentUser!.uid.toString())
            .set(ShopkeeperProfile(FirebaseAuth.instance.currentUser!.uid.toString(),provider.imageUrl, provider.nameController.text.toString(), provider.phoneNumberController.text.toString(), provider.emergencyContactNumberController.text.toString(), provider.emailController.text.toString(), provider.addressController.text.toString(), provider.dobController.text.toString(), provider.userGender, provider.userRole,provider.medicalStoreNameController.text.toString(),provider.medicalStoreAddressController.text.toString(),provider.aboutController.text.toString()).toJson());

        Future.delayed(const Duration(seconds: 3),() {
          // Navigator.popUntil(context, (route) => route.isFirst);
          // Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
          // Get.offAll(const HomeScreen(),transition: Transition.leftToRight,duration: const Duration(milliseconds: 500));
          FetchUserDetail().fetchUser(context);
        },);


      }

      showDialog(context: context,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset("assets/lottie/success.json",),
            ],
          ),
        ),);


    }catch(error){

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));

    }finally{

      Provider.of<FormPageProvider>(context,listen: false).changeUpload();

    }
  }

}

//define patient profile structure code...
class PatientProfile{
  String uid,imageUrl,name,phoneNumber,emergencyPhoneNumber,email,address,dob,gender,role,about;

  PatientProfile(
      this.uid,
      this.imageUrl,
      this.name,
      this.phoneNumber,
      this.emergencyPhoneNumber,
      this.email,
      this.address,
      this.dob,
      this.gender,
      this.role,
      this.about);

  Map<String,dynamic> toJson ()=>{
    "uid":uid,
    "imageUrl":imageUrl,
    "name":name,
    "phoneNumber":phoneNumber,
    "emergencyPhoneNumber":emergencyPhoneNumber,
    "email":email,
    "address":address,
    "dob":dob,
    "gender":gender,
    "role":role,
    "about":about
  };
}

//define doctor profile structure code...
class DoctorProfile{
  String uid,imageUrl,name,phoneNumber,emergencyPhoneNumber,email,address,dob,gender,role,hospitalName,hospitalAddress,about;

  DoctorProfile(
      this.uid,
      this.imageUrl,
      this.name,
      this.phoneNumber,
      this.emergencyPhoneNumber,
      this.email,
      this.address,
      this.dob,
      this.gender,
      this.role,
      this.hospitalName,
      this.hospitalAddress,
      this.about);

  Map<String,dynamic> toJson ()=>{
    "uid":uid,
    "imageUrl":imageUrl,
    "name":name,
    "phoneNumber":phoneNumber,
    "emergencyPhoneNumber":emergencyPhoneNumber,
    "email":email,
    "address":address,
    "dob":dob,
    "gender":gender,
    "role":role,
    "hospitalName":hospitalName,
    "hospitalAddress":hospitalName,
    "about":about
  };
}

//define medical store profile structure code...
class ShopkeeperProfile{
  String uid,imageUrl,name,phoneNumber,emergencyPhoneNumber,email,address,dob,gender,role,medicalStoreName,medicalStoreAddress,about;

  ShopkeeperProfile(
      this.uid,
      this.imageUrl,
      this.name,
      this.phoneNumber,
      this.emergencyPhoneNumber,
      this.email,
      this.address,
      this.dob,
      this.gender,
      this.role,
      this.medicalStoreName,
      this.medicalStoreAddress,
      this.about);

  Map<String,dynamic> toJson ()=>{
    "uid":uid,
    "imageUrl":imageUrl,
    "name":name,
    "phoneNumber":phoneNumber,
    "emergencyPhoneNumber":emergencyPhoneNumber,
    "email":email,
    "address":address,
    "dob":dob,
    "gender":gender,
    "role":role,
    "medicalStoreName":medicalStoreName,
    "medicalStoreAddress":medicalStoreAddress,
    "about":about
  };
}