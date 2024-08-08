import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sketch_it/screens/editor/editing_screen.dart';
import 'package:sketch_it/screens/profile.dart';
import 'package:sketch_it/screens/widgets/custom_button.dart';
import 'package:sketch_it/utils/colors.dart';

import '../controllers/editor_controller.dart';
import '../models/sketch_model.dart';
import '../service/firebase.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late EditorController editorController;
  @override
  void initState() {
    // TODO: implement initState
    editorController = Get.put(EditorController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
        Scaffold(
          appBar: AppBar(
            toolbarHeight: 48.h,
            backgroundColor: kGrey,
            title: const Text(
              'SketchIt',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            actions: [
              InkWell(
                onTap: (){
                  Get.to(()=>ProfileScreen());
                },
                child: Image.asset(
                  'assets/icons/person.png',
                  width: 20.w,
                ),
              ),
              SizedBox(
                width: 18.w,
              ),
              PopupMenuButton<String>(
                onSelected: (String value) {
                  if(value == '1' ){
                    String? projId;
                    Get.dialog(
                        AlertDialog(
                          title: Text('Enter Project Id',style: TextStyle(fontWeight: FontWeight.w500),),
                          content: TextField(
                            onChanged: (v) => projId = v,
                          ),
                          actions: [
                            CustomButton(onPressed: () async {
                              if(projId == null || !projId!.contains('@')) {
                                Get.snackbar('Collaboration Failed', 'Invalid or empty ID');
                                return;
                              }
                              FirebaseService().listenToCollaborate(projId!);
                              editorController.drawingController.addListener((){
                                FirebaseService().saveToCollaborate(
                                    editorController.drawingController.getJsonList() +
                                        editorController.stackBoardController.getAllData()
                                    , projId!);
                              });
                              editorController.stackBoardController.addListener((){
                                FirebaseService().saveToCollaborate(
                                    editorController.drawingController.getJsonList() +
                                        editorController.stackBoardController.getAllData()
                                    , projId!);
                              });

                              await Get.off(() => EditingScreen(projName: projId!.split('@')[1] ,));
                              setState(() {

                              });
                            },text: 'Collaborate',),
                            SizedBox(height: 10.h,),
                            CustomButton(onPressed: (){
                              Navigator.pop(context);
                            },text: 'Cancel',filled: false,textColor: Colors.black,),
                          ],
                        )
                    );
                  }

                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem<String>(
                      value: '1',
                      child: Text('Join a project in collaboration'),
                    ),
                  ];

                },
              ),
            ],
          ),
          body:   FutureBuilder(
            future: editorController.loadSketch(),
            builder: (BuildContext context, AsyncSnapshot<List<SketchModel>> savedProjects) {
              if(!savedProjects.hasData){
                return Center(child:  CircularProgressIndicator(),);
              }
              else if(savedProjects.data == []){
                return Column(
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        String? projName;
                        Get.dialog(
                            AlertDialog(
                              title: Text('Enter Project Name',style: TextStyle(fontWeight: FontWeight.w500),),
                              content: TextField(
                                onChanged: (v) => projName = v,
                              ),
                              actions: [
                                CustomButton(onPressed: () async {
                                  if(projName == null) {
                                    Get.snackbar('Project Creation Failed', 'You have to enter a project name');
                                    return;
                                  }
                                  await Get.off(() => EditingScreen(projName: projName! ,));
                                  setState(() {

                                  });
                                },text: 'Continue',),
                                SizedBox(height: 10.h,),
                                CustomButton(onPressed: (){
                                  Navigator.pop(context);
                                },text: 'Cancel',filled: false,textColor: Colors.black,),
                              ],
                            )
                        );

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
                    Text('You have no saved projects.'),
                  ],
                );
              }
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        String? projName;
                        Get.dialog(
                            AlertDialog(
                              title: Text('Enter Project Name',style: TextStyle(fontWeight: FontWeight.w500),),
                              content: TextField(
                                onChanged: (v) => projName = v,
                              ),
                              actions: [
                                CustomButton(onPressed: () async {
                                  if(projName == null) {
                                    Get.snackbar('Project Creation Failed', 'You have to enter a project name');
                                    return;
                                  }
                                  await Get.off(() => EditingScreen(projName: projName! ,));
                                  setState(() {

                                  });
                                },text: 'Continue',),
                                SizedBox(height: 10.h,),
                                CustomButton(onPressed: (){
                                  Navigator.pop(context);
                                },text: 'Cancel',filled: false,textColor: Colors.black,),
                              ],
                            )
                        );

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
                    SizedBox(
                      height: 24.h,
                    ),
                    Expanded(child: ListView.separated(itemBuilder: (context,index){
                      return ListTile(
                        onTap: () async {
                          await Get.to(() => EditingScreen(projName: savedProjects.data?[index].name??'' ,
                          project: savedProjects.data?[index] ,));
                          setState(() {

                          });
                        },
                        leading: Icon(CupertinoIcons.hand_draw_fill),
                        title: Text(savedProjects.data?[index].name??''),
                        subtitle: Text(savedProjects.data?[index].timestamp?.toDate().toString()??''),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        tileColor: kgrey4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r)
                        ),
                      );
                    },  itemCount: savedProjects.data!.length, separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 16.h,);
                    },
                    ))
                  ],
                ),
              );
            }, )
        );
  }
}
