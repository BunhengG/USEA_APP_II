import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:useaapp_version_2/components/multi_Appbar.dart';

class AchievementPage extends StatelessWidget {
  const AchievementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MultiAppBar(
        title: 'សមិទ្ធិផល'.tr,
        onBackButtonPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: Center(
        child: Text('សមិទ្ធិផល'.tr),
      ),
    );
  }
}
