// import 'package:flutter/cupertino.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:sketch_it/controllers/editor_controller.dart';
import 'package:sketch_it/screens/widgets/custom_button.dart';
import 'package:sketch_it/service/firebase.dart';
import 'package:stack_board/flutter_stack_board.dart';
import 'package:stack_board/stack_board_item.dart';
import 'package:stack_board/stack_items.dart';

import '../../utils/colors.dart';
import '../../utils/common_functions.dart';
import 'component/tool_bar.dart';

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stack_board/flutter_stack_board.dart';
import 'package:stack_board/stack_board_item.dart';
import 'package:stack_board/stack_case.dart';
import 'package:stack_board/stack_items.dart';

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
    focusNode.addListener(() {
      print(focusNode.hasFocus);
    });
  }

  double sliderValue = 5;
  bool showTextEditor = false;
  StackTextItem? currentTextContent ;
  FocusScopeNode focusNode = FocusScopeNode();
  Color textColor = Colors.white;
  @override
  Widget build(BuildContext context) {;
    return GetBuilder<EditorController>(
      builder: (EditorController controller) {
        controller.stackBoardController.updateItem(StackTextItem(
          size: const Size(200, 100),
          content: TextItemContent(data: 'New 2',style: TextStyle(color: Colors.red)),
        ));
        // print(controller.drawingController.getJsonList());
        // FirebaseService().collaborate('dami', 'work1');
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            backgroundColor: kGrey,
          ),
          bottomSheet: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // AnimatedContainer(
              //     duration: Duration(milliseconds: 200),
              //     height: showTextEditor ? 40.h : 0,
              //     color:kGrey,
              //     width: Get.width,
              //     alignment: Alignment.center,
              //
              //   padding: EdgeInsets.symmetric(horizontal: 12.w),
              //   child: Visibility(
              //     visible: showTextEditor ,
              //     child: Row(children: [
              //       Text('Fontsize',style: TextStyle(fontWeight: FontWeight.bold),),
              //       SizedBox(width: 8.w,),
              //       Text(currentTextContent?.content?.style?.fontSize?.toString()??'',
              //         style: TextStyle(fontWeight: FontWeight.bold),),
              //     ],),
              //   ),
              //     ),
              AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: controller.showToolbar && !showTextEditor ? 40.h : 0,
                  color: kGrey,
                  width: Get.width,
                  alignment: Alignment.center,
                  // height: 40.h,
                  child: Visibility(
                    visible: controller.showToolbar && !showTextEditor ,
                    child: Slider(
                      value: sliderValue,
                      min: 1,
                      max: 50,
                      onChanged: (double value) {
                        setState(() {
                          sliderValue = value;
                        });
                        controller.drawingController
                            .setStyle(strokeWidth: value);
                      },
                    ),
                  )),
            ],
          ),
          body: Column(
            children: [
              AnimatedContainer(
                height: controller.showToolbar ? 48.h : 0,
                duration: Duration(milliseconds: 200),
                child: AppBar(
                  toolbarHeight: 48.h,
                  backgroundColor: kGrey,
                  actions: [
                    CustomButton(
                      text: 'Load',
                      onPressed: () => controller.loadSketch(),
                      width: 65.w,
                      height: 28.h,
                    ),
                    SizedBox(
                      width: 14.w,
                    ),
                    CustomButton(
                      text: 'Save',
                      onPressed: () => controller.saveSketch(),
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
              ),
              Expanded(
                child: StackBoard(

                  customBuilder: (StackItem<StackItemContent> item) {

                    if (item is StackTextItem) {
                      currentTextContent = item;
                      if(item.status == StackItemStatus.selected){
                          showTextEditor = true;
                          Future.delayed(Duration.zero,(){
                            controller.update();
                          });
                      }
                      if(item.status == StackItemStatus.idle){
                          showTextEditor = false;
                          Future.delayed(Duration.zero,(){
                            controller.update();
                          });

                      }

                      return StackTextCase(
                        item: item,
                      );
                    }

                    return const SizedBox.shrink();
                  },
                  background: Stack(
                    children: [
                      DrawingBoard(
                        controller: controller.drawingController,
                        background: controller.imageToBeEdited != null
                            ? Image.file(controller.imageToBeEdited!)
                            : Container(
                                width: Get.width,
                                height: Get.height,
                                color: controller.canvasColor,
                              ),
                      ),
                      Positioned(
                        top: 68.h,
                        left: 0,
                        child: ToolBar(),
                      ),
                      Positioned(
                        top: 24.h,
                        right: 28.w,
                        child: AnimatedContainer(
                          width: !controller.showToolbar ? 31.w : 0,
                          duration: Duration(milliseconds: 200),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            onTap: () {
                              controller.showToolbar = true;
                              controller.update();
                            },
                            child: Image.asset(
                              'assets/icons/minimize.png',
                              width: 31.w,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  controller: controller.stackBoardController,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
