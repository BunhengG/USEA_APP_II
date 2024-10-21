import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:useaapp_version_2/theme/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../components/circularProgressIndicator.dart';
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
        isLoading
            ? buildShimmer()
            : urlImages.isEmpty
                ? buildPlaceholderImage()
                : CarouselSlider.builder(
                    itemCount: urlImages.length,
                    itemBuilder: (context, index, _) {
                      final image = urlImages[index];
                      return buildImage(image);
                    },
                    options: CarouselOptions(
                      height: 200.0,
                      viewportFraction: 1.0,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      autoPlayInterval: const Duration(seconds: 10),
                      onPageChanged: (index, reason) {
                        setState(() {
                          activeIndex = index;
                        });
                      },
                    ),
                  ),
        const SizedBox(height: 8.0),
        if (!isLoading && urlImages.isNotEmpty) buildIndicator(),
      ],
    );
  }

  Widget buildImage(String imageUrl) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Container(
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
              placeholder: (context, url) =>
                  const CircularProgressIndicatorWidget(),
              errorWidget: (context, url, error) => buildPlaceholderImage(),
              key: ValueKey(imageUrl),
            ),
          ),
        ),
      );

  Widget buildPlaceholderImage() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Container(
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
        ),
      );

  Widget buildShimmer() => Center(
        child: SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                width: MediaQuery.of(context).size.width * 0.93,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(rd_LargeRounded),
                  color: cl_ItemBackgroundColor,
                ),
                child: Shimmer.fromColors(
                  baseColor: cl_ItemBackgroundColor,
                  highlightColor: Colors.grey[200]!,
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(rd_LargeRounded),
                      color: cl_ItemBackgroundColor,
                    ),
                  ),
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
