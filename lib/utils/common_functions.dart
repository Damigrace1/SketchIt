import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showCustomMenu(BuildContext context, Offset tapPosition) {
  final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

  showMenu(
    context: context,
    position: RelativeRect.fromRect(
      Offset(78.w,tapPosition.dy  -80) & const Size(40, 40),
      Offset.zero & overlay.size,
    ),
    items: [
       PopupMenuItem<int>(
        value: 0,
        child: Row(children: [
          Container(
            height: 40,width: 40,
            color: Colors.red,
          ),
          Container(
            height: 40,width: 40,
            color: Colors.red,
          ),
        ],),
      ),
      const PopupMenuItem<int>(
        value: 1,
        child: Text('Customize Card'),
      ),
      const PopupMenuItem<int>(
        value: 2,
        child: Text('Delete'),
      ),
    ],
  ).then((value) {
    if (value == 0) {
      // Handle Change Details
    } else if (value == 1) {
      // Handle Customize Card
    } else if (value == 2) {
      // Handle Delete
    }
  });
}