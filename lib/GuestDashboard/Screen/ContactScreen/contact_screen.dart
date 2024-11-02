import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:useaapp_version_2/theme/color_builder.dart';
import 'package:useaapp_version_2/theme/constants.dart';
import '../../../components/multi_Appbar.dart';
import '../../../func/connectivity_service.dart';
import '../../../theme/text_style.dart';
import 'widget/contact_shimmer.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  late GoogleMapController _mapController;
  BitmapDescriptor _markerIcon = BitmapDescriptor.defaultMarker;
  final LatLng _initialPosition =
      const LatLng(13.350682787083263, 103.86438269625718);
  bool isLoading = true;
  bool _isConnected = true;

  final ConnectivityService _connectivityService = ConnectivityService();

  @override
  void initState() {
    super.initState();
    _loadCustomIcon();
    _checkConnectivity();
    _connectivityService.connectivityStream.listen((isConnected) {
      setState(() {
        _isConnected = isConnected;
        if (_isConnected) {
          _simulateLoading();
        }
      });
    });
  }

  Future<void> _checkConnectivity() async {
    _isConnected = await _connectivityService.checkConnectivity();
    if (_isConnected) {
      _simulateLoading();
    }
  }

  void _loadCustomIcon() {
    BitmapDescriptor.asset(
      const ImageConfiguration(),
      'assets/img/logo.png',
      height: 36,
    ).then(
      (icon) {
        setState(() {
          _markerIcon = icon;
        });
      },
    );
  }

  void _simulateLoading() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      isLoading = false;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _zoomIn() {
    _mapController.animateCamera(CameraUpdate.zoomIn());
  }

  void _zoomOut() {
    _mapController.animateCamera(CameraUpdate.zoomOut());
  }

  MapType _currentMapType = MapType.normal;

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.guestBGColor,
      appBar: MultiAppBar(
        title: 'ទំនាក់ទំនង'.tr,
        onBackButtonPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Stack(
        children: [
          if (_isConnected)
            GoogleMap(
              onMapCreated: _onMapCreated,
              mapType: _currentMapType,
              initialCameraPosition: CameraPosition(
                target: _initialPosition,
                zoom: 13,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('university_marker'),
                  position: _initialPosition,
                  icon: _markerIcon,
                ),
              },
            )
          else
            Container(
              color: Colors.white,
              child: Center(
                child: Text(
                  'គ្មានការតភ្ជាប់អ៊ីនធឺណិត...'.tr,
                  style: getTitleLargeTextStyle(),
                ),
              ),
            ),
          Positioned(
            top: 20,
            right: 5,
            child: Column(
              children: [
                if (_isConnected)
                  ElevatedButton(
                    onPressed: _onMapTypeButtonPressed,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: cl_ThirdColor,
                      backgroundColor: cl_PrimaryColor,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(8),
                      elevation: 4,
                    ),
                    child: const Icon(Icons.layers),
                  ),
                const SizedBox(height: 5),
                if (_isConnected)
                  ElevatedButton(
                    onPressed: _zoomIn,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: cl_ThirdColor,
                      backgroundColor: cl_PrimaryColor,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(8),
                      elevation: 4,
                    ),
                    child: const Icon(Icons.add),
                  ),
                const SizedBox(height: 5),
                if (_isConnected)
                  ElevatedButton(
                    onPressed: _zoomOut,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: cl_ThirdColor,
                      backgroundColor: cl_PrimaryColor,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(8),
                      elevation: 4,
                    ),
                    child: const Icon(Icons.remove),
                  ),
              ],
            ),
          ),
          DraggableScrollableSheet(
            snapAnimationDuration: const Duration(milliseconds: 100),
            maxChildSize: 0.75,
            minChildSize: 0.1,
            initialChildSize: 0.4,
            snap: true,
            builder: (
              BuildContext context,
              ScrollController scrollController,
            ) {
              return Container(
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  gradient: u_BackgroundScaffold,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: isLoading
                    ? const ShimmerContact()
                    : ListView(
                        controller: scrollController,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          Center(
                            child: Container(
                              width: 75,
                              height: 5,
                              decoration: BoxDecoration(
                                color: cl_ThirdColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Column(
                            children: [
                              _buildContactSection(
                                title: 'លេខទំនាក់ទំនង៖'.tr,
                                details: [
                                  {
                                    'text': '063 900 090',
                                    'icon': 'assets/icon/circle.png'
                                  },
                                  {
                                    'text': '017 386 678',
                                    'icon': 'assets/icon/circle.png'
                                  },
                                  {
                                    'text': '090 905 902',
                                    'icon': 'assets/icon/circle.png'
                                  },
                                  {
                                    'text': '070 408 438',
                                    'icon': 'assets/icon/circle.png'
                                  },
                                ],
                                iconPath: 'assets/icon/phone.png',
                              ),
                              const SizedBox(height: 20),
                              _buildContactSection(
                                title: 'ទំនាក់ទំនងប្រព័ន្ធផ្សព្វផ្សាយសង្គម៖'.tr,
                                details: [
                                  {
                                    'text': 'info@usea.edu.kh',
                                    'icon': 'assets/icon/link.png'
                                  },
                                  {
                                    'text':
                                        'ចូលឆានែលតេឡេក្រាមរបស់សកលវិទ្យាល័យ'.tr,
                                    'icon': 'assets/icon/link.png'
                                  },
                                ],
                                iconPath: 'assets/icon/mail.png',
                              ),
                              const SizedBox(height: 20),
                              _buildContactSection(
                                title: 'ទីតាំងរបស់សកលវិទ្យាល័យ៖'.tr,
                                details: [
                                  {
                                    'text':
                                        'ភូមិវត្តបូព៌ សង្កាត់សាលាកំរើក ស្រុកសៀមរាប ខេត្តសៀមរាប​ ព្រះរាជាណាចក្រកម្ពុជា (ទល់មុខវិទ្យាល័យអង្គរ)។'
                                            .tr,
                                  },
                                ],
                                iconPath: 'assets/icon/location.png',
                              ),
                            ],
                          ),
                        ],
                      ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection({
    required String title,
    required List<Map<String, String>> details,
    required String iconPath,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: cl_ThirdColor,
                borderRadius: BorderRadius.circular(rd_FullRounded),
              ),
              padding: const EdgeInsets.all(5),
              child: Image.asset(
                iconPath,
                width: 24,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: getTitleLargeTextStyle(),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...details.map(
          (detail) {
            final text = detail['text'] ?? '';
            final iconPath = detail['icon'] ?? '';

            // Define specific clickable details
            final bool isEmail = text.contains('info@usea.edu.kh');
            final bool isTelegram =
                text.contains('ចូលឆានែលតេឡេក្រាមរបស់សកលវិទ្យាល័យ'.tr);

            // Set colors based on the type of detail
            final Color textColor =
                isEmail || isTelegram ? cl_ThirdColor : cl_ThirdColor;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Container(
                margin: const EdgeInsets.only(left: 34),
                child: Row(
                  children: [
                    if (iconPath.isNotEmpty)
                      Image.asset(
                        iconPath,
                        width: 14,
                        height: 14,
                      ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (isEmail) {
                            _launchEmail();
                          } else if (isTelegram) {
                            _launchTelegram();
                          }
                        },
                        child: Text(
                          text,
                          style: getTitleSmallTextStyle().copyWith(
                            fontWeight: isEmail || isTelegram
                                ? FontWeight.bold
                                : FontWeight.normal,
                            decoration: isEmail || isTelegram
                                ? TextDecoration.underline
                                : TextDecoration.none,
                            decorationColor: isEmail || isTelegram
                                ? textColor
                                : Colors.transparent,
                            decorationStyle: TextDecorationStyle.solid,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void _launchEmail() async {
    const url = 'mailto:info@usea.edu.kh';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // print('Could not launch>>>>>>>>> $url');
    }
  }

  void _launchTelegram() async {
    const url = 'https://t.me/university_of_south_east_asia';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // print('Could not launch>>>>>>>>>> $url');
    }
  }
}
