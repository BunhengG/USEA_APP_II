import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'constants.dart';

class StaticFullscreenImagePage extends StatelessWidget {
  final String imageUrl;

  const StaticFullscreenImagePage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: Stack(
        children: [
          // Center(
          //   child: Image.asset(
          //     imageUrl,
          //     fit: BoxFit.contain,
          //   ),
          // ),
          Center(
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.contain,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),

          Positioned(
            top: 36,
            left: 16,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: cl_ItemBackgroundColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(rd_FullRounded),
              ),
              child: IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.xmark,
                  color: cl_ThirdColor,
                  size: 20,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
