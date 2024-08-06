import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sketch_it/screens/splash_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _switchValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 60.h,
                      child: Icon(
                        Icons.person,
                        size: 80.h,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      '@john_doe2012',
                      style: TextStyle(fontSize: 12.h),
                    ),
                    Text(
                      'johndoe@gmail.com',
                      style: TextStyle(fontSize: 12.h),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10.h)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 40.h, vertical: 14.h),
                        child: const Text(
                          'Edit Profile',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Divider(
                thickness: 1.h,
                color: Colors.black,
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Pair Screen',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.h),
              ),
              Text(
                'Share your screen with fellow artist\nto collaborate',
                style: TextStyle(color: Colors.grey, fontSize: 15.h),
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                'Join Community',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.h),
              ),
              Text(
                'Join artist community for contexts, news and \ngigs etc',
                style: TextStyle(color: Colors.grey, fontSize: 15.h),
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                'Share ',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.h),
              ),
              Text(
                'Share the app  with friends',
                style: TextStyle(color: Colors.grey, fontSize: 15.h),
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Auto Update',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20.h),
                      ),
                      Text(
                        'Toggle the switch to\nauto update the app or not. ',
                        style: TextStyle(color: Colors.grey, fontSize: 15.h),
                      ),
                    ],
                  ),
                  CupertinoSwitch(
                    value: _switchValue,
                    onChanged: (bool value) {
                      setState(() {
                        _switchValue = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                'Premium',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.h),
              ),
              Text(
                'You can choose our paid plans\nto enjoy more benefits. ',
                style: TextStyle(color: Colors.grey, fontSize: 15.h),
              ),
              SizedBox(
                height: 15.h,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        (context),
                        MaterialPageRoute(
                            builder: (context) => SplashScreen()));
                  },
                  child: Text(
                    'Logout',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 20.h),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
