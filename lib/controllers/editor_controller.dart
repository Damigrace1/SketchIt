import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:flutter_drawing_board/paint_contents.dart';
// import 'package:flutter_drawing_board/paint_contents.dart';
import 'package:get/get.dart';
import 'package:sketch_it/models/sketch_model.dart';
import 'package:sketch_it/service/firebase.dart';
import 'package:stack_board/flutter_stack_board.dart';
import 'package:stack_board/stack_items.dart';


import '../controller.dart/auth_controller.dart';
import '../controller.dart/user_controller.dart';


class EditorController extends GetxController {
  File? imageToBeEdited;
  late DrawingController drawingController;
  late StackBoardController stackBoardController;
  double strokeWidth = 9;
  Color canvasColor = Colors.white;
  bool showToolbar = true;
  int selectedToolId = 2;
  bool hasGrid = false;

  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final SignupController _signupController = Get.find<SignupController>();

  @override
  void onInit() {
    // TODO: implement onInit

 drawingController  = DrawingController();
 stackBoardController = StackBoardController();
    super.onInit();
  }

  void reloadCanvas(){
    drawingController.clear();
    stackBoardController.clear();
  }

  loadCanvasData(List data){
    for(var dat in data){
      switch(dat['type']) {
        case 'StackTextItem':
          stackBoardController.addItem(StackTextItem.fromJson(dat));
        case 'SimpleLine' :
          drawingController.addContent(
            SimpleLine.fromJson(dat)
          );
        case 'SmoothLine' :
          drawingController.addContent(
              SmoothLine.fromJson(dat)
          );
        case 'Rectangle' :
          drawingController.addContent(
              Rectangle.fromJson(dat)
          );
        case 'StraightLine' :
          drawingController.addContent(
              StraightLine.fromJson(dat)
          );
        case 'Circle' :
          drawingController.addContent(
              Circle.fromJson(dat)
          );
        case 'Eraser' :
          drawingController.addContent(
              Eraser.fromJson(dat)
          );
      }
    }
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

  Future<void> saveSketch(String projName) async {

    try {
      final sketchData = drawingController.getJsonList() +
          stackBoardController.getAllData();
     await FirebaseService().saveSketchData( sketchData, projName);
      // await _users.doc(userId).set({
      //   // 'saved sketches': sketchData.toString(),
      // });
      // await _users.doc('dami').set({
      //   'sketches': FieldValue.arrayUnion([
      //     {
      //       'timestamp': DateTime.now().toIso8601String(),
      //       'data': sketchData.toString(),
      //     }
      //   ])
      // }, SetOptions(merge: true));
      //
      // Get.snackbar('Success', 'Sketch saved successfully');
    } catch (e) {
      print('$e');
      Get.snackbar('Error', 'Failed to save sketch: $e');
    }
  }

  Future<List <SketchModel> > loadSketch() async {
    try{
    final docs =   await FirebaseService().getSketchData();
    List <SketchModel> projects = docs.map((doc)=> SketchModel.fromJson(doc.data() as Map<String, dynamic>)).toList();
    return projects;
    } catch (e) {
      print('Error loading sketch: $e');
      Get.snackbar('Error', 'Failed to load sketch: $e');
      return [];
    }
  }
}
