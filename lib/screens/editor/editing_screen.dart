// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
// import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:sketch_it/screens/widgets/custom_button.dart';
import 'package:stack_board/flutter_stack_board.dart';
import 'package:stack_board/stack_board_item.dart';
import 'package:stack_board/stack_items.dart';
// import 'package:stack_board/stack_board.dart';

import '../../utils/colors.dart';
import '../../utils/common_functions.dart';

class EditingScreen extends StatefulWidget {
  const EditingScreen({Key? key}) : super(key: key);

  @override
  State<EditingScreen> createState() => _EditingScreenState();
}

class _EditingScreenState extends State<EditingScreen> {
  double position = 0;
  final DrawingController _drawingController = DrawingController();
  final StackBoardController _stackBoardController = StackBoardController();

  void _addTextToCanvas() {
    _stackBoardController.addItem(
      StackTextItem(
        size: const Size(200, 100),
        content: TextItemContent(data: '哈哈哈哈哈'),
      ),
    );
  }

  // void _addTextToCanvas([String text = '']) {
  //   final textStyle = TextStyle(
  //     color: Colors.black,
  //     fontSize: 20,
  //   );

  // _drawingController.addContent(
  //   DrawingContent(
  //     painter: TextPainter(
  //       text: TextSpan(
  //         text: text.isNotEmpty ? text : 'Your text here',
  //         style: textStyle,
  //       ),
  //       textDirection: TextDirection.ltr,
  //     ),
  //     position: Offset(100, 100), // You can adjust this position
  //   ),
  // );

  //   _stackBoardController.addItem(
  //     StackBoardItem(
  //       child: Text(
  //         text.isNotEmpty ? text : 'Your text here',
  //         style: textStyle,
  //       ),
  //       position: Offset(position, 100), // You can adjust this position
  //     ),
  //   );
  // }

  Future<void> _showTextInputDialog() async {
    String inputText = '';
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Text'),
          content: TextField(
            onChanged: (value) {
              inputText = value;
            },
            decoration: InputDecoration(hintText: "Enter your text"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
                _addTextToCanvas();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: StackBoard(
              controller: _stackBoardController,
              background: Container(
                  width: Get.width, height: Get.height, color: Colors.white),
              // showDefaultActions: true,
              // showDefaultTools: true,
            ),
          ),
          // Container(
          //   child: StackBoard(
          //     controller: _stackBoardController,
          //     background: Container(
          //         width: Get.width, height: Get.height, color: Colors.white),
          //     // showDefaultActions: true,
          //     // showDefaultTools: true,
          //   ),
          // ),
          Positioned(
            top: 68.h,
            left: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 19.h),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 1.8, color: Colors.black.withOpacity(0.25))
                  ],
                  borderRadius: BorderRadius.circular(8.r)),
              child: Column(
                children: [
                  InkWell(
                    onTapDown: (TapDownDetails details) {
                      final tapPosition = details.globalPosition;
                      setState(() {
                        position = 0;
                      });
                      showCustomMenu(context, tapPosition);
                    },
                    child: Image.asset(
                      'assets/toolbar/maximize.png',
                      width: 32.81.w,
                    ),
                  ),
                  SizedBox(
                    height: 32.69.h,
                  ),
                  InkWell(
                    onTapDown: (TapDownDetails details) {
                      final tapPosition = details.globalPosition;
                      setState(() {
                        position = 62.h;
                      });
                      showCustomMenu(context, tapPosition);
                    },
                    child: Image.asset(
                      'assets/toolbar/layer.png',
                      width: 30.62.w,
                    ),
                  ),
                  SizedBox(
                    height: 32.69.h,
                  ),
                  InkWell(
                    onTapDown: (TapDownDetails details) {
                      final tapPosition = details.globalPosition;
                      setState(() {
                        position = 125.h;
                      });
                      showCustomMenu(context, tapPosition);
                    },
                    child: Image.asset(
                      'assets/toolbar/dropper.png',
                      width: 33.w,
                    ),
                  ),
                  SizedBox(
                    height: 32.69.h,
                  ),
                  InkWell(
                    onTapDown: (TapDownDetails details) {
                      // _drawingController
                      // final tapPosition = details.globalPosition;
                      // setState(() {
                      //   position = 195.h;
                      // });
                      // showCustomMenu(context, tapPosition);
                    },
                    child: Image.asset(
                      'assets/toolbar/edit.png',
                      width: 33.w,
                    ),
                  ),
                  SizedBox(
                    height: 32.69.h,
                  ),
                  InkWell(
                    onTapDown: (TapDownDetails details) {
                      final tapPosition = details.globalPosition;
                      setState(() {
                        position = 260.h;
                      });
                      showCustomMenu(context, tapPosition);
                    },
                    child: Image.asset(
                      'assets/toolbar/more.png',
                      width: 27.w,
                    ),
                  ),
                  SizedBox(
                    height: 32.69.h,
                  ),
                  InkWell(
                    onTap: () {
                      _drawingController.redo();
                    },
                    child: Image.asset(
                      'assets/toolbar/redo.png',
                      width: 25.w,
                    ),
                  ),
                  SizedBox(
                    height: 32.69.h,
                  ),
                  InkWell(
                    onTap: () {
                      _drawingController.undo();
                    },
                    child: Image.asset(
                      'assets/toolbar/undo.png',
                      width: 25.w,
                    ),
                  ),
                  SizedBox(
                    height: 32.69.h,
                  ),
                  InkWell(
                    onTap: () {
                      // _addTextToCanvas();
                      _showTextInputDialog();
                    },
                    child: Image.asset(
                      'assets/icons/text.png', // Make sure you have this icon in your assets
                      width: 25.w,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              top: 95.h + position,
              left: 57.w,
              child: Image.asset(
                'assets/icons/selected.png',
                width: 22.w,
              ))
        ],
      ),
    );
  }
}
