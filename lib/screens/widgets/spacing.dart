import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

addVerticalSpacing(double height) {
  return SizedBox(
    height: height.h,
  );
}

addHorizontalSpacing(double width) {
  return SizedBox(
    width: width.w,
  );
}
