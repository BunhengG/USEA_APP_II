import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:useaapp_version_2/theme/constants.dart';
import 'package:useaapp_version_2/utils/color_builder.dart';
import '../../../../theme/text_style.dart';
import '../../../../utils/theme_provider/theme_utils.dart';
import '../../ProfilePage/UI/ProfilePage.dart';
import '../../../auth/model/login_model_class.dart';
import '../model/credit_model.dart';

class CustomCard extends StatelessWidget {
  final UserData userData;
  final CreditData creditData;

  const CustomCard({
    super.key,
    required this.userData,
    required this.creditData,
  });

  @override
  Widget build(BuildContext context) {
    // Check current theme mode
    final colorMode = isDarkMode(context);
    double totalCredit = double.tryParse(creditData.totalCredit) ?? 0.0;
    double yourCredit = double.tryParse(creditData.yourCredit) ?? 0.0;
    double percentage = totalCredit > 0 ? (yourCredit / totalCredit) : 0.0;

    double cardHeight = MediaQuery.of(context).size.height * 0.3;
    double avatarSize = MediaQuery.of(context).size.width * 0.12;

    return Stack(
      children: [
        SizedBox(
          height: cardHeight,
          width: double.infinity,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(rd_MediumRounded),
                  color: context.colorDarkMode,
                  border: Border.all(
                    color: colorMode ? Colors.transparent : cl_ThirdColor,
                    width: 1.2,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProfilePage(),
                              ),
                            );
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: avatarSize,
                                height: avatarSize,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: context.titleAppBarColor,
                                    width: 3.w,
                                  ),
                                ),
                                child: ClipOval(
                                  child: AspectRatio(
                                    aspectRatio: 3 / 2,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.fitWidth,
                                          alignment: FractionalOffset.topCenter,
                                          image: (userData
                                                      .profilePic.isNotEmpty &&
                                                  userData.profilePic !=
                                                      'http://116.212.155.149:9999/usea/studentsimg/noimage.png')
                                              ? NetworkImage(
                                                  userData.profilePic)
                                              : const AssetImage(
                                                      'assets/img/avator_palceholder.png')
                                                  as ImageProvider,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5.0.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userData.nameKh,
                                    style:
                                        getTitleKhmerMoolPrimaryColorTextStyle()
                                            .copyWith(
                                                color: context.titleColor),
                                  ),
                                  Text(
                                    userData.nameEn.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: context.titleColor,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: ft_Eng,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(
                      height: MediaQuery.of(context).size.height *
                          0.12, // Responsive height for content
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                const WidgetSpan(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 2.0),
                                    child: Icon(
                                      Icons.circle,
                                      size: 18,
                                      color: Color(0xFFF4F6FF),
                                    ),
                                  ),
                                ),
                                TextSpan(
                                  text: '\tចំនួនក្រឌីតសរុប'.tr,
                                  style: getTitleSmallTextStyle()
                                      .copyWith(color: context.titleColor),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text.rich(
                            TextSpan(
                              children: [
                                const WidgetSpan(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 2.0),
                                    child: Icon(
                                      Icons.circle,
                                      size: 18,
                                      color: Color(0xFF4379F2),
                                    ),
                                  ),
                                ),
                                TextSpan(
                                  text: '\tចំនួនក្រឌីតបានបំពេញ'.tr,
                                  style: getTitleSmallTextStyle()
                                      .copyWith(color: context.titleColor),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: cardHeight * 0.3,
          right: 18.sp,
          child: CircularPercentIndicator(
            radius: 65.0,
            lineWidth: 18.0,
            percent: percentage,
            center: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${totalCredit.toInt()} / ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: cl_ThirdColor,
                    fontSize: 18.sp,
                  ),
                ),
                Text(
                  '${yourCredit.toInt()}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF4379F2),
                    fontSize: 16,
                  ),
                )
              ],
            ),
            circularStrokeCap: CircularStrokeCap.round,
            arcType: ArcType.FULL,
            arcBackgroundColor: const Color(0xFFF4F6FF),
            backgroundColor: const Color(0xFFF4F6FF),
            progressColor: const Color(0xFF4379F2),
          ),
        ),
      ],
    );
  }
}
