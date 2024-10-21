import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:useaapp_version_2/components/multi_Appbar.dart';
import 'package:useaapp_version_2/theme/constants.dart';
import '../../../theme/localString/Data/dummy_data.dart';
import '../../../theme/text_style.dart';
import '../../../components/circularProgressIndicator.dart';
import 'subScreen/history_logo_meaning.dart';
import 'subScreen/president.dart';
import 'subScreen/recognition.dart';
import 'subScreen/university_structure.dart';
import 'subScreen/vistion_missoin_core_value.dart';
import '../../../func/connectivity_service.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final ConnectivityService _connectivityService = ConnectivityService();
  bool _isConnected = true; // Track internet connection state

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    _connectivityService.connectivityStream.listen((isConnected) {
      setState(() {
        _isConnected = isConnected;
      });
    });
  }

  Future<void> _checkConnectivity() async {
    _isConnected = await _connectivityService.checkConnectivity();
    setState(() {});
  }

  void navigateToScreen(BuildContext context, String title) {
    switch (title) {
      case "ប្រវត្តិ និងអត្ថន័យរបស់និមិត្តសញ្ញា":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HistoryScreen()),
        );
        break;
      case "រចនាសម្ព័ន្ធរបស់សាកលវិទ្យាល័យ":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const StructureScreen()),
        );
        break;
      case "សាររបស់សាកលវិទ្យាធិការ":
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const PresidentMessageScreen()),
        );
        break;
      case "ចក្ខុវិស័យ បេសកកម្ម និងគុណតម្លៃ":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const VisionMissionScreen()),
        );
        break;
      case "ការទទួលស្គាល់":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RecognitionScreen()),
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MultiAppBar(
        title: 'អំពីយើង',
        onBackButtonPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: u_BackgroundScaffold,
            ),
          ),
          if (_isConnected)
            ListView.builder(
              itemCount: aboutList.length,
              itemBuilder: (context, index) {
                final item = aboutList[index];
                return GestureDetector(
                  onTap: () => navigateToScreen(context, item['title']!),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    padding: const EdgeInsets.only(right: 10.0),
                    decoration: BoxDecoration(
                      color: cl_SecondaryColor,
                      borderRadius: BorderRadius.circular(rd_MediumRounded),
                    ),
                    child: Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 16.0,
                          ),
                          decoration: const BoxDecoration(
                            color: cl_ThirdColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(rd_MediumRounded),
                              topLeft: Radius.circular(rd_MediumRounded),
                            ),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: item['icon']!,
                            width: 36.0,
                            height: 36.0,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                const CircularProgressIndicatorWidget(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Text(
                              item['title']!.tr,
                              style: getListTileTitle(),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: cl_PrimaryColor,
                            borderRadius: BorderRadius.circular(rd_FullRounded),
                          ),
                          padding: const EdgeInsets.all(2.0),
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: cl_ThirdColor,
                            size: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          else
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
