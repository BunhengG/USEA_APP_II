import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:useaapp_version_2/components/multi_Appbar.dart';

import '../../../theme/constants.dart';
import '../../../theme/text_style.dart';
import '../../Screens/StudentHomeScreen/UI/HomePage.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';
import 'LoginQRPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isUsernameValid = true;
  bool _isPasswordValid = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Color _usernameBorderColor = cl_SecondaryColor;
  Color _passwordBorderColor = cl_SecondaryColor;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateFields(BuildContext context) {
    String studentId = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    setState(() {
      _isUsernameValid = studentId.isNotEmpty;
      _isPasswordValid = password.isNotEmpty;

      _usernameBorderColor = _isUsernameValid ? cl_SecondaryColor : Colors.red;
      _passwordBorderColor = _isPasswordValid ? cl_SecondaryColor : Colors.red;
    });

    if (_isUsernameValid && _isPasswordValid) {
      context
          .read<LoginBloc>()
          .add(LoginButtonPressed(studentId: studentId, password: password));
    }
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    AnimatedSnackBar.material(
      message,
      type: AnimatedSnackBarType.error,
      duration: const Duration(seconds: 6),
      mobileSnackBarPosition: MobileSnackBarPosition.top,
    ).show(context);
  }

  void _showSuccessDialog(BuildContext context) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: 'Success',
      text: 'You have successfully logged in!',
      autoCloseDuration: const Duration(milliseconds: 500),
      showConfirmBtn: false,
    ).then((_) {
      Future.delayed(const Duration(milliseconds: 600), () {
        _navigateToHomePage(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc()..add(CheckIfLoggedIn()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: MultiAppBar(
          title: 'គណនីនិស្សិត'.tr,
          onBackButtonPressed: () => Navigator.of(context).pop(),
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(gradient: u_BackgroundScaffold),
            ),
            _buildBody(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            _showSuccessDialog(context);
          } else if (state is LoginFailure) {
            _showErrorSnackBar(context, state.error);
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is LoginLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                  ),
                  child: Container(
                    margin: EdgeInsets.only(top: 26.sp),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(rd_MediumRounded),
                      boxShadow: const [sd_BoxShadow],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildLogo(),
                        SizedBox(height: 8.h),
                        _buildLoginForm(context),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      'assets/img/logo.png',
      scale: 4,
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLoginHeader(),
        SizedBox(height: 16.h),
        _buildUsernameField(),
        SizedBox(height: 8.h),
        _buildPasswordField(),
        SizedBox(height: 16.h),
        _buildActionButtons(context),
        SizedBox(height: 16.h),
        _buildContactUsRow(),
      ],
    );
  }

  Widget _buildLoginHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ចូលគណនី'.tr.toUpperCase(),
          style: getTitleLargePrimaryColorTextStyle().copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'សូមបញ្ចូលអត្តលេខ និងសូមបញ្ចូលពាក្យសម្ងាត់'.tr,
          style: getBodySmallTextStyle(),
        ),
      ],
    );
  }

  Widget _buildUsernameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 45,
          child: TextField(
            controller: _usernameController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              hintText: '\t\tបញ្ចូលអត្តលេខ\t'.tr,
              hintStyle: getBodyMediumTextStyle()
                  .copyWith(fontWeight: FontWeight.normal),
              enabledBorder: _buildInputBorder(_usernameBorderColor),
              focusedBorder: _buildInputBorder(
                  _isUsernameValid ? cl_PrimaryColor : Colors.red),
              errorBorder: _buildInputBorder(Colors.red),
              errorStyle: const TextStyle(height: 0),
              suffixIcon:
                  _buildClearButton(_usernameController, _isUsernameValid),
            ),
            onChanged: (value) {
              setState(() {
                _isUsernameValid = value.isNotEmpty;
                _usernameBorderColor =
                    _isUsernameValid ? cl_SecondaryColor : Colors.red;
              });
            },
          ),
        ),
        if (!_isUsernameValid) _buildErrorMessage('សូមបញ្ចូលអត្តលេខ'.tr),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 45,
          child: TextField(
            controller: _passwordController,
            obscureText: !_isPasswordVisible,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              hintText: '\t\tបញ្ចូលពាក្យសម្ងាត់'.tr,
              hintStyle: getBodyMediumTextStyle()
                  .copyWith(fontWeight: FontWeight.normal),
              enabledBorder: _buildInputBorder(_passwordBorderColor),
              focusedBorder: _buildInputBorder(
                  _isPasswordValid ? cl_PrimaryColor : Colors.red),
              errorBorder: _buildInputBorder(Colors.red),
              errorStyle: const TextStyle(height: 0),
              suffixIcon: _buildPasswordVisibilityToggle(),
            ),
            onChanged: (value) {
              setState(() {
                _isPasswordValid = value.isNotEmpty;
                _passwordBorderColor =
                    _isPasswordValid ? cl_SecondaryColor : Colors.red;
              });
            },
          ),
        ),
        if (!_isPasswordValid) _buildErrorMessage('សូមបញ្ចូលពាក្យសម្ងាត់'),
      ],
    );
  }

  OutlineInputBorder _buildInputBorder(Color borderColor) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: borderColor, width: 2.0),
      borderRadius: BorderRadius.circular(rd_MediumRounded),
    );
  }

  Widget _buildClearButton(TextEditingController controller, bool isValid) {
    return isValid
        ? IconButton(
            icon: const Icon(Icons.clear, size: 18),
            onPressed: () {
              setState(() {
                controller.clear();
                _isUsernameValid = true;
                _usernameBorderColor = cl_SecondaryColor;
              });
            },
          )
        : const SizedBox.shrink();
  }

  Widget _buildPasswordVisibilityToggle() {
    return IconButton(
      icon: Icon(
          size: 18,
          _isPasswordVisible ? Icons.visibility : Icons.visibility_off),
      onPressed: () {
        setState(() {
          _isPasswordVisible = !_isPasswordVisible;
        });
      },
    );
  }

  Widget _buildErrorMessage(String message) {
    return Text(
      message,
      style: const TextStyle(color: Colors.red, fontSize: 12),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLoginButton(context),
        Text(
          'ឬ'.tr,
          style: getBodyLargeTextStyle(),
        ),
        SizedBox(width: 16.w),
        _buildQRButton(context),
      ],
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return SizedBox(
      // width: 140.w,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _validateFields(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: cl_PrimaryColor,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 12.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(rd_MediumRounded),
          ),
        ),
        child: Text(
          'ចូល'.tr.toUpperCase(),
          style: getTitleMediumTextStyle(),
        ),
      ),
    );
  }

  Widget _buildQRButton(BuildContext context) {
    return SizedBox(
      // width: 140.w,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginQRPage()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: cl_PrimaryColor,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 12.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(rd_MediumRounded),
          ),
        ),
        child: Text(
          'ចូលដោយប្រើកូដ QR ស្កេន'.tr.toUpperCase(),
          style: getTitleMediumTextStyle(),
        ),
      ),
    );
  }

  Widget _buildContactUsRow() {
    return GestureDetector(
      onTap: () async {
        const url = 'https://t.me/beephoeut';
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      },
      child: Row(
        children: [
          Text(
            'មិនទាន់មានគណនីទេឬ?\t'.tr,
            style: getBodySmallTextStyle().copyWith(
              color: cl_PlaceholderColor,
            ),
          ),
          Text(
            'ទំនាក់ទំនងក្រុមការងារ'.tr,
            style: getBodySmallTextStyle().copyWith(
              color: cl_PrimaryColor,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToHomePage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const StudentHomePage(initialIndex: 2),
      ),
    );
  }
}
