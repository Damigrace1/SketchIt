import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();
  final termsAccepted = false.obs;

  void toggleTerms(bool? value) => termsAccepted.value = value ?? false;

  void signUp() {
    // Implement sign up logic here
    print('Sign up pressed');
  }

  void signUpWithGoogle() {
    // Implement Google sign up here
    print('Google sign up pressed');
  }
}
