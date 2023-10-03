import 'dart:async';
import 'dart:developer';

import 'package:blog_app/services/global.dart';
import 'package:blog_app/utils/constants.dart';
import 'package:blog_app/views/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Get.offAll(() => const HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Center(
          child: Text(
            "BLOG APP",
            style: GoogleFonts.allison(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25.sp,
            ),
          ),
        ),
      ),
    );
  }
}
