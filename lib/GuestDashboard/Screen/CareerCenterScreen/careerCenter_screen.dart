import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../components/multi_Appbar.dart';
import '../../../theme/constants.dart';
import '../../../theme/text_style.dart';
import 'api/fetch_api_careerCenter.dart';
import 'model/careerCenterModel.dart';
import 'widget/career_shimmer_placeholder.dart';
import 'widget/custom_details_dialog.dart';
import '../../../../func/connectivity_service.dart'; // Import ConnectivityService

class CareerCenterScreen extends StatefulWidget {
  const CareerCenterScreen({super.key});

  @override
  State<CareerCenterScreen> createState() => _CareerCenterScreenState();
}

class _CareerCenterScreenState extends State<CareerCenterScreen> {
  late Future<List<Career>> _careers;
  bool _isLoading = true;
  bool _isConnected = true;
  final ConnectivityService _connectivityService = ConnectivityService();

  @override
  void initState() {
    super.initState();
    _connectivityService.connectivityStream.listen((isConnected) {
      setState(() {
        _isConnected = isConnected;
        if (_isConnected) {
          _fetchCareers();
        }
      });
    });
    _checkConnectivity();
  }

  Future<void> _checkConnectivity() async {
    bool isConnected = await _connectivityService.checkConnectivity();
    setState(() {
      _isConnected = isConnected;
      if (_isConnected) {
        _fetchCareers();
      }
    });
  }

  Future<void> _fetchCareers() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final careers = await ApiService().fetchCareers();
      setState(() {
        _careers = Future.value(careers);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle the error as needed
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
        title: 'មជ្ឈមណ្ឌលការងារ',
        onBackButtonPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(rd_MediumRounded),
                          color: cl_ItemBackgroundColor,
                        ),
                        margin: const EdgeInsets.only(bottom: 18),
                        child: ShimmerPlaceholder(
                          height: 80.0,
                          width: double.infinity,
                          borderRadius: BorderRadius.circular(rd_MediumRounded),
                        ),
                      );
                    },
                  )
                : FutureBuilder<List<Career>>(
                    future: _careers,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        final careers = snapshot.data!;
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: careers.length,
                          itemBuilder: (context, index) {
                            final career = careers[index];
                            return Container(
                              decoration: BoxDecoration(
                                boxShadow: const [sd_BoxShadow],
                                borderRadius:
                                    BorderRadius.circular(rd_MediumRounded),
                                color: cl_SecondaryColor,
                              ),
                              margin: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 16,
                              ),
                              child: ListTile(
                                leading: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(rd_SmallRounded),
                                    color: cl_ThirdColor,
                                  ),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(rd_SmallRounded),
                                    child: Image.network(career.logo,
                                        width: 50, height: 50),
                                  ),
                                ),
                                title: Text(
                                  career.position.length > 24
                                      ? '${career.position.substring(0, 24)}...'
                                      : career.position,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: cl_PrimaryColor,
                                    fontSize: 14,
                                    fontFamily: ft_Eng,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      career.organization.length > 26
                                          ? '${career.organization.substring(0, 26)}...'
                                          : career.organization,
                                      style: getBodyMediumTextStyle(),
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 4,
                                            vertical: 3,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                rd_FullRounded),
                                            color: Colors.cyan[600],
                                          ),
                                          child: const FaIcon(
                                            FontAwesomeIcons.calendar,
                                            color: cl_ThirdColor,
                                            size: 12,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          '${'ថ្ងៃផុតកំណត់៖ '.tr}${career.expiredDate}',
                                          style:
                                              getBodyMediumCareerCenterTextStyle()
                                                  .copyWith(
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                isThreeLine: true,
                                onTap: () {
                                  showCareerDetailsDialog(context, career);
                                },
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(child: Text('No data available'));
                      }
                    },
                  ),
      ),
    );
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}
