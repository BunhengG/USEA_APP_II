import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'package:useaapp_version_2/theme/color_builder.dart';
import 'package:useaapp_version_2/theme/constants.dart';
import '../../../../theme/text_style.dart';
import '../MajorScreens/acca_Details_Screen.dart';
import '../MajorScreens/details_screen.dart';
import '../models/acca_Models.dart';

class MajorSearchDelegate extends SearchDelegate<String> {
  final List<dynamic> majorData;
  final ProgramACCA accaData;

  MajorSearchDelegate(this.majorData, this.accaData);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const FaIcon(
          FontAwesomeIcons.xmark,
          color: cl_PrimaryColor,
          size: 18,
        ),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      margin: const EdgeInsets.only(left: 14, right: 14, top: 6),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: cl_PrimaryColor,
      ),
      child: IconButton(
        icon: const FaIcon(
          FontAwesomeIcons.angleLeft,
          color: cl_ThirdColor,
          size: 16,
        ),
        onPressed: () {
          close(context, '');
        },
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = [
      ...majorData.expand(
        (faculty) => faculty['faculty_data']['major_name'] as List<dynamic>,
      ),
      ...accaData.facultyData.expand((faculty) => faculty.major_data)
    ].where((major) {
      if (major is Major_Data) {
        // Check if it's ProgramACCA data
        return major.major_name.toLowerCase().contains(
              query.toLowerCase(),
            );
      } else if (major is Map<String, dynamic>) {
        // Check if it's ProgramData
        return (major['major_name'] ?? '').toLowerCase().contains(
              query.toLowerCase(),
            );
      }
      return false;
    }).toList();

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: results.length,
      itemBuilder: (context, index) {
        final major = results[index];
        final isAcca = major is Major_Data;

        return ListTile(
          selectedColor: cl_PlaceholderColor_Mode_38,
          title: Text(
            isAcca ? major.major_name : major['major_name'] ?? 'Unknown',
            style: getListTileTitle(),
          ),
          onTap: () {
            if (isAcca) {
              Navigator.push(
                context,
                SwipeablePageRoute(
                  builder: (context) => AccaDetailsScreen(
                    subjectData: major.subject_data,
                  ),
                ),
              );
            } else {
              final majorName = major['major_name'] ?? 'Unknown';
              final degreeDetails = major['major_data'];
              Navigator.push(
                context,
                SwipeablePageRoute(
                  builder: (context) => DetailsScreen(
                    title: majorName,
                    degreeDetails: degreeDetails,
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      color: context.guestBGColor,
      child: buildResults(context),
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: context.guestBGColor,
        shadowColor: cl_PlaceholderColor,
        elevation: 1,
        scrolledUnderElevation: 1,
        iconTheme: const IconThemeData.fallback(),
        centerTitle: false,
        titleSpacing: -10,
      ),
      textSelectionTheme: const TextSelectionThemeData(),
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
        fillColor: Colors.transparent,
        filled: true,
        focusColor: cl_PrimaryColor,
        hintStyle: getBodyLargeTextStyle(),
        labelStyle: getBodyLargeTextStyle(),
      ),
    );
  }

  @override
  String get searchFieldLabel => '\t\tស្វែងរក'.tr;

  @override
  TextStyle? get searchFieldStyle => getBodyLargeTextStyle();
}
