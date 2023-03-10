import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:medico/provider/PhoneLoginProvider.dart';
import 'package:medico/utils/rounded_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class VerifyOtpScreen extends StatefulWidget {
  final verificationId;
  final phoneNumber;
  const VerifyOtpScreen({Key? key,required this.verificationId,required this.phoneNumber}) : super(key: key);

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final faker = Faker();
  String smsCode = "";
  final TextEditingController otpController = TextEditingController();

  final _otpKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _otpKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20,),
                Text("Verification",style: TextStyle(fontFamily: GoogleFonts.abhayaLibre().fontFamily,fontSize: 20,color: Colors.black),textAlign: TextAlign.center,),
                const SizedBox(height: 10,),
                Lottie.asset("assets/lottie/verification_code.json",width: 250,height: 250),
                const SizedBox(height: 10,),
                Text("Verification Code",style: TextStyle(fontFamily: GoogleFonts.abhayaLibre().fontFamily,fontSize: 25,color: Colors.black,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                const SizedBox(height: 10,),
                Text(faker.lorem.sentences(2).toString(),style: TextStyle(fontFamily: GoogleFonts.abhayaLibre().fontFamily,fontSize: 18,color: Colors.black),textAlign: TextAlign.center,),
                const SizedBox(height: 20,),
                Text("We sent code to the ${widget.phoneNumber}",style: TextStyle(fontFamily: GoogleFonts.abhayaLibre().fontFamily,fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                const SizedBox(height: 20,),
                PinCodeTextField(appContext: context, length: 6, onChanged: (value) => smsCode=value,
                  keyboardType: TextInputType.number,
                  enablePinAutofill: true,
                  controller: otpController,
                  pinTheme: PinTheme(
                    activeColor: Colors.blue,
                    inactiveColor: Colors.black
                  ),
                  validator: (value) {
                    if(value!.isEmpty){
                      return "Otp fields can't be empty";
                    }
                    else{
                      return null;
                    }
                  },
                ),

              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Consumer<PhoneLoginProvider>(builder: (context, value, child) =>  RoundedButtonNoIcon(
          isLoading: value.isPhoneLoading,
          buttonName: "Verify",
          buttonColor: Colors.blue,
          callBack: () {
            if(_otpKey.currentState!.validate()){
              value.loginWithCredential(widget.verificationId, smsCode, context);
            }
          } ,),),
      ),
    );
  }
}
