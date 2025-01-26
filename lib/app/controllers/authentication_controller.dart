import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:playground/app/resources/color_manager.dart';

import '../modules/widgets/loading.dart';

class AuthenticationController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String id = '';

  User? get user => _auth.currentUser;

  Future<bool> signUpWithEmail(String email, String password) async {
    showLoading();
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      hideLoading();
      return true;
    } catch (e) {
      hideLoading();
      getError(e.toString());
      return false;
    }
  }

  Future<bool> logInWithEmail(String email, String password) async {
    try {
      showLoading();
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      hideLoading();
      return true;
    } catch (e) {
      hideLoading();
      getError(e.toString());
      return false;
    }
  }

  Future<bool> resetPassword(String email) async {
    try {
      showLoading();
      await _auth.sendPasswordResetEmail(email: email);
      hideLoading();
      return true;
    } catch (e) {
      hideLoading();
      getError(e.toString());
      return false;
    }
  }

  Future<bool> signInWithPhone(String phone) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          getError(e.toString());
        },
        codeSent: (String verificationId, int? resendToken) {
          id = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      return true;
    } catch (e) {
      getError(e.toString());
      return false;
    }
  }

  Future<bool> authUserWithOTP(String otp) async {
    try {
      await _auth.signInWithCredential(
          PhoneAuthProvider.credential(verificationId: id, smsCode: otp));

      return true;
    } catch (e) {
      getError(e.toString());
      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      return true;
    } on FirebaseAuthException catch (e) {
      getError(e.toString());
      return false;
    }
  }

  Future<bool> deleteAccount() async {
    try {
      await _auth.currentUser!.delete();
      return true;
    } on FirebaseAuthException catch (e) {
      getError(e.toString());
      return false;
    }
  }

  Future<bool> updatePassword(String password) async {
    try {
      await _auth.currentUser!.updatePassword(password);
      return true;
    } on FirebaseAuthException catch (e) {
      getError(e.toString());
      return false;
    }
  }

  void getError(String error) {
    debugPrint('Error: $error');
    String message = '';
    if (error.contains('credential is incorrect')) {
      message = 'Incorrect credentials';
    } else if (error.contains('email-already-in-use')) {
      message = 'Email already in use';
    } else if (error.contains('invalid-email')) {
      message = 'Invalid email';
    } else if (error.contains('weak-password')) {
      message = 'Weak password';
    } else if (error.contains('user-not-found')) {
      message = 'User not found';
    } else if (error.contains('wrong-password')) {
      message = 'Wrong password';
    } else if (error.contains('user-disabled')) {
      message = 'User disabled';
    } else if (error.contains('A network error')) {
      message = 'Network error';
    } else if (error.contains('The Facebook login was not successful.')) {
      message = 'Facebook login failed';
    } else if (error.contains('Invalid phone number')) {
      message = 'Invalid phone number';
    } else if (error.contains(
        'The SMS verification code used to create the phone auth credential is invalid')) {
      message = 'Invalid OTP';
    } else if (error.contains('Invalid Email')) {
      message = 'Invalid Email';
    } else if (error
        .contains('The email address is already in use by another account.')) {
      message = 'Email already in use';
    } else if (error.contains(
        'The password is invalid or the user does not have a password.')) {
      message = 'Invalid password';
    } else if (error
        .contains('The user account has been disabled by an administrator.')) {
      message = 'User account disabled';
    } else if (error.contains(
        "com.google.android.gms.common.api.ApiException: 12500: , null, null")) {
      message = "No Google services found";
    } else if (error.contains("invalid-verification-code")) {
      message = "Invalid verification code";
    } else if (error.contains("The sms code has expired")) {
      message = "The sms code has expired";
    } else {
      message = "Unknown Error";
    }

    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: ColorManager.error,
      colorText: ColorManager.white,
    );
  }
}
