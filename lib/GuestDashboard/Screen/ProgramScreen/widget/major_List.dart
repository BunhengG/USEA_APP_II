import 'package:flutter/material.dart';
import '../models/acca_Models.dart';
import 'custom_AccordionList.dart';
import 'custom_AccordionList_ACCA.dart';

class MajorList extends StatefulWidget {
  final List<dynamic> collegeData;
  final ProgramACCA accaData;

  const MajorList({
    super.key,
    required this.collegeData,
    required this.accaData,
  });

  @override
  _MajorListState createState() => _MajorListState();
}

class _MajorListState extends State<MajorList> {
  int? _expandedIndex;
  bool _isCollegeData = true;

  void _toggleAccordion(int index) {
    if (!mounted) return;
    setState(() {
      if (_expandedIndex == index) {
        _expandedIndex = null;
      } else {
        _expandedIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Ensure data is available before proceeding
    if (widget.collegeData.isEmpty && widget.accaData.facultyData.isEmpty) {
      return const Center(child: Text('No data available.'));
    }

    final List<dynamic> combinedData = [
      {'type': 'college', 'data': widget.collegeData},
      {'type': 'acca', 'data': widget.accaData.facultyData}
    ];

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: combinedData.length,
      itemBuilder: (context, index) {
        final data = combinedData[index];
        final type = data['type'];
        final items = data['data'];

        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, itemIndex) {
            if (type == 'college') {
              final faculty = items[itemIndex];
              final facultyName = faculty['faculty_name'];
              final facultyIconUrl = faculty['faculty_data']['fac_icon'];
              final majorData = faculty['faculty_data']['major_name'] as List;

              return CustomAccordion(
                title: facultyName,
                icon: NetworkImage(facultyIconUrl),
                majors: majorData,
                isExpanded: _expandedIndex == itemIndex && _isCollegeData,
                onToggle: () {
                  _toggleAccordion(itemIndex);
                  setState(() {
                    _isCollegeData = true;
                  });
                },
              );
            } else if (type == 'acca') {
              final faculty = items[itemIndex];
              final facultyIconUrl = faculty.fac_icon;
              final majorData = faculty.major_data;

              return CustomAccordionACCA(
                title: faculty.major_data.isNotEmpty
                    ? faculty.major_data[0].major_name
                    : 'No Major Data',
                icon: NetworkImage(facultyIconUrl),
                majors: majorData,
                isExpanded: _expandedIndex == itemIndex && !_isCollegeData,
                onToggle: () {
                  _toggleAccordion(itemIndex);
                  setState(() {
                    _isCollegeData = false;
                  });
                },
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        );
      },
    );
  }
}
