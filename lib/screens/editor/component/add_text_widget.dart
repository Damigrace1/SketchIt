import 'dart:io';

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:flutter_drawing_board/paint_contents.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sketch_it/controllers/editor_controller.dart';
import 'package:sketch_it/screens/editor/component/tool_bar.dart';
import 'package:sketch_it/screens/widgets/custom_button.dart';
import 'package:sketch_it/utils/colors.dart';
import 'package:stack_board/flutter_stack_board.dart';
import 'package:stack_board/stack_items.dart';

class AddTextWidget extends StatefulWidget {
  const AddTextWidget({Key? key, required this.controller}) : super(key: key);
  final StackBoardController controller;
  @override
  State<AddTextWidget> createState() => _AddTextWidgetState();
}

class _AddTextWidgetState extends State<AddTextWidget> {
  String text = '';
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
      backgroundColor: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            autofocus: true,
            onChanged: (v){
              text = v;
            },
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                hintText: 'New Text'
            ),
            style: TextStyle(
                fontSize: 40.sp ,
                color: textColor
            ),

          ),
          SizedBox(height: 12.h,),
          SizedBox(
            child: ColorPicker(
              padding: EdgeInsets.zero,
              pickersEnabled: const <ColorPickerType, bool>{
                ColorPickerType.both: true,
                ColorPickerType.primary: false,
                ColorPickerType.accent: false,
                ColorPickerType.bw: false,
                ColorPickerType.custom: false,
                ColorPickerType.wheel: false,
              },
              enableShadesSelection: false,
              color: textColor,
              onColorChanged: (Color color) async {
                textColor = color;
                setState(() {
                });

                // await cardcustomcontroller.setColor(color);
              },
              spacing: 15.w,
              width: 40,
              height: 40,
              borderRadius: 16,
            ),
          ),
          CustomButton(onPressed: (){
            Navigator.pop(context);
            widget.controller.addItem(
                StackTextItem(
                  size: const Size(200, 100),
                  content: TextItemContent(data:text ,style: TextStyle(color: textColor)),
                )
            );
          },text: 'Add Text',)
        ],
      ),
    );
  }
}