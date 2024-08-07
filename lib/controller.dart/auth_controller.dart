import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:sketch_it/utils/validator.dart';

class SignupController extends GetxController {
  //SIGN UP
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _repasswordcontroller = TextEditingController();

  User? user;

  TextEditingController get emailController => _emailcontroller;
  TextEditingController get passwordController => _passwordcontroller;
  TextEditingController get repasswordController => _repasswordcontroller;
//SIGN IN
  final _signemailcontroller = TextEditingController();
  final _signpasswordcontroller = TextEditingController();

  TextEditingController get signemailController => _signemailcontroller;
  TextEditingController get signpasswordController => _signpasswordcontroller;

  FirebaseAuth auth = FirebaseAuth.instance;

  RxBool _passwordVisible = true.obs;

  set passwordVisible(RxBool val) {
    _passwordVisible.value = val.value;
  }

  RxBool isloadingemail = false.obs;
  RxBool isloadinggoogle = false.obs;

  String? Function(String? email) get emailValidator =>
      Validators.emailValidator;

  String? Function(String? password) get passwordValidator =>
      Validators.passwordValidator;

  RxBool get passwordVisible => _passwordVisible;

  Future googleLogin() async {
    isloadinggoogle.value = true;
    FirebaseAuth auth = FirebaseAuth.instance;

    final googlesignIn = GoogleSignIn();
    final googleUser = await googlesignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      final u = await auth.signInWithCredential(credential);
      user = u.user;
      isloadinggoogle.value = false;
    }
    isloadinggoogle.value = false;
  }

  Future signUp(String email, String password) async {
    isloadingemail.value = true;

    final u = await auth.createUserWithEmailAndPassword(email: email, password: password);
   user = u.user;
    isloadingemail.value = false;

    return true;
  }

  Future signIn(String email, String password) async {
    isloadingemail.value = true;
   final u =  await auth.signInWithEmailAndPassword(email: email, password: password);
   user = u.user;
    isloadingemail.value = false;
  }

  Future<bool> signOutFromGoogle() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  Future<void Function()?> logout() async {
    await auth.signOut();

    return null;
  }
}
