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
import 'package:sketch_it/utils/colors.dart';

import '../../../utils/common_functions.dart';
import '../../widgets/tool_bar_item.dart';
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
      controller.drawingController.getJsonList();
      return AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric( vertical: 19.h),
        width: controller.showToolbar ? 60.w : 0,
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
            ToolbarItem(
              icon: 'assets/toolbar/maximize.png',
              iconWidth: 32.81.w,
              onTap: (){
                controller.showToolbar = false;
                controller.update();
              }, id: 0,
            ),
            ToolbarItem(
              icon: 'assets/toolbar/layer.png',
              iconWidth: 30.62.w,
              onTap: (){

              }, id: 1,
            ),
            ToolbarItem(
              showHighlight: true,
              icon: 'assets/toolbar/dropper.png',
              iconWidth: 33.w,
              hasMoreChildren: true,
              onTap: (){
                controller.drawingController.setPaintContent(SmoothLine());
              }, id: 2,
            ),
            ToolbarItem(
              icon: 'assets/icons/eraser.png',
              showHighlight: true,
              onTap: (){
                controller.drawingController.setPaintContent(Eraser(color: controller.canvasColor));

              }, id: 3,
            ),
            ToolbarItem(
              hasMoreChildren: true,
              icon: 'assets/toolbar/more.png',
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
              id: 4,
              iconWidth: 27.w,
            ),
            ToolbarItem(
              icon: 'assets/toolbar/redo.png',
              iconWidth: 25.w,
              onTap: (){
                controller.drawingController.redo();
              }, id: 5,
            ),
            ToolbarItem(
              icon: 'assets/toolbar/undo.png',
              iconWidth: 25.w,
              onTap: (){
                controller.drawingController.undo();
              }, id: 6,
            ),

          ],
        ),
      );
    },);
  }
}

