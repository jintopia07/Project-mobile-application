import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nat/src/Authentication/Models/user_details_google.dart';

class LoginController with ChangeNotifier {
  //object
  final _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleSignInAccount;
  UserDetails? userDetails;

  //fucntion for google login
  googleLogin() async {
    try {
      googleSignInAccount = await _googleSignIn.signIn();

      //inserting values to our user details model

      userDetails = UserDetails(
        displayName: googleSignInAccount!.displayName,
        email: googleSignInAccount!.email,
        photoURL: googleSignInAccount!.photoUrl,
      );

      //call
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  //logout
  logout() async {
    googleSignInAccount = await _googleSignIn.signOut();

    userDetails = null;
    notifyListeners();
  }
}
