import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../../theme/text_style.dart';
import '../api/fetch_data_rigister.dart';
import 'custom_registration_card.dart';
import 'registration_shimmer_loader.dart';

class CustomRegistration extends StatefulWidget {
  final bool isConnected;
  final Future<void> Function() onRefresh;

  const CustomRegistration({
    super.key,
    required this.isConnected,
    required this.onRefresh,
  });

  @override
  _CustomRegistrationState createState() => _CustomRegistrationState();
}

class _CustomRegistrationState extends State<CustomRegistration> {
  List<dynamic>? registrationData;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Fetch data on initialization if connected
    if (widget.isConnected) {
      fetchDataFromApi();
    }
  }

  @override
  void didUpdateWidget(CustomRegistration oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Fetch data when connectivity changes
    if (widget.isConnected != oldWidget.isConnected && widget.isConnected) {
      fetchDataFromApi();
    }
  }

  Future<void> fetchDataFromApi() async {
    if (!widget.isConnected) return;

    setState(() {
      isLoading = true;
    });

    ApiService apiService = ApiService();
    final data = await apiService.fetchData();

    setState(() {
      registrationData = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isConnected) {
      return Center(
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
      );
    }

    if (isLoading) {
      return const RegistrationShimmerLoader();
    }

    if (registrationData == null || registrationData!.isEmpty) {
      return const Center(
        child: Text('No registration data available.'),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          for (var registration in registrationData ?? [])
            RegistrationCard(registration: registration),
        ],
      ),
    );
  }
}
