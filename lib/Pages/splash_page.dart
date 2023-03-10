
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medico/Pages/home_page.dart';

import '../firebase_services/fetch_user_details.dart';
import 'Authentication_pages/signIn_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 4),() => {
      if(FirebaseAuth.instance.currentUser != null){
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen(),))
        // Get.off(const HomeScreen(),transition: Transition.leftToRight,duration: const Duration(seconds: 2))
        FetchUserDetail().fetchUser(context)
      }else{
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignInScreen(),))
        Get.off(const SignInScreen(),transition: Transition.leftToRight,duration: const Duration(seconds: 2))
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              const Spacer(),

              Container(
                width: 250,
                height: 250,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                  image: DecorationImage(image: AssetImage("assets/png/medico.png"),fit: BoxFit.cover),
                ),
              ),

              const Spacer(),

              DefaultTextStyle(style: TextStyle(color: Colors.black,fontSize: 25,fontFamily: GoogleFonts.aladin().fontFamily),
                  child: AnimatedTextKit(
                    isRepeatingAnimation: false,
                    animatedTexts: [
                      WavyAnimatedText("Medico",speed: const Duration(milliseconds: 500)),
                    ],
                  )
              ),

              const SizedBox(height: 20,)

              ],
          ),
        ),
    );
  }
}
