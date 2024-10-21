import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../func/connectivity_service.dart'; // Ensure correct path
import '../../../theme/constants.dart';
import '../../../theme/text_style.dart';
import 'api/fetch_api_program.dart';
import 'models/acca_Models.dart';
import 'widget/major_List.dart';
import 'widget/major_search_delegate.dart';
import 'widget/shimmer_major.dart';

class ProgramScreen extends StatefulWidget {
  const ProgramScreen({super.key});

  @override
  _ProgramScreenState createState() => _ProgramScreenState();
}

class _ProgramScreenState extends State<ProgramScreen> {
  final ConnectivityService _connectivityService = ConnectivityService();
  final ApiService _apiService = ApiService();

  bool _isConnected = true;
  bool isLoading = false;
  late Future<List<dynamic>> _collegeData;
  late Future<ProgramACCA> _accaData;

  @override
  void initState() {
    super.initState();

    // Initialize _collegeData and _accaData
    _collegeData = Future.value([]);
    _accaData = Future.value(
      ProgramACCA(facultyName: 'Default Faculty', facultyData: []),
    );

    // Subscribe to connectivity changes
    _connectivityService.connectivityStream.listen((isConnected) {
      setState(() {
        _isConnected = isConnected;
        if (_isConnected) {
          fetchDataFromApi();
        }
      });
    });

    // Initial check for connectivity
    _checkConnectivity();
  }

  Future<void> _checkConnectivity() async {
    bool isConnected = await _connectivityService.checkConnectivity();
    setState(() {
      _isConnected = isConnected;
      if (_isConnected) {
        fetchDataFromApi();
      }
    });
  }

  Future<void> fetchDataFromApi() async {
    if (!_isConnected) return;

    setState(() {
      isLoading = true;
    });

    _collegeData = _apiService.fetchCollegeData();
    _accaData = _apiService.fetchProgramACCA();

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _connectivityService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isConnected) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          titleSpacing: 5,
          elevation: 0.0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(color: Color(0xFF002060)),
          ),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.angleLeft,
                  color: Colors.white,
                  size: 22,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              Text(
                'កម្មវិធីសិក្សា'.tr,
                style: getTitleMediumTextStyle(),
              ),
            ],
          ),
        ),
        body: Stack(
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

    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          titleSpacing: 5,
          elevation: 0.0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(color: Color(0xFF002060)),
          ),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.angleLeft,
                  color: Colors.white,
                  size: 22,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              Text(
                'កម្មវិធីសិក្សា'.tr,
                style: getTitleMediumTextStyle(),
              ),
            ],
          ),
        ),
        body: const ShimmerLoading(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        titleSpacing: 5,
        elevation: 0.0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(color: Color(0xFF002060)),
        ),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.angleLeft,
                color: Colors.white,
                size: 22,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            Text(
              'កម្មវិធីសិក្សា'.tr,
              style: getTitleMediumTextStyle(),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              size: 20,
              color: Colors.white,
            ),
            onPressed: () async {
              final collegeData = await _collegeData;
              final accaData = await _accaData;
              showSearch(
                context: context,
                delegate: MajorSearchDelegate(collegeData, accaData),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: u_BackgroundScaffold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: FutureBuilder<List<dynamic>>(
              future: _collegeData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const ShimmerLoading();
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final collegeData = snapshot.data!;
                  return FutureBuilder<ProgramACCA>(
                    future: _accaData,
                    builder: (context, accaSnapshot) {
                      if (accaSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: ShimmerLoading());
                      } else if (accaSnapshot.hasError) {
                        return Center(
                            child: Text('Error: ${accaSnapshot.error}'));
                      } else if (accaSnapshot.hasData) {
                        final accaData = accaSnapshot.data!;
                        return MajorList(
                          collegeData: collegeData,
                          accaData: accaData,
                        );
                      } else {
                        return const Center(child: Text('No data available'));
                      }
                    },
                  );
                } else {
                  return const Center(child: Text('No data available'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
