import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../theme/constants.dart';
import '../components/multi_Appbar.dart';
import 'widget/custom_registration.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isConnected = true;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    // Subscribe to connectivity changes
    Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        _isConnected = result != ConnectivityResult.none;
      });
    });
  }

  Future<void> _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _isConnected = connectivityResult != ConnectivityResult.none;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: MultiAppBar(
          title: 'ការចុះឈ្មោះ',
          onBackButtonPressed: () {
            Navigator.of(context).pop();
          },
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: MultiAppBar(
        title: 'ការចុះឈ្មោះ',
        onBackButtonPressed: () {
          Navigator.of(context).pop();
        },
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
            child: ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                CustomRegistration(
                  isConnected: _isConnected,
                  onRefresh: _checkConnectivity,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
