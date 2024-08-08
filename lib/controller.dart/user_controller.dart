import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ProfileController extends GetxController {
  RxBool isloadingdoc = false.obs;
  RxString? name = ''.obs;
  RxString? email = ''.obs;

  final _usernamecontroller = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController get usernamecontroller => _usernamecontroller;

  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchdetails();
  }

  Future fetchdetails() async {
    //userUid is the current auth user
    final user = auth.currentUser;

    final docSnapshot = await _users.doc(user?.uid).get();

    Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;

    name?.value = data!['username'];
    email?.value = user!.email.toString();

    return data;
  }
}
//   final CollectionReference _users =
//       FirebaseFirestore.instance.collection('users');

//   createdoc(
//     username,
//   ) {
//     isloadingdoc.value = true;

//     _users.doc(auth.currentUser!.uid).set({
//       'username': username,
//     });
//     isloadingdoc.value = false;
//   }
// }
