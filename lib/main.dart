import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medico/Pages/splash_page.dart';
import 'package:medico/provider/HomeProvider.dart';
import 'package:medico/provider/PhoneLoginProvider.dart';
import 'package:medico/provider/sign_in_provider.dart';
import 'package:medico/provider/formprovider.dart';
import 'package:medico/provider/user_data_provider.dart';
import 'package:provider/provider.dart';
import 'Pages/Authentication_pages/phone_number.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => SignInProvider(),),
      ChangeNotifierProvider(create: (context) => HomeProvider(),),
      ChangeNotifierProvider(create: (context) => PhoneLoginProvider(),),
      ChangeNotifierProvider(create: (context) => UserDataProvider(),),
      ChangeNotifierProvider(create: (context) => FormPageProvider(),)
    ],
      child: const MedicoApp()));
}

class MedicoApp extends StatefulWidget {
  const MedicoApp({Key? key}) : super(key: key);

  @override
  State<MedicoApp> createState() => _MedicoAppState();
}

class _MedicoAppState extends State<MedicoApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        fontFamily: GoogleFonts.lato().fontFamily,
      ),
      home: const SplashScreen(),
    );
  }
}
