import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:useaapp_version_2/theme/constants.dart';
import 'package:useaapp_version_2/utils/background.dart';
import 'package:useaapp_version_2/utils/color_builder.dart';

import '../../../../theme/text_style.dart';
import '../../../../utils/theme_provider/theme_utils.dart';

class GetQRPage extends StatefulWidget {
  final String studentId;
  final String pwd;
  final String profilePic;

  const GetQRPage({
    super.key,
    required this.studentId,
    required this.pwd,
    required this.profilePic,
  });

  @override
  _GetQRPageState createState() => _GetQRPageState();
}

class _GetQRPageState extends State<GetQRPage> {
  final GlobalKey _qrKey = GlobalKey();
  bool _isSaving = false;

  Future<void> _captureAndSave(BuildContext context) async {
    setState(() {
      _isSaving = true;
    });

    final status = await Permission.storage.request();
    if (status.isGranted) {
      await Future.delayed(const Duration(milliseconds: 200));

      RenderRepaintBoundary boundary =
          _qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await (image.toByteData(format: ui.ImageByteFormat.png));

      if (byteData != null) {
        final result =
            await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
        if (result['isSuccess']) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('QR Code saved successfully.')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to save QR Code.')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to capture QR Code.')),
        );
      }
    } else if (await Permission.storage.isPermanentlyDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Storage permission is permanently denied.'),
          action: SnackBarAction(
            label: 'Settings',
            onPressed: () => openAppSettings(),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Storage permission is required to save QR Code.'),
        ),
      );
    }

    setState(() {
      _isSaving = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorMode = isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        titleSpacing: 5,
        elevation: 0.0,
        flexibleSpace: Container(
          decoration: BoxDecoration(color: context.appBarColor),
        ),
        title: Text(
          'បង្កើត QR'.tr,
          style: getTitleMediumTextStyle(),
        ),
        leading: IconButton(
          icon: const FaIcon(
            FontAwesomeIcons.angleLeft,
            color: cl_ThirdColor,
            size: 22,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 8,
            ),
            child: TextButton(
              onPressed: () => _captureAndSave(context),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
                textStyle: TextStyle(
                  fontSize: 18.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: Text(
                'ទាញយក QR'.tr.toUpperCase(),
                style: getTitleMediumTextStyle().copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: cl_ThirdColor,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Container(
          //   width: double.infinity,
          //   decoration: const BoxDecoration(
          //     gradient: u_BackgroundScaffold,
          //   ),
          // ),
          BackgroundContainer(isDarkMode: colorMode),
          Center(
            child: RepaintBoundary(
              key: _qrKey,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 320.w,
                    padding:
                        EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(_isSaving ? 0 : 16),
                      color: cl_ThirdColor,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: _isSaving ? 80.h : 30.h),
                        QrImageView(
                          data: '${widget.studentId}:${widget.pwd}',
                          version: QrVersions.auto,
                          size: 300.h,
                          errorCorrectionLevel: QrErrorCorrectLevel.H,
                          embeddedImage:
                              const AssetImage('assets/img/usea_logo.png'),
                          embeddedImageStyle: const QrEmbeddedImageStyle(
                            size: Size(40, 40),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          '@ ${widget.studentId}'.toUpperCase(),
                          style: TextStyle(
                            fontFamily: ft_Eng,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: cl_PrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_isSaving)
                    Positioned(
                      top: 8.h,
                      child: SizedBox(
                        width: 90.h,
                        height: 90.h,
                        child: ClipOval(
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                alignment: const FractionalOffset(0.5, 0.2),
                                image: (widget.profilePic.isNotEmpty &&
                                        widget.profilePic !=
                                            'http://116.212.155.149:9999/usea/studentsimg/noimage.png')
                                    ? NetworkImage(widget.profilePic)
                                    : const AssetImage(
                                            'assets/img/avator_palceholder.png')
                                        as ImageProvider,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  else
                    Positioned(
                      top: -40.h,
                      child: Container(
                        width: 90.h,
                        height: 90.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 6.h,
                          ),
                        ),
                        child: ClipOval(
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                alignment: const FractionalOffset(0.5, 0.2),
                                image: (widget.profilePic.isNotEmpty &&
                                        widget.profilePic !=
                                            'http://116.212.155.149:9999/usea/studentsimg/noimage.png')
                                    ? NetworkImage(widget.profilePic)
                                    : const AssetImage(
                                            'assets/img/avator_palceholder.png')
                                        as ImageProvider,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
