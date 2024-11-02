import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:useaapp_version_2/theme/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import '../../../../components/circularProgressIndicator.dart';
import '../api/fetch_slider_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class CustomSlidebar extends StatefulWidget {
  const CustomSlidebar({super.key});

  @override
  State<CustomSlidebar> createState() => _CustomSlidebarState();
}

class _CustomSlidebarState extends State<CustomSlidebar> {
  int activeIndex = 0;
  List<String> urlImages = [];
  bool isLoading = true;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    fetchAndSetImages();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        if (result != ConnectivityResult.none) {
          fetchAndSetImages();
        }
      },
    );
  }

  Future<void> fetchAndSetImages() async {
    final images = await fetchImages();
    setState(() {
      urlImages = images;
      isLoading = false;
    });

    // Precache images
    for (final imageUrl in urlImages) {
      precacheImage(NetworkImage(imageUrl), context);
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (isLoading)
          Container(
            height: 250,
            width: double.infinity,
            margin: const EdgeInsets.only(left: 8),
            child: buildShimmer(),
          )
        else
          urlImages.isEmpty
              ? buildPlaceholderImage()
              : CarouselSlider.builder(
                  itemCount: urlImages.length,
                  itemBuilder: (context, index, _) {
                    final image = urlImages[index];
                    return buildImage(image);
                  },
                  options: CarouselOptions(
                    height: 250.0,
                    viewportFraction: 1.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    autoPlayInterval: const Duration(seconds: 3),
                    onPageChanged: (index, reason) {
                      setState(() {
                        activeIndex = index;
                      });
                    },
                  ),
                ),
        SizedBox(height: 16.0.h),
        if (!isLoading && urlImages.isNotEmpty) buildIndicator(),
        SizedBox(height: 8.0.h),
      ],
    );
  }

  Widget buildImage(String imageUrl) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(rd_LargeRounded),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(rd_LargeRounded),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            placeholder: (context, url) => buildShimmer(),
            errorWidget: (context, url, error) => buildPlaceholderImage(),
            key: ValueKey(imageUrl),
          ),
        ),
      );

  Widget buildPlaceholderImage() => Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
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
            'assets/icon/loading_image.json',
            height: 200,
          ),
        ),
      );

  Widget buildShimmer() => SizedBox(
        height: 250,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (context, index) => Container(
            margin: const EdgeInsets.only(right: 16.0, left: 0),
            width: MediaQuery.of(context).size.width * 0.96,
            child: Shimmer.fromColors(
              baseColor: cl_ItemBackgroundColor,
              highlightColor: Colors.grey[300]!,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(rd_LargeRounded),
                  color: cl_ItemBackgroundColor,
                ),
              ),
            ),
          ),
        ),
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: urlImages.length,
        effect: const ExpandingDotsEffect(
          activeDotColor: cl_ThirdColor,
          dotColor: cl_ItemBackgroundColor,
          dotHeight: 8,
          dotWidth: 8,
          spacing: 6,
        ),
      );
}
