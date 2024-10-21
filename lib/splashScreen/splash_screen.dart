import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:useaapp_version_2/theme/constants.dart';
// import '../GuestScreen/HomeScreen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(const AssetImage('assets/icon/logo.png'), context);
  }

  @override
  void initState() {
    super.initState();
    _startSplashScreen();
  }

  void _startSplashScreen() async {
    await Future.delayed(const Duration(milliseconds: 3000));
    // Navigator.of(context).pushReplacement(
    //   MaterialPageRoute(
    //     builder: (context) => const HomeScreen(),
    //   ),
    // );
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cl_PrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icon/logo.png',
              fit: BoxFit.cover,
              width: 140,
            ),
            const SizedBox(height: 8.0),
            const Text(
              'សាកលវិទ្យាល័យ សៅស៍អុីសថ៍អេយសៀ',
              style: TextStyle(
                fontSize: 16,
                fontFamily: ft_Khmer,
                color: cl_ThirdColor,
              ),
            ),
            Text(
              'University of South-East Asia'.toUpperCase(),
              style: const TextStyle(
                fontSize: 16,
                fontFamily: ft_Khmer,
                color: cl_ThirdColor,
              ),
            ),
            Lottie.asset('assets/icon/loading.json'),
          ],
        ),
      ),
    );
  }
}
