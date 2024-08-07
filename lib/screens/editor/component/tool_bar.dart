import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:flutter_drawing_board/paint_contents.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sketch_it/controllers/editor_controller.dart';
import 'package:sketch_it/screens/widgets/custom_button.dart';

import '../../../utils/common_functions.dart';
import '../editing_screen.dart';

class ToolBar extends StatefulWidget {
  const ToolBar({Key? key, }) : super(key: key);

  @override
  State<ToolBar> createState() => _ToolBarState();
}

class _ToolBarState extends State<ToolBar> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return GetBuilder<EditorController>(builder: (EditorController controller) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 19.h),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 1.8, color: Colors.black.withOpacity(0.25))
            ],
            borderRadius: BorderRadius.circular(8.r)),
        child:
        Column(
          children: [
            InkWell(
              onTapDown: (TapDownDetails details) {
                final tapPosition = details.globalPosition;
                setState(() {
                  position = 0;
                });
                showCustomMenu(context, tapPosition,
                    [PopupMenuItem<int>(
                      value: 0,
                      child: Text('Delete'),
                    ),]);
              },
              child: Image.asset(
                'assets/toolbar/maximize.png',
                width: 32.81.w,
              ),
            ),
            SizedBox(
              height: 32.69.h,
            ),
            InkWell(
              onTapDown: (TapDownDetails details) {
                final tapPosition = details.globalPosition;
                setState(() {
                  position = 62.h;
                });
                showCustomMenu(context, tapPosition,
                    [PopupMenuItem<int>(
                      value: 1,
                      child: Text('Delete'),
                    ),]);
              },
              child: Stack(
                children: [
                  Image.asset(
                    'assets/toolbar/layer.png',
                    width: 30.62.w,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 32.69.h,
            ),
            InkWell(
              onTapDown: (TapDownDetails details) {
                final tapPosition = details.globalPosition;
                setState(() {
                  position = 125.h;
                });
                showCustomMenu(context, tapPosition,
                    [PopupMenuItem<int>(
                      value: 2,
                      child: Text('Delete'),
                    ),]);
              },
              child: Image.asset(
                'assets/toolbar/dropper.png',
                width: 33.w,
              ),
            ),
            SizedBox(
              height: 32.69.h,
            ),
            InkWell(
              onTap:(){
                controller.drawingController.setPaintContent(Eraser(color: controller.canvasColor));

              },
              child: Image.asset(
                'assets/icons/eraser.png',
                width: 33.w,
              ),
            ),
            SizedBox(
              height: 32.69.h,
            ),
            InkWell(
              onTapDown: (TapDownDetails details) {
                final tapPosition = details.globalPosition;
                setState(() {
                  position = 0.h;
                });

                showCustomMenu(context, tapPosition,
                    [PopupMenuItem<int>(
                      value: 3,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CustomButton( onPressed: (){},
                                width: 44.w,height: 38.h,filled: false,child:
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/icons/T.png',width: 10.w,),
                                    Text('Text',style: TextStyle(fontSize: 6.sp,
                                        fontWeight: FontWeight.w500,color: Colors.black),)
                                  ],
                                ),),
                              SizedBox(width: 10.w,),
                              CustomButton(

                                child:
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/icons/import.png',width: 14.w,),
                                    Text('Import Image',style: TextStyle(fontSize: 6.sp,
                                        fontWeight: FontWeight.w500,color: Colors.black),)
                                  ],
                                ),
                                onPressed: ()async {

                                  final ImagePicker picker = ImagePicker();
                                  final XFile? image =
                                  await picker.pickImage(source: ImageSource.gallery);
                                  if (image == null) return;
                                  Get.find<EditorController>().updateImage(File(image.path));

                                },
                                width: 44.w,height: 38.h,filled: false,),
                              SizedBox(width: 10.w,),
                              CustomButton(text: 'text', onPressed: (){},
                                width: 44.w,height: 38.h,filled: false,),
                            ],
                          ),
                          SizedBox(height: 10.h,),
                          Row(
                            children: [
                              CustomButton(text: 'text', onPressed: (){},
                                width: 44.w,height: 38.h,filled: false,),
                              SizedBox(width: 10.w,),
                              CustomButton(text: 'text', onPressed: (){},
                                width: 44.w,height: 38.h,filled: false,),
                              SizedBox(width: 10.w,),
                              CustomButton(text: 'text', onPressed: (){},
                                width: 44.w,height: 38.h,filled: false,),
                            ],
                          ),
                        ],
                      ),
                    ),]);
              },
              child: Image.asset(
                'assets/toolbar/more.png',
                width: 27.w,
              ),
            ),
            SizedBox(
              height: 32.69.h,
            ),
            InkWell(
              onTap: (){
                controller.drawingController.redo();
              },
              child: Image.asset(
                'assets/toolbar/redo.png',
                width: 25.w,
              ),
            ),
            SizedBox(
              height: 32.69.h,
            ),
            InkWell(
              onTap: (){
                controller.drawingController.undo();
              },
              child: Image.asset(
                'assets/toolbar/undo.png',
                width: 25.w,
              ),
            ),

          ],
        ),
      );
    },);
  }
}