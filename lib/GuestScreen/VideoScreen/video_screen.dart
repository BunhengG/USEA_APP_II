import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:useaapp_version_2/GuestScreen/components/multi_Appbar.dart';
import '../../theme/constants.dart';
import '../../theme/text_style.dart';
import 'api/fetch_video_api.dart';
import 'model/video_model.dart';
import 'widget/custom_Video_Display.dart';
import 'widget/custom_Video_List.dart';
import 'widget/video_shimmer_effect.dart';
import '../../func/connectivity_service.dart'; // Import ConnectivityService

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late Future<List<VDO_Class>> _futureVideos;
  final ApiService _apiService = ApiService();
  final ConnectivityService _connectivityService = ConnectivityService();
  bool _isConnected = true;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _connectivityService.connectivityStream.listen((isConnected) {
      setState(() {
        _isConnected = isConnected;
        if (_isConnected) {
          _fetchVideos();
        }
      });
    });
    _checkConnectivity();
  }

  Future<void> _checkConnectivity() async {
    _isConnected = await _connectivityService.checkConnectivity();
    if (_isConnected) {
      _fetchVideos();
    } else {
      setState(() {
        _isLoading = false; // Ensure loading state is false when no internet
      });
    }
  }

  Future<void> _fetchVideos() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final videos = await _apiService.fetchVideos();
      setState(() {
        _futureVideos = Future.value(videos);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _futureVideos = Future.value([]); // Return an empty list on error
      });
      // Handle the error as needed
    }
  }

  void _launchURL() async {
    const url = 'https://bit.ly/usea_yt';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void dispose() {
    _connectivityService.dispose(); // Dispose the connectivity subscription
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MultiAppBar(
        title: 'វីដេអូ',
        onBackButtonPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: u_BackgroundScaffold,
        ),
        child: !_isConnected
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LottieBuilder.asset(
                      'assets/icon/no_internet_icon.json',
                      width: 160,
                    ),
                    Text(
                      'គ្មានការតភ្ជាប់អ៊ីនធឺណិត...'.tr,
                      style: getTitleSmallTextStyle(),
                    ),
                  ],
                ),
              )
            : _isLoading
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return const ShimmerVideoListItem();
                    },
                  )
                : FutureBuilder<List<VDO_Class>>(
                    future: _futureVideos,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No videos found'));
                      }

                      final videos = snapshot.data!;

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        itemCount: videos.length,
                        itemBuilder: (context, index) {
                          final video = videos[index];
                          return VideoListItem(
                            video: video,
                            onTap: () {
                              Navigator.push(
                                context,
                                SwipeablePageRoute(
                                  builder: (context) => VideoDisplay(
                                    data: video,
                                    vdo: videos,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
      ),
    );
  }
}
