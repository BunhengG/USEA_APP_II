import 'package:flutter/material.dart';
import '../../../../theme/constants.dart';
import '../../../../theme/text_style.dart';
import '../model/video_model.dart'; // Adjust the import path if needed

class VideoListItem extends StatelessWidget {
  final VDO_Class video;
  final VoidCallback onTap;

  const VideoListItem({
    super.key,
    required this.video,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(rd_MediumRounded),
        boxShadow: const [
          BoxShadow(
            color: Colors.transparent,
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(rd_MediumRounded),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(rd_MediumRounded),
              child: Image.network(
                video.youtube_thumbnail,
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video.title,
                    style: getTitleMediumTextStyle(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    video.caption,
                    style: getBodyMediumThirdColorTextStyle().copyWith(
                      color: cl_ThirdColor.withOpacity(
                        0.8,
                      ),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
