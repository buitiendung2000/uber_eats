// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../../constant/constant.dart';
import '../../../view/authScreen/mobileLoginScreen.dart';
import '../../../view/authScreen/otpScreen.dart';
import '../../../view/botoomNavigationBar/bottomNavigationBar.dart';
import '../../../view/signInLogicScreen/signInLogicScreen.dart';
import '../../../view/userRegistrationScreen/userRegistration.dart';
import '../../provider/authProvider/mobileAuthProvider.dart';
import '../pushNotificationSevices/pushNotificationServices.dart';

class MobileAuthServices {
   final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  static bool checkAuthentication(BuildContext context) {
    User? user = auth.currentUser;
    if (user == null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MobileLoginScreen()),
          (route) => false);
      return false;
    }
    checkUserRegistration(context: context);
    return true;
  }

  static receiveOTP(
      {required BuildContext context, required String mobileNo}) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: mobileNo,
        verificationCompleted: (PhoneAuthCredential credentials) {
          log(credentials.toString());
        },
        verificationFailed: (FirebaseAuthException exception) {
          log(exception.toString());
          throw Exception(exception);
        },
        codeSent: (String verificationID, int? resendToken) {
          context
              .read<MobileAuthProvider>()
              .updateVerificationID(verificationID);
          Navigator.push(
            context,
            PageTransition(
              child: const OTPScreen(),
              type: PageTransitionType.rightToLeft,
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationID) {},
      );
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  static verifyOTP({required BuildContext context, required String otp}) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: context.read<MobileAuthProvider>().verificationID!,
        smsCode: otp,
      );
      await auth.signInWithCredential(credential);
      Navigator.push(
        context,
        PageTransition(
          child: const SignInLogicScreen(),
          type: PageTransitionType.rightToLeft,
        ),
      );
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  static checkUserRegistration({required BuildContext context}) async {
    bool userIsRegistered = false;
    try {
      await firestore
          .collection('User')
          .where('userID', isEqualTo: auth.currentUser!.uid)
          .get()
          .then((value) {
        value.size > 0 ? userIsRegistered = true : userIsRegistered = false;
        log('User is Registered = $userIsRegistered');
        if (userIsRegistered) {
          PushNotificationServices.initializeFCM();
          Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                child: const BottomNavigationBarUberEats(),
                type: PageTransitionType.rightToLeft),
            (route) => false,
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                child: const UserRegistraionScreen(),
                type: PageTransitionType.rightToLeft),
            (route) => false,
          );
        }
      });
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
   static signOut(BuildContext context) {
    auth.signOut();
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) {
      return const SignInLogicScreen();
    }), (route) => false);
  }
  Future<User?> _signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      return null; // Người dùng hủy đăng nhập
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential = await _auth.signInWithCredential(credential);
    return userCredential.user;
  }
}