import 'dart:io';
import 'dart:developer';
import 'dart:async';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart' as qrScanner;
import 'package:quickalert/quickalert.dart';
import 'package:useaapp_version_2/StudentDashboard/Screens/StudentHomeScreen/UI/HomePage.dart';
import 'package:useaapp_version_2/theme/constants.dart';
import '../../api/fetch_user.dart';
import '../../helpers/shared_pref_helper.dart';
import 'package:google_ml_kit/google_ml_kit.dart' as mlKit;

class LoginQRPage extends StatefulWidget {
  const LoginQRPage({super.key});

  @override
  _LoginQRPageState createState() => _LoginQRPageState();
}

class _LoginQRPageState extends State<LoginQRPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool _isDialogShown = false;
  bool _isFlashOn = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  final ImagePicker _picker = ImagePicker();
  // ignore: unused_field
  File? _image;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void reassemble() {
    super.reassemble();
    controller?.pauseCamera();
    controller?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    double cutOutSize = MediaQuery.of(context).size.width * 0.7;

    return Scaffold(
      body: Stack(
        children: [
          _buildQRView(cutOutSize),
          _buildCustomBorders(cutOutSize),
          _buildBackButton(),
          // _buildAnimatedBorder(cutOutSize),
        ],
      ),
    );
  }

  Widget _buildQRView(double cutOutSize) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.86,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                overlayColor: Colors.transparent,
                borderColor: cl_ThirdColor,
                borderRadius: rd_LargeRounded,
                borderLength: 32,
                borderWidth: 6,
                cutOutSize: cutOutSize,
              ),
              onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
            ),
          ),
          _buildFlashlightAndUploadButton(),
        ],
      ),
    );
  }

  Widget _buildCustomBorders(double cutOutSize) {
    return Positioned(
      top: (MediaQuery.of(context).size.height - cutOutSize) / 2,
      left: (MediaQuery.of(context).size.width - cutOutSize) / 2,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: SizedBox(
              width: cutOutSize,
              height: cutOutSize,
              child: Stack(
                children: List.generate(4, (index) {
                  return _buildCornerBorder(index);
                }),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCornerBorder(int index) {
    const BorderSide borderSide = BorderSide(
      width: 6,
      color: cl_ThirdColor,
    );
    BorderRadius borderRadius;
    Alignment alignment;

    switch (index) {
      case 0: //* Top-left corner
        borderRadius = const BorderRadius.only(
          topLeft: Radius.circular(rd_MediumRounded),
        );
        alignment = Alignment.topLeft;
        break;
      case 1: //* Top-right corner
        borderRadius = const BorderRadius.only(
          topRight: Radius.circular(rd_MediumRounded),
        );
        alignment = Alignment.topRight;
        break;
      case 2: //* Bottom-left corner
        borderRadius = const BorderRadius.only(
          bottomLeft: Radius.circular(rd_MediumRounded),
        );
        alignment = Alignment.bottomLeft;
        break;
      case 3: //* Bottom-right corner
      default:
        borderRadius = const BorderRadius.only(
          bottomRight: Radius.circular(rd_LargeRounded),
        );
        alignment = Alignment.bottomRight;
        break;
    }

    return Positioned(
      top: alignment.y < 0 ? 0 : null,
      bottom: alignment.y > 0 ? 0 : null,
      left: alignment.x < 0 ? 0 : null,
      right: alignment.x > 0 ? 0 : null,
      child: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
            top: alignment.y < 0 ? borderSide : BorderSide.none,
            bottom: alignment.y > 0 ? borderSide : BorderSide.none,
            left: alignment.x < 0 ? borderSide : BorderSide.none,
            right: alignment.x > 0 ? borderSide : BorderSide.none,
          ),
          borderRadius: borderRadius,
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Positioned(
      top: 40.h,
      left: 120.w,
      right: 8.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'គណនីនិស្សិត'.tr,
            style: const TextStyle(
              color: cl_ThirdColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.close,
              color: cl_ThirdColor,
              size: 24,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildFlashlightAndUploadButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(rd_LargeRounded),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Flash button
          InkWell(
            onTap: _toggleFlash,
            child: Container(
              width: 150.w,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: _isFlashOn ? Colors.grey : Colors.grey[800],
                borderRadius: BorderRadius.circular(rd_LargeRounded),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _isFlashOn
                        ? Icons.flashlight_on_rounded
                        : Icons.flashlight_off_rounded,
                    color: cl_ThirdColor,
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Flash',
                    style: TextStyle(
                      color: cl_ThirdColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 16.w),
          // Upload QR button
          InkWell(
            onTap: _pickImageAndScan,
            child: Container(
              width: 150.w,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(rd_LargeRounded),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.qr_code_rounded,
                    color: cl_ThirdColor,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Upload QR',
                    style: TextStyle(
                      color: cl_ThirdColor,
                      fontSize: 14,
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

  // Widget _buildAnimatedBorder(double cutOutSize) {
  //   return Positioned(
  //     top: (MediaQuery.of(context).size.height - cutOutSize) / 2,
  //     left: (MediaQuery.of(context).size.width - cutOutSize) / 2,
  //     child: SizedBox(
  //       width: cutOutSize,
  //       height: cutOutSize,
  //       child: AnimatedBuilder(
  //         animation: _animationController,
  //         builder: (context, child) {
  //           return Stack(
  //             children: [
  //               Positioned(
  //                 top: cutOutSize / 2 - 1,
  //                 left: 0,
  //                 right: 0,
  //                 child: Container(
  //                   height: 3,
  //                   decoration: BoxDecoration(
  //                     color: cl_ThirdColor,
  //                     borderRadius: BorderRadius.circular(5),
  //                   ),
  //                   transform: Matrix4.translationValues(
  //                     0,
  //                     _animationController.value * 200 - 100,
  //                     0,
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }

  Future<void> _loginWithQRCode() async {
    if (result != null) {
      final data = result?.code?.split(':');
      if (data != null && data.length == 2) {
        final studentId = data[0];
        final password = data[1];

        try {
          final userDataResponse = await loginStudent(studentId, password);
          await _handleLoginResponse(userDataResponse);
        } catch (e) {
          if (mounted) {
            _showSnackbar('An error occurred: $e');
          }
        }
      } else {
        if (mounted) {
          _showSnackbar('Invalid QR code format');
        }
      }
    }
  }

  Future<void> _handleLoginResponse(userDataResponse) async {
    if (mounted) {
      if (userDataResponse != null &&
          userDataResponse.studentUsers.isNotEmpty &&
          !_isDialogShown) {
        final studentUser = userDataResponse.studentUsers[0];
        final userData = userDataResponse.userData[0];

        await SharedPrefHelper.saveStudentIdAndPassword(
          studentUser.studentId,
          studentUser.pwd,
        );
        await SharedPrefHelper.saveUserData(studentUser, userData);

        _showSuccessDialog(context);
        // _navigateToHomePage();
      } else {
        _showSnackbar(
            'Login failed. Please check your credentials or network connection.');
      }
    }
  }

  void _navigateToHomePage() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) =>
            const StudentHomePage(initialIndex: 2),
        transitionDuration: const Duration(milliseconds: 200),
        transitionsBuilder: (context, anim, secondaryAnim, child) {
          return FadeTransition(opacity: anim, child: child);
        },
      ),
    );
  }

  Future<void> _toggleFlash() async {
    if (controller != null) {
      setState(() {
        _isFlashOn = !_isFlashOn;
      });
      await controller!.toggleFlash();
    }
  }

  //COMMENT: Pick Image from gallery
  Future<void> _pickImageAndScan() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        if (mounted) {
          setState(
            () => _image = File(pickedFile.path),
          );
        }
        await _scanQRCodeFromImage(pickedFile.path);
      } else {
        _showSnackbar('ការចូលគណនីបានបរាជ័យ'.tr);
      }
    } catch (e) {
      _showSnackbar('Error picking image: $e');
    }
  }

  //COMMENT Scan QR Code image from gallery
  Future<void> _scanQRCodeFromImage(String filePath) async {
    try {
      final inputImage = mlKit.InputImage.fromFilePath(filePath);
      final barcodeScanner = mlKit.BarcodeScanner(
        formats: [mlKit.BarcodeFormat.qrCode],
      );
      final List<mlKit.Barcode> barcodes =
          await barcodeScanner.processImage(inputImage);
      if (barcodes.isNotEmpty) {
        final mlKit.Barcode barcode = barcodes.first;
        final String? qrCodeData = barcode.displayValue ?? barcode.rawValue;
        if (qrCodeData != null && _isValidQRCode(qrCodeData)) {
          if (mounted) {
            setState(
              () => result = Barcode(
                code: qrCodeData,
                format: qrCodeData,
              ),
            );
            await _loginWithQRCode();
          }
        } else {
          _showSnackbar('ការចូលគណនីបានបរាជ័យ'.tr);
        }
      } else {
        _showSnackbar('ការចូលគណនីបានបរាជ័យ'.tr);
      }
    } catch (e) {
      _showSnackbar('Error scanning image: $e');
    }
  }

  //COMMENT Check for valid QR code
  bool _isValidQRCode(String qrCode) => qrCode.isNotEmpty;

  Future<void> _checkCameraPermission() async {
    var status = await Permission.camera.status;

    if (status.isDenied) {
      status = await Permission.camera.request();

      if (status.isPermanentlyDenied) {
        openAppSettings();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Camera permission is permanently denied. Please enable it from settings.'),
          ),
        );
      } else if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Camera permission denied'),
          ),
        );
      }
    }
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      _checkCameraPermission();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    if (mounted) {
      setState(() {
        this.controller = controller;
      });
    }

    controller.scannedDataStream.listen((qrScanner.Barcode scanData) async {
      try {
        if (mounted) {
          setState(
            () => result = Barcode(
              code: scanData.code,
              format: scanData.format.formatName,
            ),
          );
          await _loginWithQRCode();
          controller.pauseCamera();
        }
      } catch (e) {
        print("Error while scanning: $e");
      }
    });
  }

  void _showSuccessDialog(BuildContext context) {
    if (!_isDialogShown) {
      _isDialogShown = true;

      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Success',
        text: 'You have successfully logged in!',
        autoCloseDuration: const Duration(seconds: 1),
        showConfirmBtn: false,
      );

      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          _isDialogShown = false;
          _navigateToHomePage();
        }
      });
    }
  }

  void _showSnackbar(String message) {
    if (!_isDialogShown) {
      setState(() {
        _isDialogShown = true;
      });

      _showErrorSnackBar(context, message);

      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _isDialogShown = false;
          });
        }
      });
    }
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    AnimatedSnackBar.material(
      message,
      type: AnimatedSnackBarType.error,
      duration: const Duration(seconds: 2),
      mobileSnackBarPosition: MobileSnackBarPosition.bottom,
    ).show(context);
  }

  @override
  void dispose() {
    controller?.dispose();
    _animationController.dispose();
    super.dispose();
  }
}

class Barcode {
  final String? code;
  final String? format;

  Barcode({this.code, this.format});
}
