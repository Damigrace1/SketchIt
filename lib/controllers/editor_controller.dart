import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:get/get.dart';
import 'package:stack_board/flutter_stack_board.dart';

class EditorController extends GetxController{
 File?  imageToBeEdited;
 late DrawingController drawingController;
 double strokeWidth = 9;
 Color canvasColor = Colors.white;
 bool showToolbar = true;
 int selectedToolId = 2;
 late StackBoardController textController ;


@override
  void onInit() {
    // TODO: implement onInit
 drawingController  = DrawingController();
 textController = StackBoardController();
    super.onInit();
  }
 void updateImage(File v){
  imageToBeEdited = v;
  update();
 }
void updateStrokeWidth(double v){
 strokeWidth = v;
 drawingController.setStyle(strokeWidth: v);
 update();
}

 void setCanvasColor(Color v){
  canvasColor = v;
  update();
 }

}