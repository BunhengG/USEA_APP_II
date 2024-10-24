import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'package:useaapp_version_2/theme/constants.dart';

import '../../../func/connection_dialog_service.dart';
import '../../../theme/text_style.dart';
import 'widgets/custom_Appbar.dart';
import '../../../components/custom_Bottombar.dart';
import 'widgets/custom_Gridview.dart';
import 'widgets/custom_Slidebar.dart';
import 'widgets/custom_socialMedia.dart';

class HomeScreen extends StatefulWidget {
  final int initialIndex;
  final int currentIndex;
  const HomeScreen({
    super.key,
    this.initialIndex = 0,
    this.currentIndex = 0,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool hasInternet = true;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool isNoInternetBannerVisible = false;
  bool isDialogVisible = false;
  Color bannerColor = Colors.green;

  @override
  void initState() {
    super.initState();
    checkInternetConnection();
  }

  void checkInternetConnection() async {
    //? Check initial connection
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      hasInternet = connectivityResult != ConnectivityResult.none;
      isNoInternetBannerVisible = !hasInternet;
      bannerColor = hasInternet ? Colors.green : Colors.redAccent;
    });

    if (!hasInternet && !isDialogVisible) {
      // Show dialog when no internet on initial check
      DialogService.showNoInternetDialog(context);
      isDialogVisible = true;
    }

    //? Listen to connection changes
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        if (result == ConnectivityResult.none) {
          // Internet is lost
          if (hasInternet) {
            setState(() {
              hasInternet = false;
              isNoInternetBannerVisible = true;
              bannerColor = Colors.redAccent;
            });

            // Show the no internet dialog if it's not already visible
            if (!isDialogVisible) {
              DialogService.showNoInternetDialog(context);
              isDialogVisible = true;
            }
          }
        } else {
          // Internet is restored
          if (!hasInternet) {
            setState(() {
              hasInternet = true;
              isNoInternetBannerVisible = true;
              bannerColor = Colors.green;
            });

            // Close only the dialog, not the page
            if (isDialogVisible && (Get.isDialogOpen ?? false)) {
              Get.back(result: null);
              isDialogVisible = false;
            }

            // Hide the banner after a short delay
            Timer(const Duration(seconds: 3), () {
              if (mounted) {
                setState(() {
                  isNoInternetBannerVisible = false;
                });
              }
            });
          }
        }
      },
    );
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(),
      body: Stack(
        children: [
          // ! default
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: u_BackgroundScaffold,
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              children: const [
                SizedBox(height: 8.0),
                CustomSlidebar(),
                SizedBox(height: 8.0),
                CustomGridview(),
                SizedBox(height: 16.0),
                CustomSocialmedia(),
                SizedBox(height: 8.0),
              ],
            ),
          ),
          //? No Internet Banner, placed above the main content
          if (isNoInternetBannerVisible)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 36.h,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  color: bannerColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 0.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LottieBuilder.asset(
                        'assets/icon/no_internet_icon.json',
                        fit: BoxFit.cover,
                        height: 36.h,
                      ),
                      Text(
                        hasInternet
                            ? 'អ៊ីនធឺណិតបានត្រឡប់មកវិញ...'.tr
                            : 'គ្មានការតភ្ជាប់អ៊ីនធឺណិត...'.tr,
                        style: getTitleSmallTextStyle(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: CustomBottombar(initialIndex: widget.initialIndex),
    );
  }
}
