// // Student_home_page.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../components/circularProgressIndicator.dart';
// import '../../../../components/custom_Bottombar.dart';
// import '../../../../theme/background.dart';
// import '../../../../theme/theme_provider/theme_utils.dart';
// import '../../../components/custom_Student_AppBar.dart';
// import '../bloc/home_bloc.dart';
// import '../bloc/home_event.dart';
// import '../bloc/home_state.dart';
// import '../widget/custom_GridViewBuilder.dart';
// import '../widget/custom_card.dart';

// class StudentHomePage extends StatelessWidget {
//   final int initialIndex;
//   const StudentHomePage({super.key, required this.initialIndex});
//   @override
//   Widget build(BuildContext context) {
//     final colorMode = isDarkMode(context);
//     return BlocProvider(
//       create: (context) => HomeBloc()
//         ..add(LoadHomeData())
//         ..add(CheckConnectivity()),
//       child: Scaffold(
//         appBar: const CustomStudentAppBarMode(),
//         body: Stack(
//           children: [
//             BackgroundContainer(
//               isDarkMode: colorMode,
//             ),
//             SingleChildScrollView(
//               physics: const BouncingScrollPhysics(),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   children: [
//                     // Display connectivity status
//                     BlocBuilder<HomeBloc, HomeState>(
//                       builder: (context, state) {
//                         if (state is ConnectivityFailure) {
//                           return Container(
//                             color: Colors.redAccent,
//                             padding: const EdgeInsets.all(8.0),
//                             child: const Text(
//                               'No Internet Connection',
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           );
//                         }
//                         return const SizedBox.shrink();
//                       },
//                     ),

//                     BlocBuilder<HomeBloc, HomeState>(
//                       builder: (context, state) {
//                         if (state is HomeLoading) {
//                           return const Center(
//                             child: CircularProgressIndicatorWidget(),
//                           );
//                         } else if (state is HomeLoaded) {
//                           return Column(
//                             children: [
//                               CustomCard(
//                                 userData: state.userData,
//                                 creditData: state.creditData,
//                               ),
//                               const SizedBox(height: 16),
//                               const CustomGridView(),
//                             ],
//                           );
//                         } else if (state is HomeError) {
//                           return Center(child: Text(state.message));
//                         } else {
//                           return const SizedBox();
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//         bottomNavigationBar: CustomBottombar(initialIndex: initialIndex),
//       ),
//     );
//   }
// }




//! default code 2 


// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';

// import '../../../../components/circularProgressIndicator.dart';
// import '../../../../components/custom_Bottombar.dart';
// import '../../../../func/connection_dialog_service.dart';
// import '../../../../theme/background.dart';
// import '../../../../theme/text_style.dart';
// import '../../../../theme/theme_provider/theme_utils.dart';
// import '../../../components/custom_Student_AppBar.dart';
// import '../bloc/home_bloc.dart';
// import '../bloc/home_event.dart';
// import '../bloc/home_state.dart';
// import '../widget/custom_GridViewBuilder.dart';
// import '../widget/custom_card.dart';

// class StudentHomePage extends StatefulWidget {
//   final int initialIndex;
//   const StudentHomePage({super.key, required this.initialIndex});

//   @override
//   _StudentHomePageState createState() => _StudentHomePageState();
// }

// class _StudentHomePageState extends State<StudentHomePage> {
//   bool hasInternet = true;
//   late StreamSubscription<ConnectivityResult> _connectivitySubscription;
//   bool isNoInternetBannerVisible = false;
//   bool isDialogVisible = false;
//   Color bannerColor = Colors.green;

//   @override
//   void initState() {
//     super.initState();
//     checkInternetConnection();
//   }

//   void checkInternetConnection() async {
//     var connectivityResult = await Connectivity().checkConnectivity();
//     setState(() {
//       hasInternet = connectivityResult != ConnectivityResult.none;
//       isNoInternetBannerVisible = !hasInternet;
//       bannerColor = hasInternet ? Colors.green : Colors.redAccent;
//     });

//     //? Listen to connection changes
//     _connectivitySubscription = Connectivity().onConnectivityChanged.listen(
//       (ConnectivityResult result) {
//         if (result == ConnectivityResult.none) {
//           // Internet is lost
//           if (hasInternet) {
//             setState(() {
//               hasInternet = false;
//               isNoInternetBannerVisible = true;
//               bannerColor = Colors.redAccent;
//             });

//             // Show the no internet dialog if it's not already visible
//             if (!isDialogVisible) {
//               DialogService.showNoInternetDialog(context);
//               isDialogVisible = true;
//             }
//           }
//         } else {
//           print("Checking if internet restored triggered routing...");

//           // Internet is restored
//           if (!hasInternet) {
//             setState(() {
//               hasInternet = true;
//               isNoInternetBannerVisible = true;
//               bannerColor = Colors.green;
//             });

//             // Close only the dialog, not the page
//             if (isDialogVisible && (Get.isDialogOpen ?? false)) {
//               Get.back(result: null);
//               isDialogVisible = false;
//             }

//             // Hide the banner after a short delay
//             Timer(const Duration(seconds: 3), () {
//               if (mounted) {
//                 setState(() {
//                   isNoInternetBannerVisible = false;
//                 });
//               }
//             });
//           }
//         }
//       },
//     );
//   }

//   @override
//   void dispose() {
//     _connectivitySubscription.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final colorMode = isDarkMode(context);

//     return BlocProvider(
//       create: (context) => HomeBloc()
//         ..add(LoadHomeData())
//         ..add(CheckConnectivity()),
//       child: Scaffold(
//         appBar: const CustomStudentAppBarMode(),
//         body: _buildStudentHomePageContent(context, colorMode),
//         bottomNavigationBar: CustomBottombar(initialIndex: widget.initialIndex),
//       ),
//     );
//   }

//   Widget _buildStudentHomePageContent(BuildContext context, bool colorMode) {
//     return Stack(
//       children: [
//         BackgroundContainer(isDarkMode: colorMode),
//         SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 BlocBuilder<HomeBloc, HomeState>(
//                   builder: (context, state) {
//                     if (state is HomeLoading) {
//                       return const Center(
//                         child: CircularProgressIndicatorWidget(),
//                       );
//                     } else if (state is HomeLoaded) {
//                       return Column(
//                         children: [
//                           CustomCard(
//                             userData: state.userData,
//                             creditData: state.creditData,
//                           ),
//                           const SizedBox(height: 16),
//                           const CustomGridView(),
//                         ],
//                       );
//                     } else if (state is HomeError) {
//                       return Center(child: Text(state.message));
//                     } else {
//                       return const SizedBox();
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),

//         // Internet connectivity banner
//         if (isNoInternetBannerVisible) _buildInternetBanner()
//       ],
//     );
//   }

//   Widget _buildInternetBanner() {
//     return Positioned(
//       top: 0,
//       left: 0,
//       right: 0,
//       child: SizedBox(
//         height: 36.h,
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 500),
//           color: bannerColor,
//           padding: const EdgeInsets.symmetric(
//             horizontal: 0,
//             vertical: 0.0,
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               LottieBuilder.asset(
//                 'assets/icon/no_internet_icon.json',
//                 fit: BoxFit.cover,
//                 height: 36.h,
//               ),
//               Text(
//                 hasInternet
//                     ? 'អ៊ីនធឺណិតបានត្រឡប់មកវិញ...'.tr
//                     : 'គ្មានការតភ្ជាប់អ៊ីនធឺណិត...'.tr,
//                 style: getTitleSmallTextStyle(),
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }