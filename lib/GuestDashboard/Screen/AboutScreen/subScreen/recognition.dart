// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:useaapp_version_2/components/multi_Appbar.dart';
import 'package:useaapp_version_2/theme/constants.dart';
import '../../../../theme/text_style.dart';
import '../../../../components/circularProgressIndicator.dart';
import '../api/fetch_about.dart';
import '../widget/ShimmerGridPlaceholder.dart';
import '../../../../theme/fullscreen_image.dart';

class RecognitionScreen extends StatefulWidget {
  const RecognitionScreen({super.key});

  @override
  _RecognitionScreenState createState() => _RecognitionScreenState();
}

class _RecognitionScreenState extends State<RecognitionScreen> {
  List<dynamic> recognitions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRecognitions();
  }

  Future<void> fetchRecognitions() async {
    try {
      final data = await ApiService.fetchRecognitions();
      setState(() {
        recognitions = data;
        isLoading = false;
      });
    } catch (error) {
      print('Error fetching recognitions: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MultiAppBar(
        title: 'ការទទួលស្គាល់',
        onBackButtonPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: u_BackgroundScaffold,
        ),
        child: isLoading
            ? const Center(
                child: ShimmerGridPlaceholder(itemCount: 4),
              )
            : GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.8 / 3,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: recognitions.length,
                itemBuilder: (context, index) {
                  final recognition = recognitions[index];
                  final GlobalKey key = GlobalKey();
                  return Container(
                    key: key,
                    decoration: BoxDecoration(
                      color: cl_SecondaryColor,
                      borderRadius: BorderRadius.circular(rd_MediumRounded),
                      boxShadow: const [sd_BoxShadow],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              final RenderBox? renderBox = key.currentContext!
                                  .findRenderObject() as RenderBox?;
                              if (renderBox != null) {
                                final imageRect =
                                    renderBox.localToGlobal(Offset.zero) &
                                        renderBox.size;
                                showFullscreenImage(
                                    context, recognition['image'], imageRect);
                              }
                            },
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(rd_MediumRounded),
                                topRight: Radius.circular(rd_MediumRounded),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: recognition['image'],
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicatorWidget(),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                  Icons.error,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            recognition['title'],
                            style: getTitleSmallPrimaryColorTextStyle(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextButton(
                            onPressed: () {
                              launchURL(recognition['link']);
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: cl_ThirdColor,
                              backgroundColor: cl_PrimaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(rd_SmallRounded),
                              ),
                            ),
                            child: Text(
                              textAlign: TextAlign.center,
                              'អានបន្ថែម'.tr,
                              style: getTitleSmallTextStyle(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void showFullscreenImage(
      BuildContext context, String imageUrl, Rect imageRect) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          final screenSize = MediaQuery.of(context).size;

          // Calculate the center of the screen
          final centerOffset = Offset(
            screenSize.width / 2,
            screenSize.height / 2,
          );

          // Calculate the start scale and offset for the animation
          const startScale = 0.0;
          const endScale = 1.0;

          // Adjust scale animation
          final scaleAnimation =
              Tween<double>(begin: startScale, end: endScale).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOut),
          );

          // Adjust offset animation to start from the center
          final offsetAnimation = Tween<Offset>(
            begin: Offset(
              (centerOffset.dx - imageRect.left) / screenSize.width,
              (centerOffset.dy - imageRect.top) / screenSize.height,
            ),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOut),
          );

          return ScaleTransition(
            scale: scaleAnimation,
            child: SlideTransition(
              position: offsetAnimation,
              child: FadeTransition(
                opacity: scaleAnimation,
                child: StaticFullscreenImagePage(imageUrl: imageUrl),
              ),
            ),
          );
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final scaleTransition =
              Tween<double>(begin: 0.8, end: 1.0).animate(animation);
          final offsetTransition = Tween<Offset>(
            begin: const Offset(0.0, 0.0),
            end: Offset.zero,
          ).animate(animation);

          return ScaleTransition(
            scale: scaleTransition,
            child: SlideTransition(
              position: offsetTransition,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
        reverseTransitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }
}
