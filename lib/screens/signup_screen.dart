import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sketch_it/screens/editor/editing_screen.dart';
import 'package:sketch_it/screens/widgets/custom_button.dart';
import 'package:sketch_it/utils/colors.dart';

import '../controllers/signup_controller.dart';

class SignUpPage extends StatelessWidget {
  final SignUpController controller = Get.put(SignUpController());

  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 48.h,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/images/logo_row.png',
          ),
        ),
        leadingWidth: 144.h,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              const Text(
                'Create an account to \nstart creating',
                style: TextStyle(color: kGrey),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller.emailController,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  prefixIcon: Icon(
                    Icons.email,
                    color: kPrimary,
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: controller.usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.person, color: kPrimary),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: controller.passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock, color: kPrimary),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: controller.repeatPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Repeat Password',
                  prefixIcon: Icon(Icons.lock, color: kPrimary),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              Obx(() => CheckboxListTile(
                    activeColor: kPrimary,
                    title: const Text(
                      'I agree to the terms and conditions',
                      style: TextStyle(color: kGrey),
                    ),
                    value: controller.termsAccepted.value,
                    onChanged: controller.toggleTerms,
                    controlAffinity: ListTileControlAffinity.leading,
                  )),
              const SizedBox(height: 8),
              Center(
                child: CustomButton(
                  width: 200.w,
                  text: 'Submit',
                  onPressed: () {},
                ),
              ),
              const SizedBox(height: 8),
              const Row(
                children: [
                  Expanded(
                      child: Divider(
                    thickness: 1.0,
                    color: kGrey,
                    indent: 70,
                    // endIndent: 70,
                  )),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'OR',
                      style: TextStyle(color: kGrey),
                    ),
                  ),
                  Expanded(
                      child: Divider(
                    thickness: 1.0,
                    color: kGrey,
                    endIndent: 70,
                  )),
                ],
              ),
              const SizedBox(height: 16),
              Center(
                child: CustomButton(
                  fillColor: kGrey1,
                  textColor: kPrimary,
                  width: 200.w,
                  text: 'Google',
                  onPressed: () {
                    Get.offAll(EditingScreen());
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
