import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:flutter_drawing_board/paint_contents.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sketch_it/screens/home_screen.dart';
import 'package:sketch_it/screens/signup_screen.dart';
import 'package:sketch_it/screens/widgets/custom_button.dart';
import 'package:sketch_it/utils/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // _addTestLine();
    //print(_drawingController.getJsonList());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(

        children: [
          Flexible(child: Image.asset('assets/images/pencil_tree.png')),
          Image.asset('assets/images/logo_row.png',width: 104.w,),
          SizedBox(height: 7.h,),
          Container(
            height: 240.h,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(13.r),
                  topLeft: Radius.circular(13.r),
                ),
                color: kGrey
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Start drawing new ideas and\nshare them with your friends',
                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                SizedBox(height: 21.h,),
                CustomButton(text: 'Sign Up', onPressed: (){},
                  width: 167.w,),
                SizedBox(height: 8.h,),
                CustomButton(text: 'Login', onPressed: (){
                  Get.offAll(()=>HomeScreen());
                },
                  fillColor: kGrey,
                  textColor: Colors.black,
                  width: 167.w,)
              ],
            ),
          )
        ],
      ),


    );
  }
}
