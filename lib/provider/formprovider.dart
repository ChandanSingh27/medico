import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';

import '../firebase_services/create_profile.dart';

class FormPageProvider with ChangeNotifier{

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emergencyContactNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController hospitalNameController = TextEditingController();
  final TextEditingController hospitalAddressController = TextEditingController();
  final TextEditingController medicalStoreAddressController = TextEditingController();
  final TextEditingController medicalStoreNameController = TextEditingController();


  final List<String> genderList = ["Male","Female","Others"];
  final List<String> roleList = ["Patient","Doctor","Chemist"];


  bool isImage = false;
  File imageFile = File("");
  String imageUrl = "";
  String userGender = "Male";
  String userRole = "Patient";

  bool isUpload = false;

  changeUpload (){
    isUpload = !isUpload;
    notifyListeners();
  }
  chooseGender(String gender){
    userGender = gender;
    notifyListeners();
  }

  chooseRole(String role){
    userRole = role;
    notifyListeners();
  }

  chooseImage() async{
    FilePickerResult? picker = await FilePicker.platform.pickFiles(type: FileType.image,allowMultiple: false);
    imageFile = File(picker!.files.single.path.toString());
    isImage = true;
    notifyListeners();
  }
}