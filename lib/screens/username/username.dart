// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';
// import 'package:sketch_it/controller.dart/user_controller.dart';
// import 'package:sketch_it/screens/home_screen.dart';
// import 'package:sketch_it/screens/widgets/spacing.dart';
// import 'package:sketch_it/utils/colors.dart';

// class Username extends StatelessWidget {
//   const Username({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final UserController controller = Get.put(UserController());

//     return Scaffold(
//       body: SafeArea(
//         child: Center(
//             child: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   'What should we call you?',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                       fontSize: 25,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Inter'),
//                 ),
//                 addVerticalSpacing(40),
//                 const Text(
//                   'Username',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Inter'),
//                 ),
//                 addVerticalSpacing(4),
//                 SizedBox(
//                   height: 48,
//                   child: TextFormField(
//                     cursorHeight: 20,
//                     style: const TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                         color: kblack,
//                         fontFamily: 'Inter'),
//                     controller: controller.usernamecontroller,
//                     decoration: InputDecoration(
//                         hintText: 'Enter username',
//                         hintStyle: const TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                             color: kgrey5,
//                             fontFamily: 'Inter'),
//                         border: OutlineInputBorder(
//                           borderSide: const BorderSide(color: kgrey4, width: 1),
//                           borderRadius: BorderRadius.circular(14),
//                         )),
//                   ),
//                 ),
//                 addVerticalSpacing(27),
//                 GestureDetector(
//                   onTap: () async {
//                     try {
//                       await controller.createdoc(
//                         controller.usernamecontroller.text,
//                       );
//                       Get.offAll(() => const HomeScreen());
//                     } on FirebaseAuthException catch (e) {
//                       var message = e.message;
//                       _showalertdialog(message.toString(), context);
//                       controller.isloadingdoc.value = false;
//                     }
//                   },
//                   child: Container(
//                       height: 56,
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                           color: kblack,
//                           borderRadius: BorderRadius.circular(16)),
//                       child: Center(
//                           child: controller.isloadingdoc.value == false
//                               ? const Text(
//                                   'Continue',
//                                   style: TextStyle(
//                                       color: kwhite,
//                                       fontFamily: 'Inter',
//                                       fontWeight: FontWeight.w700,
//                                       fontSize: 16),
//                                 )
//                               : const CircularProgressIndicator(
//                                   color: kwhite,
//                                 ))),
//                 ),
//               ]),
//         )),
//       ),
//     );
//   }

//   _showalertdialog(String errorMsg, BuildContext context) {
//     return Alert(
//       context: context,
//       type: AlertType.error,
//       title: "An error occured",
//       style: AlertStyle(
//         descStyle: TextStyle(
//             color: kblack.withOpacity(0.6),
//             fontSize: 16,
//             fontWeight: FontWeight.w500),
//         titleStyle: const TextStyle(
//             color: kblack, fontSize: 18, fontWeight: FontWeight.w600),
//       ),
//       desc: errorMsg,
//       buttons: [
//         DialogButton(
//           color: kblack,
//           onPressed: () => Navigator.pop(context),
//           width: 120.w,
//           child: const Text(
//             "Click to fix",
//             style: TextStyle(
//                 color: kwhite, fontSize: 16, fontWeight: FontWeight.w500),
//           ),
//         )
//       ],
//     ).show();
//   }
// }
