import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class UserController extends GetxController {
  RxBool isloadingdoc = false.obs;
  RxString? name;

  final _usernamecontroller = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController get usernamecontroller => _usernamecontroller;

  final CollectionReference _username =
      FirebaseFirestore.instance.collection('username');

  createdoc(
    username,
  ) {
    isloadingdoc.value = true;

    _username.doc(auth.currentUser!.uid).set({
      'username': username,
    });
    isloadingdoc.value = false;
  }
}
