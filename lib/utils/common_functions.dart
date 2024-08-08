import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showCustomMenu(BuildContext context, Offset tapPosition,
List<PopupMenuEntry<int>> items
    ) {
  final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;


  showMenu(
    color: Colors.transparent,
    shadowColor: Colors.transparent,

    context: context,

    position: RelativeRect.fromRect(
      Offset(52.w,tapPosition.dy  -40) & const Size(40, 40),
      Offset.zero & overlay.size,
    ),
    items:items,


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
