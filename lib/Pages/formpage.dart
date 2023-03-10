import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medico/firebase_services/create_profile.dart';
import 'package:medico/provider/formprovider.dart';
import 'package:medico/utils/rounded_button.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {

  final _key = GlobalKey<FormState>();


  validate(){
    if(_key.currentState!.validate()){
      Provider.of<FormPageProvider>(context,listen: false).changeUpload();
      CreateProfile().createPatientProfile(context);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children:  [

                  const SizedBox(height: 20,),

                  InkWell(
                    onTap: (){
                      Provider.of<FormPageProvider>(context,listen: false).chooseImage();
                    },
                    child: Container(
                      alignment: Alignment.bottomRight,
                      height: 100,
                      width: 100,
                      decoration:  BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: Provider.of<FormPageProvider>(context).isImage ? Image.file(Provider.of<FormPageProvider>(context).imageFile,fit: BoxFit.fill,).image : const AssetImage("assets/png/man.png"),fit: BoxFit.cover,colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.color)),
                      ),
                      child: Provider.of<FormPageProvider>(context).isImage? const Icon(CupertinoIcons.check_mark_circled_solid,color: Colors.green,):const Icon(CupertinoIcons.add_circled_solid),
                    ),
                  ),

                  Text("Select the Profile Photo",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,fontFamily: GoogleFonts.abel().fontFamily)),

                  const SizedBox(height: 20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      const Text("Gender : "),

                      Consumer<FormPageProvider>(builder: (context, value, child) => CustomDropdownButton2(
                          hint: "Gender",
                          value: value.userGender,
                          dropdownItems: value.genderList,
                          onChanged: (values) => value.chooseGender(values.toString())),),

                      const SizedBox(width: 20,),

                      const Text("Role : "),

                      Consumer<FormPageProvider>(builder: (context, value, child) => CustomDropdownButton2(
                        hint: "Patient", value: value.userRole, dropdownItems: value.roleList, onChanged: (values) => value.chooseRole(values.toString()),),)
                    ],
                  ),

                  const SizedBox(height: 20,),

                  //taking name input
                  TextFormField(
                    controller: Provider.of<FormPageProvider>(context).nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Name"),
                      prefixIcon: Icon(CupertinoIcons.profile_circled),
                    ),
                    validator: (value) {
                      if(value!.isEmpty){
                        return "please enter your name";
                      }
                      return null;
                    },
                  ),

                  Provider.of<FormPageProvider>(context).userRole == "Patient" ? const SizedBox(height: 0,) : const SizedBox(height: 20,),

                  //here taking hospital or medical store name
                  Provider.of<FormPageProvider>(context).userRole=="Patient"? Container():
                  Provider.of<FormPageProvider>(context).userRole=="Doctor"?TextFormField(
                    controller: Provider.of<FormPageProvider>(context).hospitalNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Hospital Name"),
                      prefixIcon: Icon(CupertinoIcons.location_solid),
                    ),
                    validator: (value) {
                      if(value!.isEmpty){
                        return "please enter your Hospital Name";
                      }
                      return null;
                    },
                  ):TextFormField(
                    controller: Provider.of<FormPageProvider>(context).medicalStoreNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Medical Store Name"),
                      prefixIcon: Icon(CupertinoIcons.location_solid),
                    ),
                    validator: (value) {
                      if(value!.isEmpty){
                        return "please enter your Medical Store Name";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20,),

                  //taking phone number input
                  TextFormField(
                    controller: Provider.of<FormPageProvider>(context).phoneNumberController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Phone Number"),
                      prefixIcon: Icon(CupertinoIcons.phone),
                    ),
                    validator: (value) {
                      if(value!.isEmpty){
                        return "please enter your Phone number";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20,),

                  //Emergency Contact Information
                  TextFormField(
                    controller: Provider.of<FormPageProvider>(context).emergencyContactNumberController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Emergency Contact Number"),
                      prefixIcon: Icon(CupertinoIcons.phone),
                    ),
                    validator: (value) {
                      if(value!.isEmpty){
                        return "please enter your Emergency Contact Number";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20,),

                  //taking email address input
                  TextFormField(
                    controller: Provider.of<FormPageProvider>(context).emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Email"),
                      prefixIcon: Icon(CupertinoIcons.mail),
                    ),
                    validator: (value) {
                      if(value!.isEmpty){
                        return "please enter email Address";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20,),

                  //taking address input
                  TextFormField(
                    controller: Provider.of<FormPageProvider>(context).addressController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Address"),
                      prefixIcon: Icon(CupertinoIcons.location_solid),
                    ),
                    validator: (value) {
                      if(value!.isEmpty){
                        return "please enter your Address";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20,),

                  //here taking hospital or medical store address
                  Provider.of<FormPageProvider>(context).userRole=="Patient"?Container():
                  Provider.of<FormPageProvider>(context).userRole=="Doctor"?TextFormField(
                    controller: Provider.of<FormPageProvider>(context).hospitalAddressController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Hospital Address"),
                      prefixIcon: Icon(CupertinoIcons.location_solid),
                    ),
                    validator: (value) {
                      if(value!.isEmpty){
                        return "please enter your Hospital address";
                      }
                      return null;
                    },
                  ):TextFormField(
                    controller: Provider.of<FormPageProvider>(context).medicalStoreAddressController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Medical Store Address"),
                      prefixIcon: Icon(CupertinoIcons.location_solid),
                    ),
                    validator: (value) {
                      if(value!.isEmpty){
                        return "please enter your Medical Store address";
                      }
                      return null;
                    },
                  ),

                  Provider.of<FormPageProvider>(context).userRole == "Patient" ? const SizedBox(height: 0,) : const SizedBox(height: 20,),

                  //taking date of birth input
                  TextFormField(
                    controller: Provider.of<FormPageProvider>(context).dobController,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      label: const Text("Date of Birth"),
                      suffixIcon: IconButton(onPressed: ()async{
                        DateTime? dob = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(), firstDate: DateTime(1920), lastDate: DateTime(2100));
                        if(dob != null){
                          Provider.of<FormPageProvider>(context,listen: false).dobController.text = "${dob.day}/${dob.month}/${dob.year}";
                        }
                      }, icon: const Icon(CupertinoIcons.calendar_badge_plus)),
                    ),
                    validator: (value) {
                      if(value!.isEmpty){
                        return "please enter your Date of Birth";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20,),

                  TextFormField(
                    controller: Provider.of<FormPageProvider>(context).aboutController,
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      hintText: "Write About Yourself...",
                      border: OutlineInputBorder(),
                    )
                  ),

                  const SizedBox(height: 40,),

                  RoundedButtonNoIcon(isLoading: Provider.of<FormPageProvider>(context).isUpload,buttonColor: Colors.blue,buttonName: "Proceed",callBack: Provider.of<FormPageProvider>(context).isUpload? (){} :() => validate()

                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
