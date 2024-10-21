import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import '../../../theme/constants.dart';
import '../../../theme/text_style.dart';

class RegistrationCard extends StatelessWidget {
  final dynamic registration;

  const RegistrationCard({super.key, required this.registration});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(rd_MediumRounded),
      ),
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(rd_MediumRounded),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              registration['title'],
              style: getTitleKhmerMoolPrimaryColorTextStyle(),
            ),
            const SizedBox(height: 5.0),
            const Divider(
              thickness: 1,
              color: cl_SecondaryColor,
            ),
            const SizedBox(height: 8.0),
            for (var detail in registration['details'] ?? [])
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 38,
                        width: 38,
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 6,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(rd_FullRounded),
                          color: Colors.blueAccent.withOpacity(0.2),
                        ),
                        child: Image.asset(
                          'assets/icon/schedule.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          detail['date_title'],
                          style: getTitleSmallPrimaryColorTextStyle(),
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  for (var education in detail['education_list'] ?? [])
                    Container(
                      margin: const EdgeInsets.only(left: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              LottieBuilder.asset('assets/icon/active.json'),
                              const SizedBox(width: 8),
                              Text(
                                education['education_name'],
                                style: getBodyLargeTextStyle(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          for (var item in education['list'] ?? [])
                            Container(
                              margin: const EdgeInsets.only(left: 6),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const FaIcon(
                                    FontAwesomeIcons.squareCheck,
                                    size: 12,
                                    color: cl_PlaceholderColor,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      item['info'],
                                      style: getBodyMediumTextStyle()
                                          .copyWith(fontSize: 13),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(height: 16.0),
                        ],
                      ),
                    ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 38,
                        width: 38,
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 6,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(rd_FullRounded),
                          color: Colors.amber.withOpacity(0.2),
                        ),
                        child: Image.asset(
                          'assets/icon/clock.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          detail['time_title'],
                          style: getTitleSmallPrimaryColorTextStyle(),
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Container(
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
                      detail['time_detail'].replaceAll('\r\n', '\n'),
                      style: getBodyMediumTextStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
