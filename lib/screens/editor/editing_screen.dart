import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:sketch_it/controllers/editor_controller.dart';
import 'package:sketch_it/screens/widgets/custom_button.dart';

import '../../utils/colors.dart';
import '../../utils/common_functions.dart';
import 'component/tool_bar.dart';

class EditingScreen extends StatefulWidget {
  const EditingScreen({Key? key}) : super(key: key);

  @override
  State<EditingScreen> createState() => _EditingScreenState();
}


double position = 0;


class _EditingScreenState extends State<EditingScreen> {


@override
  void initState() {
    // TODO: implement initState
  Get.put(EditorController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<EditorController>(builder: (EditorController controller) {
      return  Scaffold(
        appBar: AppBar(
          toolbarHeight: 48.h,
          backgroundColor: kGrey,
          actions: [
            Image.asset(
              'assets/icons/person.png',
              width: 20.w,
            ),
            SizedBox(
              width: 18.w,
            ),
            CustomButton(
              text: 'Save',
              onPressed: () {},
              width: 65.w,
              height: 28.h,
            ),
            SizedBox(
              width: 14.w,
            ),
          ],
          title: Text(
            'My Work',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        body: Stack(
          children: [
            Container(
              child:  DrawingBoard(
                controller: controller.drawingController,
                background:
                controller.imageToBeEdited != null ? Image.file(
                  controller.imageToBeEdited!
                ) : Container(
                  color: controller.canvasColor,
                ),
                // showDefaultActions: true,
                // showDefaultTools: true,
              ),
            ),
            Positioned(
              top: 68.h,
              left: 0,
              child: ToolBar(drawingController: controller.drawingController,),
            ),
            // Positioned(
            //     top: 95.h + position,
            //     left: 57.w,
            //     child: Image.asset('assets/icons/selected.png',width: 22.w,))
          ],
        ),
      );
    },);
  }
}


