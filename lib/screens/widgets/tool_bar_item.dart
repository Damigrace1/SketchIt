import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:stack_board/stack_items.dart';

import '../../controllers/editor_controller.dart';
import '../../utils/colors.dart';

class ToolbarItem extends StatelessWidget {
  const ToolbarItem({
    super.key, required this.id,  this.showHighlight = false,
    this.onTapDown,
    this.onTap, required this.icon,  this.iconWidth,
    this.hasMoreChildren = false
  });
  final int id;
  final bool showHighlight;
  final bool hasMoreChildren;
  final void Function()? onTap;
  final void Function(TapDownDetails)? onTapDown;
  final String icon;
  final double? iconWidth;
  static final controller = Get.find<EditorController>();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTapDown: (v){
        if(onTapDown != null){
          onTapDown!(v);}
        if(showHighlight){
          controller.selectedToolId = id;
          controller.update();
        }
        } ,
      onTap:(){
        if(showHighlight){
          controller.selectedToolId = id;
          controller.update();
        }

        if(onTap != null){
          onTap!();}

      },
      child: Stack(
        children: [
          Container(
            width: 60.w,
            height: 60.w,
            color:
            showHighlight ?
            controller.selectedToolId == id ?
            kPrimary.withOpacity(0.2) : null : null,
            child:
            Center(
              child: Image.asset(
                icon,
                width: iconWidth??26.w,
              ),
            ),

          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerRight,
              child: hasMoreChildren ? Image.asset(
                'assets/icons/selected.png',width: 9.w,
              ) : SizedBox(),
            ),
          )
        ],
      ),
    );
  }
}