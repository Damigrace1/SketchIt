import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:flutter_drawing_board/paint_contents.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sketch_it/screens/widgets/custom_button.dart';
import 'package:sketch_it/utils/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

 // static final DrawingController _drawingController = DrawingController();
 // ..addContents([StraightLine.fromJson({'type': 'lineTo', 'x': 121.0, 'y': 282.0})]);
 //  static const Map<String, dynamic> _testLine1 = <String, dynamic>{
 //    'type': 'StraightLine',
 //    'startPoint': <String, dynamic>{'dx': 68.94337550070736, 'dy': 62.05980083656557},
 //    'endPoint': <String, dynamic>{'dx': 277.1373386828114, 'dy': 277.32029957032194},
 //    'paint': <String, dynamic>{
 //      'blendMode': 3,
 //      'color': 4294198070,
 //      'filterQuality': 3,
 //      'invertColors': false,
 //      'isAntiAlias': false,
 //      'strokeCap': 1,
 //      'strokeJoin': 1,
 //      'strokeWidth': 4.0,
 //      'style': 1
 //    }
 //  };
 //
 // static const Map<String, dynamic> _testLine2 = <String, dynamic>{
 //    'type': 'StraightLine',
 //    'startPoint': <String, dynamic>{'dx': 106.35164817830423, 'dy': 255.9575653134524},
 //    'endPoint': <String, dynamic>{'dx': 292.76034659254094, 'dy': 92.125586665872},
 //    'paint': <String, dynamic>{
 //      'blendMode': 3,
 //      'color': 4294198070,
 //      'filterQuality': 3,
 //      'invertColors': false,
 //      'isAntiAlias': false,
 //      'strokeCap': 1,
 //      'strokeJoin': 1,
 //      'strokeWidth': 4.0,
 //      'style': 1
 //    }
 //  };
 // static Map<String, dynamic> p3 = {'type': 'SimpleLine',
 // 'path': {'fillType': 0, 'steps':
 //  [{'type': 'moveTo', 'x': 128.3125, 'y': 145.6875}, {'type': 'lineTo', 'x': 128.6875, 'y': 146.1875},
 // {'type': 'lineTo', 'x': 134.25, 'y': 152.8125}, {'type': 'lineTo', 'x': 135.0, 'y': 153.75},
 // {'type': 'lineTo', 'x': 135.875, 'y': 154.625}]},
 //
 //  'paint': {'blendMode': 3, 'color': 4294198070, 'filterQuality': 3,
 //  'invertColors': false, 'isAntiAlias': false, 'strokeCap': 1, 'strokeJoin': 1,
 //    'strokeWidth': 4.0, 'style': 1}};
 //
 //  void _addTestLine() {
 //    _drawingController.addContent(SimpleLine.fromJson(p3));
 //  //  _drawingController.addContents(<PaintContent>[StraightLine.fromJson(_testLine2)]);
 //  }
  @override
  Widget build(BuildContext context) {
   // _addTestLine();
    //print(_drawingController.getJsonList());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Image.asset('assets/images/pencil_tree.png'),
          Image.asset('assets/images/logo_row.png',width: 104.w,)
        ],
      ),
      bottomSheet: Container(
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
            CustomButton(text: 'Login', onPressed: (){},
              fillColor: kGrey,
              textColor: Colors.black,
              width: 167.w,)
          ],
        ),
      )
    );
  }
}



