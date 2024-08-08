// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sketch_it/controller.dart/auth_controller.dart';
import 'package:sketch_it/screens/auth/sign_in.dart';
import 'package:sketch_it/screens/home_screen.dart';
import 'package:sketch_it/screens/username/username.dart';
import 'package:sketch_it/screens/widgets/spacing.dart';
import 'package:sketch_it/utils/colors.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    final SignupController controller = Get.put(SignupController());
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Form(
                key: _formKey,
                child: SafeArea(
                    child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      addVerticalSpacing(20),
                      Image.asset(
                        'assets/images/logo app.png',
                        width: 120,
                        height: 30,
                      ),
                      addVerticalSpacing(29),
                      const Text(
                        'Sign Up',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Inter'),
                      ),
                      addVerticalSpacing(7),
                      const Text(
                        'Create an account to start creating',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Inter'),
                      ),
                      addVerticalSpacing(29),
                      // const Text(
                      //   'Email Address',
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //       fontSize: 14,
                      //       fontWeight: FontWeight.w600,
                      //       fontFamily: 'Inter'),
                      // ),
                      // addVerticalSpacing(4),
                      SizedBox(
                        height: 60,
                        child: TextFormField(
                          cursorHeight: 20,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: kblack,
                              fontFamily: 'Inter'),
                          controller: controller.emailController,
                          validator: controller.emailValidator,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.email,
                                color: kblack,
                              ),
                              hintText: 'Enter email',
                              hintStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: kblack,
                                  fontFamily: 'Inter'),
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: kgrey4, width: 1),
                                borderRadius: BorderRadius.circular(14),
                              )),
                        ),
                      ),
                      addVerticalSpacing(16),
                      SizedBox(
                        height: 60,
                        child: TextFormField(
                          cursorHeight: 20,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: kblack,
                              fontFamily: 'Inter'),
                          controller: controller.usernamecontroller,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.person,
                                color: kblack,
                              ),
                              hintText: 'Enter username',
                              hintStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: kblack,
                                  fontFamily: 'Inter'),
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: kgrey4, width: 1),
                                borderRadius: BorderRadius.circular(14),
                              )),
                        ),
                      ),
                      addVerticalSpacing(16),

                      SizedBox(
                        height: 60,
                        child: TextFormField(
                          obscureText: controller.passwordVisible.value,
                          controller: controller.passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          validator: controller.passwordValidator,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: kblack,
                              ),
                              focusColor: kblack,
                              hintText: 'Enter password',
                              hintStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: kblack,
                                  fontFamily: 'Inter'),
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: kgrey4, width: 1),
                                borderRadius: BorderRadius.circular(14),
                              )),
                        ),
                      ),
                      addVerticalSpacing(16),

                      SizedBox(
                        height: 60,
                        child: TextFormField(
                          obscureText: controller.passwordVisible.value,
                          controller: controller.repasswordController,
                          validator: controller.passwordValidator,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: kblack,
                              ),
                              hintText: 'Re-enter password',
                              hintStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: kblack,
                                  fontFamily: 'Inter'),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  controller.passwordVisible.value =
                                      !controller.passwordVisible.value;
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 7),
                                  child: controller.passwordVisible.value
                                      ? Image.asset(
                                          'assets/icons/hide.png',
                                        )
                                      : Image.asset(
                                          'assets/icons/view.png',
                                        ),
                                ),
                              ),
                              suffixIconConstraints: const BoxConstraints(
                                  maxHeight: 24,
                                  maxWidth: 24,
                                  minHeight: 24,
                                  minWidth: 24),
                              focusColor: kblack,
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: kgrey4, width: 1),
                                borderRadius: BorderRadius.circular(14),
                              )),
                        ),
                      ),
                      addVerticalSpacing(27),
                      GestureDetector(
                        onTap: () async {
                          try {
                            if (_formKey.currentState!.validate()) {
                              if (controller.passwordController.text ==
                                  controller.repasswordController.text) {
                                await controller.signUp(
                                  controller.emailController.text,
                                  controller.passwordController.text,
                                );

                                await controller.createUsername(
                                    controller.usernamecontroller.text);
                                Get.offAll(() => const HomeScreen());
                              } else {
                                return _showalertdialog(
                                    'Dear user,  passwords are not similar.',
                                    context);
                              }
                            }
                          } on FirebaseAuthException catch (e) {
                            var message = e.message;
                            _showalertdialog(message.toString(), context);
                            controller.isloadingemail.value = false;
                          }
                        },
                        child: Center(
                          child: Container(
                              height: 56,
                              width: 179,
                              decoration: BoxDecoration(
                                  color: kblack,
                                  borderRadius: BorderRadius.circular(16)),
                              child: Center(
                                  child:
                                      controller.isloadingemail.value == false
                                          ? const Text(
                                              'Sign Up',
                                              style: TextStyle(
                                                  color: kwhite,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16),
                                            )
                                          : const CircularProgressIndicator(
                                              color: kwhite,
                                            ))),
                        ),
                      ),
                      // addVerticalSpacing(20),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Image.asset(
                      //       'assets/images/line.png',
                      //       width: 84,
                      //     ),
                      //     addHorizontalSpacing(22),
                      //     Text(
                      //       'OR',
                      //       style: TextStyle(
                      //           color: kblack.withOpacity(0.4),
                      //           fontFamily: 'Inter',
                      //           fontWeight: FontWeight.w500,
                      //           fontSize: 14),
                      //     ),
                      //     addHorizontalSpacing(22),
                      //     Image.asset(
                      //       'assets/images/line.png',
                      //       width: 84,
                      //     ),
                      //   ],
                      // ),
                      // addVerticalSpacing(20),
                      // GestureDetector(
                      //   onTap: () async {
                      //     try {
                      //       await controller.googleLogin();
                      //       Get.offAll(() => const Username());
                      //     } on FirebaseAuthException catch (e) {
                      //       var message = e.message;
                      //       _showalertdialog(message.toString(), context);
                      //     }
                      //   },
                      //   child: Center(
                      //     child: Container(
                      //       height: 56,
                      //       width: 179,
                      //       decoration: BoxDecoration(
                      //           color: Colors.transparent,
                      //           border: Border.all(color: kgrey4),
                      //           borderRadius: BorderRadius.circular(16)),
                      //       child: Center(
                      //           child: controller.isloadinggoogle.value == false
                      //               ? Row(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.center,
                      //                   children: [
                      //                     Image.asset(
                      //                       'assets/images/gg.png',
                      //                       height: 25,
                      //                     ),
                      //                     addHorizontalSpacing(7),
                      //                     Image.asset(
                      //                       'assets/images/goog.png',
                      //                       height: 16,
                      //                     ),
                      //                   ],
                      //                 )
                      //               : const CircularProgressIndicator(
                      //                   color: kgrey4,
                      //                 )),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                )),
              ),
              Center(
                  child: RichText(
                text: TextSpan(
                    text: 'Already have an account? ',
                    style: const TextStyle(
                        color: kgrey5,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Inter'),
                    children: <TextSpan>[
                      TextSpan(
                          text: ' Log In',
                          style: const TextStyle(
                              color: kblack,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Inter'),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.to(() => const SignIn());
                            })
                    ]),
              )),
            ],
          ),
        ));
  }
}

_showalertdialog(String errorMsg, BuildContext context) {
  return Alert(
    context: context,
    type: AlertType.error,
    title: "An error occured",
    style: AlertStyle(
      descStyle: TextStyle(
          color: kblack.withOpacity(0.6),
          fontSize: 16,
          fontWeight: FontWeight.w500),
      titleStyle: const TextStyle(
          color: kblack, fontSize: 18, fontWeight: FontWeight.w600),
    ),
    desc: errorMsg,
    buttons: [
      DialogButton(
        color: kblack,
        onPressed: () => Navigator.pop(context),
        width: 120.w,
        child: const Text(
          "Click to fix",
          style: TextStyle(
              color: kwhite, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      )
    ],
  ).show();
}
