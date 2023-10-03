import 'dart:convert';

import 'package:blog_app/services/global.dart';
import 'package:blog_app/utils/constants.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';

import '../controllers/main_application_controller.dart';
import '../models/blogs.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final mainApplicationController = Get.find<MainApplicationController>();

  var _connectionStatus = 'Unknown';
  late List<Blog> data;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
  }

  Future<void> _checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _connectionStatus = 'No internet connection';
        final List<dynamic> responseData =
            jsonDecode(Global.storageServices.getString("data")!);
        data = responseData.map((json) => Blog.fromJson(json)).toList();
      });
      print("poi");
    } else {
      setState(() {
        _connectionStatus = 'Connected';
        data = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          height: 100.h,
          width: 100.w,
          child: Column(
            children: [
              SizedBox(
                height: AppBar().preferredSize.height,
                width: 100.w,
                child: Row(
                  children: [
                    Icon(
                      Icons.menu,
                      color: Colors.black,
                      size: 20.sp,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      "Blogs",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _connectionStatus == 'No internet connection'
                    ? SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Top Picks
                            Text(
                              "Top Picks",
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 17.sp,
                              ),
                            ),
                            SizedBox(height: 2.5.w),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Constants.lightBorderColor,
                                        width: 2.5,
                                      ),
                                    ),
                                    padding: EdgeInsets.all(2.5.w),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 120,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Constants.lightBorderColor,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(4)),
                                          ),
                                          child: Image.network(
                                            data[0].imageUrl!,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
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
                                        Text(
                                          data[0].title!,
                                          maxLines: 2,
                                          overflow: TextOverflow.fade,
                                          style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 15.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5.w),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Constants.lightBorderColor,
                                        width: 2.5,
                                      ),
                                    ),
                                    padding: EdgeInsets.all(2.5.w),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 120,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Constants.lightBorderColor,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(4)),
                                          ),
                                          child: Image.network(
                                            data[3].imageUrl!,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
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
                                        Text(
                                          data[3].title!,
                                          maxLines: 2,
                                          overflow: TextOverflow.fade,
                                          style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 15.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.w),
                            Text(
                              "Other Articles",
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 17.sp,
                              ),
                            ),
                            SizedBox(height: 5.w),
                            SizedBox(
                              height: (80 * data.length) + (2.w * data.length),
                              width: double.infinity,
                              child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                        onTap: () {
                                          Get.to(() => DetailScreen(
                                                title: data[index].title!,
                                                imageUrl: data[index].imageUrl!,
                                              ));
                                        },
                                        child: newsTile(index, data[index]));
                                  }),
                            ),
                          ],
                        ),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Top Picks
                            Text(
                              "Top Picks",
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 17.sp,
                              ),
                            ),
                            SizedBox(height: 2.5.w),
                            FutureBuilder(
                                future: mainApplicationController
                                    .fetchDataFromApi(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    ); // Show a loading indicator while waiting for data
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    if (snapshot.data!.isNotEmpty) {
                                      return Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Constants
                                                      .lightBorderColor,
                                                  width: 2.5,
                                                ),
                                              ),
                                              padding: EdgeInsets.all(2.5.w),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 120,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Constants
                                                            .lightBorderColor,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  4)),
                                                    ),
                                                    child: Image.network(
                                                      snapshot
                                                          .data![0].imageUrl!,
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (context,
                                                          error, stackTrace) {
                                                        // Handle the case when the image is not loaded correctly
                                                        return Image.network(
                                                          'https://cdn.subspace.money/grow90_tracks/images/13bnR8NMTdyhCE4Dth87.png',
                                                          fit: BoxFit.cover,
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  Text(
                                                    snapshot.data![0].title!,
                                                    maxLines: 2,
                                                    overflow: TextOverflow.fade,
                                                    style: GoogleFonts.poppins(
                                                      color: Colors.black,
                                                      fontSize: 15.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 5.w),
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Constants
                                                      .lightBorderColor,
                                                  width: 2.5,
                                                ),
                                              ),
                                              padding: EdgeInsets.all(2.5.w),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 120,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Constants
                                                            .lightBorderColor,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  4)),
                                                    ),
                                                    child: Image.network(
                                                      snapshot
                                                          .data![3].imageUrl!,
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (context,
                                                          error, stackTrace) {
                                                        // Handle the case when the image is not loaded correctly
                                                        return Image.network(
                                                          'https://cdn.subspace.money/grow90_tracks/images/13bnR8NMTdyhCE4Dth87.png',
                                                          fit: BoxFit.cover,
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  Text(
                                                    snapshot.data![3].title!,
                                                    maxLines: 2,
                                                    overflow: TextOverflow.fade,
                                                    style: GoogleFonts.poppins(
                                                      color: Colors.black,
                                                      fontSize: 15.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return const Center(
                                        child: Text("No Blogs available!!"),
                                      );
                                    }
                                  }
                                }),
                            SizedBox(height: 5.w),
                            Text(
                              "Other Articles",
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 17.sp,
                              ),
                            ),
                            SizedBox(height: 5.w),
                            FutureBuilder(
                                future: mainApplicationController
                                    .fetchDataFromApi(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    ); // Show a loading indicator while waiting for data
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    if (snapshot.data!.isNotEmpty) {
                                      return SizedBox(
                                        height: (80 * snapshot.data!.length) +
                                            (2.w * snapshot.data!.length),
                                        width: double.infinity,
                                        child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: snapshot.data!.length,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  Get.to(() => DetailScreen(
                                                        title: snapshot
                                                            .data![index]
                                                            .title!,
                                                        imageUrl: snapshot
                                                            .data![index]
                                                            .imageUrl!,
                                                      ));
                                                },
                                                child: newsTile(index,
                                                    snapshot.data![index]),
                                              );
                                            }),
                                      );
                                    } else {
                                      return const Center(
                                        child: Text("No Blogs available!!"),
                                      );
                                    }
                                  }
                                }),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget newsTile(int index, Blog data) {
    return Hero(
      tag: index,
      child: Container(
        height: 80,
        width: 100.w,
        padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 1.w),
        margin: EdgeInsets.symmetric(vertical: 1.w),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Constants.lightBorderColor),
            borderRadius: const BorderRadius.all(Radius.circular(2))),
        child: Row(
          children: [
            SizedBox(
              width: 80 - 2.w,
              height: 80 - 2.w,
              child: Image.network(
                data.imageUrl!,
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
            SizedBox(width: 2.5.w),
            Expanded(
              child: Text(
                data.title!,
                maxLines: 3,
                overflow: TextOverflow.fade,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
