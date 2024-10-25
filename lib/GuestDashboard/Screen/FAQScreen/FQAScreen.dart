import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:useaapp_version_2/components/multi_Appbar.dart';
import 'package:useaapp_version_2/theme/text_style.dart';

import '../../../components/circularProgressIndicator.dart';
import '../../../theme/constants.dart';
import 'api/fetchFQA.dart';
import 'model/fqaModel.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  late Future<List<QuestionAnswer>> _fqaFuture;

  @override
  void initState() {
    super.initState();
    _fqaFuture = ApiService().fetchFQA();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MultiAppBar(
        title: 'FAQ'.tr,
        onBackButtonPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: u_BackgroundScaffold,
            ),
          ),
          FutureBuilder<List<QuestionAnswer>>(
            future: _fqaFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicatorWidget());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No FAQs available'));
              }

              final faqs = snapshot.data!;
              return ListView.builder(
                itemCount: faqs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(rd_MediumRounded),
                        color: cl_ThirdColor,
                        boxShadow: const [sd_BoxShadow],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(rd_MediumRounded),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                          child: ExpansionTile(
                            title: Text(
                              faqs[index].question,
                              style: getTitleMediumPrimaryColorTextStyle(),
                            ),
                            collapsedIconColor: cl_PrimaryColor,
                            iconColor: cl_PrimaryColor,
                            tilePadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            childrenPadding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            expandedCrossAxisAlignment:
                                CrossAxisAlignment.start,
                            collapsedShape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(rd_MediumRounded),
                            ),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            backgroundColor: Colors.transparent,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  faqs[index].answer,
                                  style: getTitleMediumPrimaryColorTextStyle(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
