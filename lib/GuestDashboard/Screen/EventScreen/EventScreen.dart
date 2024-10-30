import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:lottie/lottie.dart';

import '../../../components/multi_Appbar.dart';
import '../../../theme/constants.dart';
import '../../../theme/text_style.dart';
import 'widgets/custom_CurrentEvent.dart';
import 'widgets/custom_PastEvent.dart';
import 'widgets/custom_UpcomingEvent.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool _isConnected = false;

  final GlobalKey<CurrentEventState> currentEventKey =
      GlobalKey<CurrentEventState>();
  final GlobalKey<PastEventState> pastEventKey = GlobalKey<PastEventState>();
  final GlobalKey<UpComingEventState> upcomingEventKey =
      GlobalKey<UpComingEventState>();

  @override
  void initState() {
    super.initState();
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      setState(() {
        _isConnected = result != ConnectivityResult.none;
        if (_isConnected) {
          _handleRefresh();
        }
      });
    });
    // Initial check
    _checkConnectivity();
  }

  Future<void> _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _isConnected = connectivityResult != ConnectivityResult.none;
      if (_isConnected) {
        _handleRefresh();
      } else {}
    });
  }

  Future<void> _handleRefresh() async {
    currentEventKey.currentState?.refreshEvents();
    pastEventKey.currentState?.refreshEvents();
    upcomingEventKey.currentState?.refreshEvents();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cl_ThirdColor,
      appBar: MultiAppBar(
        title: 'ព្រឹត្តិការណ៍',
        onBackButtonPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: _isConnected
          ? Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: u_BackgroundScaffold,
                  ),
                ),
                LiquidPullToRefresh(
                  onRefresh: _handleRefresh,
                  color: cl_defaultMode,
                  backgroundColor: cl_ThirdColor,
                  height: 100.0,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    children: const [
                      SizedBox(height: 26.0),
                      CurrentEvent(),
                      SizedBox(height: 16.0),
                      PastEvent(),
                      SizedBox(height: 16.0),
                      UpComingEvent(),
                      SizedBox(height: 16.0),
                    ],
                  ),
                ),
              ],
            )
          : Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: u_BackgroundScaffold,
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                ),
              ],
            ),
    );
  }
}
