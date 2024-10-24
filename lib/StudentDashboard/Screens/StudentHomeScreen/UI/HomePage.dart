import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../components/circularProgressIndicator.dart';
import '../../../../components/custom_Bottombar.dart';
import '../../../../func/connection_dialog_service.dart';
import '../../../../theme/background.dart';
import '../../../../theme/constants.dart';
import '../../../../theme/text_style.dart';
import '../../../../theme/theme_provider/theme_utils.dart';
import '../../../components/custom_Student_AppBar.dart';
import '../../../helpers/shared_pref_helper.dart';
import '../../../api/fetch_credit.dart';
import '../../../auth/model/login_model_class.dart';
import '../model/credit_model.dart';
import '../widget/custom_GridViewBuilder.dart';
import '../widget/custom_card.dart';

class StudentHomePage extends StatefulWidget {
  final int initialIndex;
  const StudentHomePage({super.key, required this.initialIndex});

  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  bool hasInternet = true;
  bool isLoading = true;
  bool isNoInternetBannerVisible = false;
  bool isDialogVisible = false;
  Color bannerColor = Colors.green;
  UserData? userData;
  CreditData? creditData;

  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _loadData();
    checkInternetConnection();
  }

  void checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    _updateConnectionState(connectivityResult);

    _connectivitySubscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        _updateConnectionState(result);
      },
    );
  }

  void _updateConnectionState(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      if (hasInternet) {
        setState(() {
          hasInternet = false;
          isNoInternetBannerVisible = true;
          bannerColor = Colors.redAccent;
        });

        if (!isDialogVisible) {
          DialogService.showNoInternetDialog(context);
          isDialogVisible = true;
        }
      }
    } else {
      if (!hasInternet) {
        setState(() {
          hasInternet = true;
          isNoInternetBannerVisible = true;
          bannerColor = Colors.green;
        });

        if (isDialogVisible && (Get.isDialogOpen ?? false)) {
          Get.back(result: null);
          isDialogVisible = false;
        }

        Timer(const Duration(seconds: 3), () {
          if (mounted) {
            setState(() {
              isNoInternetBannerVisible = false;
            });
          }
        });
      }
    }
  }

  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
    });

    try {
      String? studentId = await SharedPrefHelper.getStudentId();
      String? password = await SharedPrefHelper.getPassword();
      UserData? loadedUserData = await SharedPrefHelper.getStoredUserData();
      CreditData? loadedCreditData;

      if (studentId != null && password != null) {
        loadedCreditData = await fetchCreditData(studentId, password);
      }

      setState(() {
        userData = loadedUserData;
        creditData = loadedCreditData;
      });
    } catch (e) {
      setState(() {
        userData = null;
        creditData = null;
      });
    } finally {
      // Ensure loading is set to false whether the load is successful or not
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _onRefresh() async {
    await _loadData();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorMode = isDarkMode(context);

    return Scaffold(
      appBar: const CustomStudentAppBarMode(),
      body: _buildStudentHomePageContent(context, colorMode),
      bottomNavigationBar: CustomBottombar(initialIndex: widget.initialIndex),
    );
  }

  Widget _buildStudentHomePageContent(BuildContext context, bool colorMode) {
    return Stack(
      children: [
        BackgroundContainer(isDarkMode: colorMode),
        RefreshIndicator(
          onRefresh: _onRefresh,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Use a loader overlay when refreshing
                  if (isLoading && userData == null && creditData == null)
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 20,
                      child: const Center(
                        child: CircularProgressIndicatorWidget(),
                      ),
                    )
                  else
                    Column(
                      children: [
                        if (userData != null && creditData != null)
                          CustomCard(
                            userData: userData!,
                            creditData: creditData!,
                          )
                        else
                          buildPlaceholderCard(),
                        const SizedBox(height: 16),
                        const CustomGridView(),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
        if (isNoInternetBannerVisible) _buildInternetBanner(),
      ],
    );
  }

  Widget buildPlaceholderCard() => Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: cl_ThirdColor,
            width: 1.5,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
          borderRadius: BorderRadius.circular(rd_LargeRounded),
          color: cl_ItemBackgroundColor,
        ),
        child: Center(
          child: LottieBuilder.asset(
            'assets/icon/no_internet_icon.json',
            width: 200.w,
          ),
        ),
      );

  Widget _buildInternetBanner() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SizedBox(
        height: 36.h,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          color: bannerColor,
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0.0),
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
    );
  }
}
