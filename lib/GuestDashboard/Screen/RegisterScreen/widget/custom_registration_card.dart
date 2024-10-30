import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:useaapp_version_2/theme/color_builder.dart';
import '../../../../theme/constants.dart';
import '../../../../theme/text_style.dart';

class RegistrationCard extends StatelessWidget {
  final dynamic registration;

  const RegistrationCard({super.key, required this.registration});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.guestBGColor,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(rd_MediumRounded),
      ),
      elevation: 1.0,
      child: Padding(
        padding: const EdgeInsets.all(rd_MediumRounded),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              registration['title'],
              style: getTitleKhmerMoolPrimaryColorTextStyle(),
            ),
            SdH_SizeBox_S,
            const Divider(
              thickness: 1,
              color: cl_SecondaryColor,
            ),
            SdH_SizeBox_S,
            for (var detail in registration['details'] ?? [])
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildIconTextHeader(
                    'assets/icon/schedule.png',
                    detail['date_title'],
                    Colors.blueAccent,
                  ),
                  SdH_SizeBox_S,
                  for (var education in detail['education_list'] ?? [])
                    Container(
                      margin: const EdgeInsets.only(left: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildEducationHeader(
                            education['education_name'],
                            'assets/icon/active.json',
                          ),
                          SdH_SizeBox_S,
                          for (var item in education['list'] ?? [])
                            _buildEducationBody(item['info']),
                          SdH_SizeBox_S,
                        ],
                      ),
                    ),
                  SdH_SizeBox_S,
                  _buildIconTextHeader(
                    'assets/icon/clock.png',
                    detail['time_title'],
                    Colors.amber.withOpacity(0.2),
                  ),
                  SdH_SizeBox_S,
                  _buildEducationFooter(detail['time_detail']),
                ],
              ),
            SdH_SizeBox_S,
          ],
        ),
      ),
    );
  }

  Widget _buildIconTextHeader(String imageAsset, String title, Color bgColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 38,
          width: 38,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(rd_FullRounded),
            color: bgColor.withOpacity(0.2),
          ),
          child: Image.asset(imageAsset, fit: BoxFit.contain),
        ),
        SdW_SizeBox_S,
        Expanded(
          child: Text(
            title,
            style: getTitleSmallPrimaryColorTextStyle(),
            softWrap: true,
          ),
        ),
      ],
    );
  }

  Widget _buildEducationHeader(String title, String image) {
    return Row(
      children: [
        LottieBuilder.asset(image),
        SdW_SizeBox_S,
        Text(
          title,
          style: getBodyLargeTextStyle(),
        ),
      ],
    );
  }

  Widget _buildEducationBody(String title) {
    return Container(
      margin: const EdgeInsets.only(left: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const FaIcon(
            FontAwesomeIcons.squareCheck,
            size: 12,
            color: cl_PlaceholderColor,
          ),
          SdW_SizeBox_S,
          Expanded(
            child: Text(
              title,
              style: getBodyMediumTextStyle().copyWith(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationFooter(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 26,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(rd_SmallRounded),
        color: cl_PrimaryColor.withOpacity(0.1),
      ),
      child: Text(
        title.replaceAll('\r\n', '\n'),
        style: getBodyMediumTextStyle(),
        textAlign: TextAlign.center,
      ),
    );
  }
}
