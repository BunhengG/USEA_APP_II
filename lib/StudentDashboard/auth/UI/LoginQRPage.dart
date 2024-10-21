import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:useaapp_version_2/StudentDashboard/Screens/HomePage/UI/HomePage.dart';
import '../../api/fetch_user.dart';
import '../../helpers/shared_pref_helper.dart';

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

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);
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
          _buildTitle(),
          _buildFlashlightButton(),
          _buildAnimatedBorder(cutOutSize),
        ],
      ),
    );
  }

  Widget _buildQRView(double cutOutSize) {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        overlayColor: Colors.black.withOpacity(0.5),
        borderColor: Colors.white,
        borderRadius: 16,
        borderLength: 32,
        borderWidth: 8,
        cutOutSize: cutOutSize,
      ),
    );
  }

  Widget _buildCustomBorders(double cutOutSize) {
    return Positioned(
      top: (MediaQuery.of(context).size.height - cutOutSize) / 2,
      left: (MediaQuery.of(context).size.width - cutOutSize) / 2,
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
  }

  Widget _buildCornerBorder(int index) {
    final BorderSide borderSide =
        const BorderSide(width: 5, color: Colors.white);
    BorderRadius borderRadius;
    Alignment alignment;

    switch (index) {
      case 0: // Top-left
        borderRadius = const BorderRadius.only(topLeft: Radius.circular(16));
        alignment = Alignment.topLeft;
        break;
      case 1: // Top-right
        borderRadius = const BorderRadius.only(topRight: Radius.circular(16));
        alignment = Alignment.topRight;
        break;
      case 2: // Bottom-left
        borderRadius = const BorderRadius.only(bottomLeft: Radius.circular(16));
        alignment = Alignment.bottomLeft;
        break;
      case 3: // Bottom-right
      default:
        borderRadius =
            const BorderRadius.only(bottomRight: Radius.circular(16));
        alignment = Alignment.bottomRight;
        break;
    }

    return Positioned(
      top: alignment.y < 0 ? 0 : null,
      bottom: alignment.y >= 0 ? 0 : null,
      left: alignment.x < 0 ? 0 : null,
      right: alignment.x >= 0 ? 0 : null,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          border: Border(
            top: borderSide,
            left: alignment.x < 0 ? borderSide : BorderSide.none,
            right: alignment.x >= 0 ? borderSide : BorderSide.none,
            bottom: alignment.y >= 0 ? borderSide : BorderSide.none,
          ),
          borderRadius: borderRadius,
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Positioned(
      top: 45.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 24,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          const Text(
            'Back',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Positioned(
      top: 150.h,
      left: 0,
      right: 0,
      child: const Center(
        child: Text(
          "Scan QR Code",
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildFlashlightButton() {
    return Positioned(
      bottom: (MediaQuery.of(context).size.height -
                  (MediaQuery.of(context).size.width * 0.7)) /
              2 -
          150.h,
      left: (MediaQuery.of(context).size.width / 2) - 40.w,
      child: Container(
        width: 80.w,
        height: 80.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: _isFlashOn ? Colors.white : Colors.white60,
        ),
        child: IconButton(
          icon: Image.asset(
            'assets/img/flashlight.png',
            scale: 10,
          ),
          onPressed: _toggleFlash,
        ),
      ),
    );
  }

  Widget _buildAnimatedBorder(double cutOutSize) {
    return Positioned(
      top: (MediaQuery.of(context).size.height - cutOutSize) / 2,
      left: (MediaQuery.of(context).size.width - cutOutSize) / 2,
      child: SizedBox(
        width: cutOutSize,
        height: cutOutSize,
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Stack(
              children: [
                Positioned(
                  top: cutOutSize / 2 - 1,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 3,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    transform: Matrix4.translationValues(
                      0,
                      _animationController.value * 200 - 100,
                      0,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    Future.delayed(const Duration(milliseconds: 500));
    controller.scannedDataStream.listen((scanData) async {
      if (mounted) {
        setState(() {
          result = scanData;
        });
        await _loginWithQRCode(); // Call your login method
      }
    });
  }

  Future<void> _loginWithQRCode() async {
    if (result != null) {
      final data = result!.code?.split(':');
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

        _showSuccessSnackbar('Login Successful');
        _navigateToHomePage();
      } else {
        _showSnackbar('Login failed. Please check your credentials.');
      }
    }
  }

  void _navigateToHomePage() {
    Future.delayed(const Duration(milliseconds: 300), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              const StudentHomePage(initialIndex: 2),
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (context, anim, secondaryAnim, child) {
            return FadeTransition(opacity: anim, child: child);
          },
        ),
      );
    });
  }

  void _showSuccessSnackbar(String message) {
    _showSnackbar(message, contentType: ContentType.success, title: 'Success');
  }

  void _showSnackbar(String message,
      {ContentType contentType = ContentType.failure,
      String title = 'Login Failed'}) {
    if (!_isDialogShown) {
      setState(() {
        _isDialogShown = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: title,
            message: message,
            contentType: contentType,
          ),
          duration: const Duration(seconds: 2),
        ),
      );

      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _isDialogShown = false;
          });
        }
      });
    }
  }

  Future<void> _toggleFlash() async {
    if (controller != null) {
      setState(() {
        _isFlashOn = !_isFlashOn;
      });
      await controller!.toggleFlash();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    _animationController.dispose();
    super.dispose();
  }
}
