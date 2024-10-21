// home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../GuestScreen/components/custom_Bottombar.dart';
import '../../../../utils/background.dart';
import '../../../../utils/theme_provider/theme_utils.dart';
import '../../../components/custom_Student_AppBar.dart';
// import '../../../components/custom_Student_Bottombar.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../widget/custom_GridViewBuilder.dart';
import '../widget/custom_card.dart';

class StudentHomePage extends StatelessWidget {
  final int initialIndex; // Add this to accept the index
  const StudentHomePage({super.key, required this.initialIndex});
  @override
  Widget build(BuildContext context) {
    //COMMENT: Check current theme mode
    final colorMode = isDarkMode(context);
    return BlocProvider(
      create: (context) => HomeBloc()..add(LoadHomeData()),
      child: Scaffold(
        backgroundColor: Colors.white10,
        appBar: const CustomStudentAppBarMode(),
        body: Stack(
          children: [
            // ! default
            // Container(
            //   width: double.infinity,
            //   decoration: isDarkMode ? switchBackground : defaultBackground,
            // ),
            BackgroundContainer(
              isDarkMode: colorMode,
            ),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        if (state is HomeLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is HomeLoaded) {
                          return Column(
                            children: [
                              CustomCard(
                                  userData: state.userData,
                                  creditData: state.creditData),
                              const SizedBox(height: 16),
                              const CustomGridView(),
                            ],
                          );
                        } else if (state is HomeError) {
                          return Center(child: Text(state.message));
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        // bottomNavigationBar: CustomStudentBottomBar(initialIndex: initialIndex),
        bottomNavigationBar: CustomBottombar(initialIndex: initialIndex),
      ),
    );
  }
}
