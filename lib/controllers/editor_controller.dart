import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
// import 'package:flutter_drawing_board/paint_contents.dart';
import 'package:get/get.dart';
import 'package:stack_board/flutter_stack_board.dart';


import '../controller.dart/auth_controller.dart';


class EditorController extends GetxController {
  File? imageToBeEdited;
  late DrawingController drawingController;
  late StackBoardController textController;
  double strokeWidth = 9;
  Color canvasColor = Colors.white;
  bool showToolbar = true;
  int selectedToolId = 2;

  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final SignupController _signupController = Get.find<SignupController>();

  @override
  void onInit() {
    // TODO: implement onInit

 drawingController  = DrawingController();
 textController = StackBoardController();
    super.onInit();
  }

  void updateImage(File v) {
    imageToBeEdited = v;
    update();
  }

  void updateStrokeWidth(double v) {
    strokeWidth = v;
    drawingController.setStyle(strokeWidth: v);
    update();
  }

  void setCanvasColor(Color v) {
    canvasColor = v;
    update();
  }

  Future<void> saveSketch() async {
    final CollectionReference _users =
        FirebaseFirestore.instance.collection('users');
    try {
      final User? currentUser = _signupController.user;
      if (currentUser == null) {
        Get.snackbar('Error', 'Please login to save sketches');
        return;
      }
      final userId = currentUser.uid;
      final sketchData = drawingController.getJsonList();

      // await _users.doc(userId).set({
      //   // 'saved sketches': sketchData.toString(),
      // });
      await _users.doc(userId).set({
        'sketches': FieldValue.arrayUnion([
          {
            'timestamp': DateTime.now().toIso8601String(),
            'data': sketchData.toString(),
          }
        ])
      }, SetOptions(merge: true));

      Get.snackbar('Success', 'Sketch saved successfully');
    } catch (e) {
      print('$e');
      Get.snackbar('Error', 'Failed to save sketch: $e');
    }
  }

  Future<void> loadSketch() async {
    final CollectionReference _users =
        FirebaseFirestore.instance.collection('users');
    try {
      final User? currentUser = _signupController.user;
      if (currentUser == null) {
        Get.snackbar('Error', 'Please login to load sketches');
        return;
      }

      final userId = currentUser.uid;
      final docSnapshot = await _users.doc(userId).get();

      // Assuming you're using 'String David' as the document ID
      // final docSnapshot = await _users.doc('String David').get();

      if (!docSnapshot.exists) {
        Get.snackbar('Info', 'No saved sketches found');
        return;
      }

      final data = docSnapshot.data() as Map<String, dynamic>?;
      if (data == null || !data.containsKey('saved sketches')) {
        Get.snackbar('Info', 'No saved sketches found');
        return;
      }

      final sketchDataString = data['saved sketches'] as String;
      // Convert the string back to a list
      final sketchData = jsonDecode(sketchDataString) as List<dynamic>;

      drawingController.clear();
      // for (var paintContent in sketchData) {
      //   drawingController.addContent(
      //     Paint.fromJson(paintContent as  Map<String, dynamic>)
      //     );
      // }

      Get.snackbar('Success', 'Sketch loaded successfully');
    } catch (e) {
      print('Error loading sketch: $e');
      Get.snackbar('Error', 'Failed to load sketch: $e');
    }
  }
}
