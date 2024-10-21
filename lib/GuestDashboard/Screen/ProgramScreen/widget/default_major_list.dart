// import 'package:flutter/material.dart';
// import '../models/acca_Models.dart';
// import 'custom_AccordionList.dart';
// import 'custom_AccordionList_ACCA.dart';

// class MajorList extends StatefulWidget {
//   final List<dynamic> collegeData;
//   final ProgramACCA accaData;

//   const MajorList({
//     Key? key,
//     required this.collegeData,
//     required this.accaData,
//   }) : super(key: key);

//   @override
//   _MajorListState createState() => _MajorListState();
// }

// class _MajorListState extends State<MajorList> {
//   int? _expandedCollegeIndex;
//   int? _expandedACCAIndex;

//   void _toggleCollegeAccordion(int index) {
//     if (!mounted) return;
//     setState(() {
//       if (_expandedCollegeIndex == index) {
//         _expandedCollegeIndex = null;
//       } else {
//         _expandedCollegeIndex = index;
//         // Close ACCA accordion when a college accordion opens
//         _expandedACCAIndex = null;
//       }
//     });
//   }

//   void _toggleACCAAccordion(int index) {
//     if (!mounted) return;
//     setState(() {
//       if (_expandedACCAIndex == index) {
//         _expandedACCAIndex = null;
//       } else {
//         _expandedACCAIndex = index;
//         // Close college accordion when an ACCA accordion opens
//         _expandedCollegeIndex = null;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       physics: const BouncingScrollPhysics(),
//       padding: const EdgeInsets.all(8),
//       child: Column(
//         children: [
//           //! CustomAccordion for college data
//           ListView.builder(
//             physics: const NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             itemCount: widget.collegeData.length,
//             itemBuilder: (context, index) {
//               final faculty = widget.collegeData[index];
//               final facultyName = faculty['faculty_name'];
//               final facultyIconUrl = faculty['faculty_data']['fac_icon'];
//               // Extract major data
//               final majorData = faculty['faculty_data']['major_name'] as List;

//               return CustomAccordion(
//                 title: facultyName,
//                 icon: NetworkImage(facultyIconUrl),
//                 majors: majorData,
//                 isExpanded: _expandedCollegeIndex == index,
//                 onToggle: () => _toggleCollegeAccordion(index),
//               );
//             },
//           ),
//           //! CustomAccordionACCA for ACCA data
//           ListView.builder(
//             physics: const NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             itemCount: widget.accaData.facultyData.length,
//             itemBuilder: (context, index) {
//               final faculty = widget.accaData.facultyData[index];
//               final facultyIconUrl = faculty.fac_icon;
//               // Extract major data
//               final majorData = faculty.major_data;

//               return CustomAccordionACCA(
//                 title: faculty.major_data.isNotEmpty
//                     ? faculty.major_data[0].major_name
//                     : 'No Major Data',
//                 icon: NetworkImage(facultyIconUrl),
//                 majors: majorData,
//                 isExpanded: _expandedACCAIndex == index,
//                 onToggle: () => _toggleACCAAccordion(index),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }