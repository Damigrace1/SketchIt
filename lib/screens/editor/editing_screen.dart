// import 'package:flutter/cupertino.dart';
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
import 'package:sketch_it/screens/widgets/custom_button.dart';
import 'package:stack_board/flutter_stack_board.dart';
import 'package:stack_board/stack_board_item.dart';
import 'package:stack_board/stack_items.dart';
// import 'package:stack_board/stack_board.dart';

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
  void initState() {
    // TODO: implement initState
  Get.put(EditorController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditorController>(builder: (EditorController controller) {
     // controller.drawingController.setPaintContent(Eraser());
      return  Scaffold(
        appBar: AppBar(
          toolbarHeight: 48.h,
          backgroundColor: kGrey,
          actions: [
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
            DrawingBoard(
              controller: controller.drawingController,
              background:
              controller.imageToBeEdited != null ? Image.file(
                controller.imageToBeEdited!
              ) : Container(
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


