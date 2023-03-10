import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:medico/Pages/Authentication_pages/phone_number.dart';
import 'package:medico/provider/PhoneLoginProvider.dart';
import 'package:medico/provider/sign_in_provider.dart';
import 'package:medico/utils/rounded_button.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final faker = Faker();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20,),
                  Text("Welcome Back,",style: TextStyle(fontWeight:FontWeight.bold,fontFamily: GoogleFonts.abhayaLibre().fontFamily,fontSize: 25,),textAlign: TextAlign.left,),
                  const SizedBox(height: 20,),
                  Lottie.asset("assets/lottie/welcome.json",width: 300,height: 300),
                  Text("${faker.lorem.sentences(5)}",style: TextStyle(fontSize: 15,fontFamily: GoogleFonts.aBeeZee().fontFamily,color: Colors.black.withOpacity(0.7)),textAlign: TextAlign.center,),
                  const SizedBox(height: 20,),
                  Text("Select one of the options to be continue",style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontFamily: GoogleFonts.lato().fontFamily),),
                  const SizedBox(height: 25,),
                  Consumer<SignInProvider>(builder: (context, value, child) => RoundedButton(isLoading:value.isGoogleLoading,buttonName: "Sign in with Google", buttonColor: Colors.blue,buttonIcons: "assets/png/google_icon.png",isIcons: false,callBack: () => value.signInWithGoogle(context)),),
                  const SizedBox(height: 10,),
                  Consumer<PhoneLoginProvider>(builder: (context, value, child) => RoundedButton(isLoading:value.isPhoneLoading,buttonName: "Sign in with Phone", buttonColor: Colors.black,buttonIcons: CupertinoIcons.phone_fill,isIcons: true,callBack:()=> {Navigator.push(context, MaterialPageRoute(builder: (context) => const PhoneNumber(),))})),

                ],
              ),
            ),
          ) ,
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Text("By continuing you agree to TabSaving's \n Terms of Service and Privacy Policy",style: TextStyle(fontSize: 11,fontFamily: GoogleFonts.lato().fontFamily),textAlign: TextAlign.center,),
      ),
    );
  }
}
