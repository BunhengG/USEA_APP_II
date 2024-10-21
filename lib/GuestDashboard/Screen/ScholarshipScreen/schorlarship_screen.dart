import 'package:flutter/material.dart';
import 'package:useaapp_version_2/theme/constants.dart';

import '../../../components/multi_Appbar.dart';

class SchorlarshipScreen extends StatefulWidget {
  const SchorlarshipScreen({super.key});

  @override
  State<SchorlarshipScreen> createState() => _SchorlarshipScreenState();
}

class _SchorlarshipScreenState extends State<SchorlarshipScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cl_ThirdColor,
      appBar: MultiAppBar(
        title: 'អាហារូបករណ៍',
        onBackButtonPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(color: cl_ThirdColor),
        ),
        Center(
          child: Image.asset(
            'assets/icon/emptyData.png',
            width: 150,
            height: 150,
          ),
        ),
      ]),
    );
  }
}
