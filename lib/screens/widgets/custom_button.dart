import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sketch_it/utils/colors.dart';


class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
        this.filled = true,
         this.text,
        required this.onPressed,
        this.fillColor,
        this.width,
        this.height,
        this.loading =  false,
        this.enabled = true, this.textColor, this.child}) : assert (child != null ||
  text != null);
  final bool filled;
   bool loading;
  final String? text;
  final Function() onPressed;
  final Color? fillColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final Widget? child;
  bool enabled;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height?? 49.h,
      child: ElevatedButton(
        onPressed:onPressed,

        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: filled
              ? fillColor?.withOpacity(enabled ? 1 : 0.4) ??
              Colors.black.withOpacity(enabled ? 1 : 0.4)
              : Colors.white,
          side: BorderSide(
              color:
                  Colors.black.withOpacity(enabled ? 1 : 0)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
        child:
        loading ? Container(
          height: 15.h,
          width: 15.h,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: kGrey1,
          ),
        ) :
        child?? Text(
          text!,
          style: TextStyle(color: textColor?.withOpacity(enabled ? 1 : 0.5) ??
          Colors.white.withOpacity(enabled ? 1 : 0.5)),
        ),
      ),
    );
  }
}
