import 'package:flutter/material.dart';

import '../components/multi_Appbar.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MultiAppBar(
        title: 'ព័ត៌មានថ្មីៗ',
        onBackButtonPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: const Center(
        child: Text('Notifications content goes here.'),
      ),
    );
  }
}
