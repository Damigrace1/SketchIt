import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:get/get.dart';

class EditorController extends GetxController{
 File?  imageToBeEdited;
 DrawingController drawingController  = DrawingController();
 Color canvasColor = Colors.white;

 void updateImage(File v){
  imageToBeEdited = v;
  update();
 }

 void setCanvasColor(Color v){
  canvasColor = v;
  update();
 }

}