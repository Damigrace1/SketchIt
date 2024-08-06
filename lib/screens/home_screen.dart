import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sketch_it/screens/editor/editing_screen.dart';
import 'package:sketch_it/screens/profile.dart';
import 'package:sketch_it/utils/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 48.h,
        backgroundColor: kGrey,
        title: Text(
          'My Work',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push((context),
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
              icon: const Icon(Icons.person))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                Get.to(() => EditingScreen());
              },
              child: Container(
                width: 100.w,
                height: 85.h,
                decoration: BoxDecoration(
                    color: kGrey1,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 1.8,
                          color: Colors.black.withOpacity(0.25))
                    ],
                    borderRadius: BorderRadius.circular(6.r)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/add.png',
                      width: 27.w,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      'Create New',
                      style: TextStyle(
                          fontSize: 8.sp, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            Text(
              'Saved Works',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
            ),
          ],
        ),
      ),
    );
  }
}
