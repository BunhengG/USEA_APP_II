import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:useaapp_version_2/GuestScreen/components/multi_Appbar.dart';
import 'package:useaapp_version_2/theme/constants.dart';
import '../../../localString/Data/dummy_data.dart';

class VisionMissionScreen extends StatelessWidget {
  const VisionMissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MultiAppBar(
        title: "ចក្ខុវិស័យ បេសកកម្ម និងគុណតម្លៃ".tr,
        onBackButtonPressed: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: visionMission.map((item) {
            return item.containsKey('descriptionList')
                ? _buildSectionWithList(item)
                : _buildSection(item);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildSection(Map<String, dynamic> item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(item['title']),
          const SizedBox(height: 8),
          Text(
            textAlign: TextAlign.justify,
            item['description'] ?? '',
            style: _descriptionTextStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionWithList(Map<String, dynamic> item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(item['title']),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: (item['descriptionList'] as List<dynamic>).map<Widget>(
              (text) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 8.0,
                        backgroundColor: cl_ThirdColor,
                        child: Icon(
                          Icons.circle,
                          color: cl_PrimaryColor,
                          size: 10,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          textAlign: TextAlign.justify,
                          text,
                          style: _descriptionTextStyle,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(String? title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? '',
            style: const TextStyle(
              fontFamily: ft_Eng,
              fontSize: 18,
              color: cl_PrimaryColor,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: 46,
            height: 2,
            decoration: const BoxDecoration(
              color: cl_SecondaryColor,
            ),
          ),
        ],
      ),
    );
  }

  static const TextStyle _descriptionTextStyle = TextStyle(
    fontFamily: ft_Eng,
    fontSize: 13,
    color: cl_TextColor,
  );
}
