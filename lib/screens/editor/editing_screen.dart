// import 'package:flutter/cupertino.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:flutter_drawing_board/paint_contents.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:sketch_it/controllers/editor_controller.dart';
import 'package:sketch_it/models/sketch_model.dart';
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
  const EditingScreen({Key? key, required this.projName, this.project}) : super(key: key);
final String projName;
final SketchModel? project;
  @override
  State<EditingScreen> createState() => _EditingScreenState();
}

double position = 0;

class _EditingScreenState extends State<EditingScreen> {
  List<dynamic>? oldProject;
  bool collabStarted = false;
  final edittingController = Get.find<EditorController>();
  @override
  void initState() {
edittingController.reloadCanvas();
if(widget.project != null){
  edittingController.loadCanvasData(widget.project!.data??[]);
}
    super.initState();

  }
bool saving = false;
  double sliderValue = 5;
  bool showTextEditor = false;
  StackTextItem? currentTextContent ;
  Color textColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditorController>(
      builder: (EditorController controller) {
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
                    InkWell(
                      splashColor: Colors.transparent,
                      child: Image.asset('assets/icons/export.png',width: 21.w,),
                    ),
                    SizedBox(
                      width: 14.w,
                    ),
                    CustomButton(
                      loading: saving,
                      text: 'Save',
                      onPressed: () async {
                        setState(() {
                          saving = true;
                        });
                       await  controller.saveSketch(widget.projName);
                        setState(() {
                          saving = false;
                        });
                      },
                      width: 65.w,
                      height: 28.h,
                    ),

                    PopupMenuButton<String>(
                      onSelected: (String value) {
                        // if(value == '1' ){
                        //   String? projId;
                        //   Get.dialog(
                        //       AlertDialog(
                        //         title: Text('Enter Project Id',style: TextStyle(fontWeight: FontWeight.w500),),
                        //         content: TextField(
                        //           onChanged: (v) => projId = v,
                        //         ),
                        //         actions: [
                        //           CustomButton(onPressed: () async {
                        //             if(projId == null) {
                        //               Get.snackbar('Collaboration Failed', 'You have to enter a project id');
                        //               return;
                        //             }
                        //             controller.drawingController.addListener((){
                        //               FirebaseService().saveToCollaborate('dami',
                        //                   controller.drawingController.getJsonList() +
                        //                       controller.stackBoardController.getAllData()
                        //                   , widget.projName);
                        //             });
                        //             controller.stackBoardController.addListener((){
                        //               FirebaseService().saveToCollaborate('dami',
                        //                   controller.drawingController.getJsonList() +
                        //                       controller.stackBoardController.getAllData()
                        //                   , widget.projName);
                        //             });
                        //             FirebaseService().listenToCollaborate(projId!);
                        //             Navigator.pop(context);
                        //           },text: 'Collaborate',),
                        //           SizedBox(height: 10.h,),
                        //           CustomButton(onPressed: (){
                        //             Navigator.pop(context);
                        //           },text: 'Cancel',filled: false,textColor: Colors.black,),
                        //         ],
                        //       )
                        //   );
                        // }
                         if(value == '2'){
                          setState(() {
                            collabStarted = true;
                          });
                          controller.drawingController.addListener((){
                            FirebaseService().saveToCollaborate(
                                controller.drawingController.getJsonList() +
                                    controller.stackBoardController.getAllData()
                                , 'dami@${widget.projName}');
                          });
                          controller.stackBoardController.addListener((){
                            FirebaseService().saveToCollaborate(
                                controller.drawingController.getJsonList() +
                                    controller.stackBoardController.getAllData(),
                                'dami@${widget.projName}');
                          });
                          FirebaseService().listenToCollaborate('dami@${widget.projName}');
                        }
                      },
                      itemBuilder: (BuildContext context) {
                        return [
                          // PopupMenuItem<String>(
                          //   value: '1',
                          //   child: Text('Join a project in collaboration'),
                          // ),
                          PopupMenuItem<String>(
                            value: '2',
                            child: Text('Expose project for Collaboration'),
                          )
                        ];

                      },
                    ),
                  ],
                  title: Text(
                    widget.projName,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              if(collabStarted)
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  color: Colors.green,
                 child: Text('Your Collaboration project id is dami@${widget.projName}'),
                ),
              Expanded(
                child: StackBoard(
                  customBuilder: (StackItem<StackItemContent> item) {

                    if (item is StackTextItem) {
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
                            : controller.hasGrid ? GridPaper(
                              child: Container(
                                  width: Get.width,
                                  height: Get.height,
                                  color: controller.canvasColor,
                                ) ,
                            ) : Container(
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
