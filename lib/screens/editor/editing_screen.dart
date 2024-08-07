// import 'package:flutter/cupertino.dart';
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
  }

  double sliderValue = 5;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditorController>(
      builder: (EditorController controller) {
        print(controller.drawingController.getJsonList());

        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            backgroundColor: kGrey,
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
                      return StackTextCase(item: item,

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
                        // showDefaultActions: true,
                        // showDefaultTools: true,
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
                      Positioned(
                          bottom: 0,
                          child: AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              height: controller.showToolbar ? 40.h : 0,
                              color: kGrey,
                              width: Get.width,
                              alignment: Alignment.center,
                              // height: 40.h,
                              child: Visibility(
                                visible: controller.showToolbar ,
                                child: Slider(
                                  value: sliderValue,
                                  min: 1,
                                  max: 50,
                                  onChanged: (double value) {
                                    setState(() {
                                      sliderValue = value;
                                    });
                                    controller.drawingController.setStyle(
                                        strokeWidth: value
                                    );
                                  },

                                ),
                              )
                          )),
                      // Positioned(
                      //   left: 60.w,
                      //   child: Container(
                      //     width: Get.width - 60.w,
                      //     height: Get.height,
                      //     child: StackBoard(
                      //       controller: cont,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  controller: controller.textController,
                ),
              ),
              // Expanded(
              //   child: Stack(
              //     children: [
              //
              //       DrawingBoard(
              //         controller: controller.drawingController,
              //         background: controller.imageToBeEdited != null
              //             ? Image.file(controller.imageToBeEdited!)
              //             : Container(
              //                 width: Get.width,
              //                 height: Get.height,
              //                 color: controller.canvasColor,
              //               ),
              //         // showDefaultActions: true,
              //         // showDefaultTools: true,
              //       ),
              //       Positioned(
              //         top: 68.h,
              //         left: 0,
              //         child: ToolBar(),
              //       ),
              //         Positioned(
              //           top: 24.h,
              //           right: 28.w,
              //           child: AnimatedContainer(
              //             width: !controller.showToolbar ? 31.w : 0,
              //             duration: Duration(milliseconds: 200),
              //             child: InkWell(
              //               splashColor: Colors.transparent,
              //               onTap: () {
              //                 controller.showToolbar = true;
              //                 controller.update();
              //               },
              //               child: Image.asset(
              //                 'assets/icons/minimize.png',
              //                 width: 31.w,
              //               ),
              //             ),
              //           ),
              //         ),
              //       Positioned(
              //           bottom: 0,
              //           child: AnimatedContainer(
              //               duration: Duration(milliseconds: 200),
              //               height: controller.showToolbar ? 40.h : 0,
              //             color: kGrey,
              //             width: Get.width,
              //             alignment: Alignment.center,
              //            // height: 40.h,
              //             child: Visibility(
              //               visible: controller.showToolbar ,
              //               child: Slider(
              //                 value: sliderValue,
              //                 min: 1,
              //                 max: 50,
              //                 onChanged: (double value) {
              //                   setState(() {
              //                     sliderValue = value;
              //                   });
              //                   controller.drawingController.setStyle(
              //                     strokeWidth: value
              //                   );
              //                 },
              //
              //               ),
              //             )
              //           )),
              //       // Positioned(
              //       //   left: 60.w,
              //       //   child: Container(
              //       //     width: Get.width - 60.w,
              //       //     height: Get.height,
              //       //     child: StackBoard(
              //       //       controller: cont,
              //       //     ),
              //       //   ),
              //       // ),
              //     ],
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }
}
