import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:useaapp_version_2/theme/constants.dart';

import '../../../../components/circularProgressIndicator.dart';
import '../../../../theme/text_style.dart';

class EventCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String body;
  final String eventDate;
  final String eventTime;
  final int bodyTextLimit;
  final int titleTextLimit;

  const EventCard({
    required this.imagePath,
    required this.title,
    required this.body,
    required this.eventDate,
    required this.eventTime,
    this.bodyTextLimit = 80,
    this.titleTextLimit = 26,
    super.key,
  });

  String get truncatedBody {
    return body.length > bodyTextLimit
        ? '${body.substring(0, bodyTextLimit)}...'
        : body;
  }

  String get truncatedTitle {
    return title.length > titleTextLimit
        ? '${title.substring(0, titleTextLimit)}...'
        : title;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        color: cl_ThirdColor,
        borderRadius: BorderRadius.circular(rd_MediumRounded),
        boxShadow: const [sd_BoxShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(16.0)),
            child: CachedNetworkImage(
              imageUrl: imagePath,
              placeholder: (context, url) => const SizedBox(
                height: 180.0,
                child: Center(child: CircularProgressIndicatorWidget()),
              ),
              errorWidget: (context, url, error) => Image.asset(
                'assets/icon/loading_image.png',
                height: 180.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              fit: BoxFit.cover,
              height: 180.0,
              width: double.infinity,
              fadeInDuration: const Duration(milliseconds: 300),
              fadeOutDuration: const Duration(milliseconds: 300),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  truncatedTitle,
                  style: getTitleSmallPrimaryColorTextStyle(),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Container(
                  constraints: const BoxConstraints(maxHeight: 30),
                  child: Text(
                    truncatedBody,
                    style: getBodyMediumTextStyle(),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.solidCalendarDays,
                      color: cl_PlaceholderColor,
                      size: 10.0,
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      eventDate,
                      style: getBodyMediumTextStyle().copyWith(
                        color: cl_PlaceholderColor,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(width: 4.0),
                    const FaIcon(
                      FontAwesomeIcons.solidClock,
                      color: cl_PlaceholderColor,
                      size: 10.0,
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      eventTime,
                      style: getBodyMediumTextStyle().copyWith(
                        color: cl_PlaceholderColor,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
