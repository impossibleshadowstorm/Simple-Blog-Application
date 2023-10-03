import 'package:blog_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DetailScreen extends StatefulWidget {
  final String title;
  final String imageUrl;

  const DetailScreen({super.key, required this.title, required this.imageUrl});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: 100.h,
          width: 100.w,
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            children: [
              SizedBox(
                height: AppBar().preferredSize.height,
                width: 100.w,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 20.sp,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Expanded(
                      child: Text(
                        widget.title,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Column(
                children: [
                  Container(
                    height: 180,
                    width: 100.w,
                    child: Image.network(
                      widget.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        // Handle the case when the image is not loaded correctly
                        return Container(
                          color: Constants.primaryColor,
                          child: const Center(
                            child: Icon(
                              Icons.wifi_off,
                              color: Colors.red,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 2.5.h),
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
