import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medico/Pages/home_page.dart';
import 'package:medico/Pages/splash_page.dart';
import 'package:medico/firebase_services/fetch_user_details.dart';

class SignInProvider with ChangeNotifier {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;

  bool isGoogleLoading = false;

  signInWithGoogle(BuildContext context) async {
    toggleIsLoading();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      try {
        UserCredential result = await auth.signInWithCredential(credential);
        toggleIsLoading();
        if (result.user != null) {
          FetchUserDetail().fetchUser(context);
        }
      } on FirebaseAuthException catch (error) {
        toggleIsLoading();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }

      // UserCredential result = await auth.signInWithCredential(credential).then((value) => )
      // .catchError((error){
      //   toggleIsLoading();
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
      // });

    }
  }

  toggleIsLoading() {
    isGoogleLoading = !isGoogleLoading;
    notifyListeners();
  }
}
