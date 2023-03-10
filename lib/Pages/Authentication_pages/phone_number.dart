import 'package:country_picker/country_picker.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:medico/provider/PhoneLoginProvider.dart';
import 'package:medico/utils/rounded_button.dart';
import 'package:provider/provider.dart';

class PhoneNumber extends StatefulWidget {
  const PhoneNumber({Key? key}) : super(key: key);

  @override
  State<PhoneNumber> createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  final faker = Faker();
  final TextEditingController phoneNumberController = TextEditingController();
  final _key = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios),color: Colors.black,),

                  const SizedBox(height: 10,),

                  Text("Enter your \nPhone Number",style: TextStyle(fontFamily: GoogleFonts.lato().fontFamily,fontWeight: FontWeight.bold,fontSize: 21),),

                  const SizedBox(height: 10,),

                  Lottie.asset("assets/lottie/enter_phone.json",width: 250,height: 250),

                  const SizedBox(height: 10,),

                  Text("${faker.lorem.sentences(3)}",style: TextStyle(fontSize: 15,fontFamily: GoogleFonts.lato().fontFamily),textAlign: TextAlign.start,),

                  const SizedBox(height: 30,),

                  Consumer<PhoneLoginProvider>(builder: (context, value, child) => Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Colors.black,width: 2)
                    ),
                    width: double.infinity,
                    child: Row(
                      children: [
                        TextButton(onPressed: (){
                          showCountryPicker(context: context, onSelect: (Country code) {
                            value.changeCountryCode("+${code.phoneCode.toString()}");
                          });
                        }, child: Text(value.countryCode,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontFamily: GoogleFonts.lato().fontFamily,color: Colors.black),)),
                        const SizedBox(height: 30,child: VerticalDivider(color: Colors.black,width: 2,thickness: 1,),),
                        const SizedBox(width: 15,),
                        SizedBox(
                          width: 250,height: 60,
                          child: TextFormField(
                            controller: phoneNumberController,
                            autofocus: false,
                            keyboardType: const TextInputType.numberWithOptions(),
                            style: TextStyle(fontFamily: GoogleFonts.lato().fontFamily,fontSize: 15,color: Colors.black),
                            decoration: InputDecoration(
                              hintText: "1234567890",
                              border: InputBorder.none,
                              hintStyle: TextStyle(fontSize: 15,fontFamily: GoogleFonts.lato().fontFamily),
                            ),
                            validator: (value) {
                              if(value!.isEmpty){
                                return "Phone Number field Can't empty...";
                              }
                              else{
                                return null;
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),),
                ],
              ),
            ),
          ),
        ),
      ),
      // bottomNavigationBar: ,
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Consumer<PhoneLoginProvider>(builder: (context, value, child) => RoundedButtonNoIcon(
          isLoading: value.isPhoneLoading,
          buttonColor: Colors.blueAccent,
          buttonName: "Login",
          callBack: (){
            if(_key.currentState!.validate()){
              value.loginWithPhoneNumber(context, phoneNumberController.text.toString());
            }
          },
        ),),
      ),
    );
  }
}
