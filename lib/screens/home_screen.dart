import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sketch_it/utils/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 48.h,
        backgroundColor: kGrey,
        title: Text('My Work',style: TextStyle(fontWeight: FontWeight.w500),),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 30.h
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100.w,
              height: 85.h,
              decoration: BoxDecoration(
                color: kGrey1,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 1.8,
                    color: Colors.black.withOpacity(0.25)
                  )
                ],
                borderRadius: BorderRadius.circular(6.r)
              ),
            ),
            SizedBox(height: 24.h,),
            Text('Saved Works',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14.sp),),
          ],
        ),
      ),
    );
  }
}
