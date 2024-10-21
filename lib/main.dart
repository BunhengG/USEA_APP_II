// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:useaapp_version_2/splashScreen/splash_screen.dart';
// import 'package:useaapp_version_2/GuestScreen/HomeScreen/home_screen.dart';

// import 'StudentDashboard/Screens/PaymentPage/bloc/payment_bloc.dart';
// import 'StudentDashboard/Screens/PerformancePage/UI/performance_page.dart';
// import 'StudentDashboard/Screens/SchedulePage/UI/schedule_page.dart';
// import 'StudentDashboard/auth/bloc/login_bloc.dart';
// import 'UsersScreen/Multiple_Users.dart';
// import 'theme/text_style.dart';
// import 'localString/translations/translations_localString.dart';

// // students
// import 'StudentDashboard/Screens/AchievementPage/UI/AchievementPage.dart';
// import 'StudentDashboard/Screens/AttendancePage/UI/attendance/attendance_page.dart';
// import 'StudentDashboard/Screens/JobPage/UI/job_page.dart';
// import 'StudentDashboard/Screens/PaymentPage/UI/payment_page.dart';
// import 'StudentDashboard/Screens/PerformancePage/bloc/performance_bloc.dart';
// import 'StudentDashboard/Screens/ProfilePage/UI/ProfilePage.dart';
// import 'StudentDashboard/Screens/ProfilePage/bloc/profile_bloc.dart';
// import 'StudentDashboard/Screens/SchedulePage/bloc/schedule_bloc.dart';
// import 'StudentDashboard/Screens/StudyInfo/UI/studyInfo_page.dart';
// import 'StudentDashboard/api/fetch_schedule.dart';
// import 'StudentDashboard/auth/UI/LoginPage.dart';

// void main() {
//   runApp(
//     MultiBlocProvider(
//       providers: [
//         BlocProvider<LoginBloc>(
//           create: (context) => LoginBloc(),
//         ),
//         BlocProvider<ProfileBloc>(
//           create: (context) => ProfileBloc(),
//         ),
//         BlocProvider<ScheduleBloc>(
//           create: (context) => ScheduleBloc(ScheduleRepository()),
//         ),
//         BlocProvider<PerformanceBloc>(
//           create: (context) => PerformanceBloc(),
//         ),
//         // we don't need to declare BlocProvider of Attendance,
//         // because we already declare in attendance_page.dart
//         BlocProvider<PaymentBloc>(
//           create: (context) => PaymentBloc(),
//         ),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       // Size for an iPhone 11 Mini
//       designSize: const Size(375, 812),
//       minTextAdapt: true,
//       splitScreenMode: true,
//       builder: (context, child) {
//         return GetMaterialApp(
//           debugShowCheckedModeBanner: false,
//           title: 'USEA-APP-VERSION-2.0',
//           theme: buildThemeData(),
//           translations: LocaleString(), // Use GetX translations
//           locale: const Locale('km'), // Default locale
//           fallbackLocale: const Locale('en'), // Fallback locale
//           routes: {
//             '/': (context) => const SplashScreen(),
//             '/home': (context) => const HomeScreen(),
//             '/user': (context) => const MultipleUsers(),
//             // define for students routes
//             '/login': (context) => const LoginPage(),
//             '/profile': (context) => const ProfilePage(),
//             '/schedule': (context) => const SchedulePage(),
//             '/performance': (context) => const PerformanceScreen(),
//             '/attendance': (context) => const AttendancePage(),
//             '/payment': (context) => const PaymentPage(),
//             '/job': (context) => const JobPage(),
//             '/study': (context) => const StudyInfoPage(),
//             '/achievement': (context) => const AchievementPage(),
//           },
//           // home: const SplashScreen(),
//           builder: (context, widget) {
//             return MediaQuery(
//               data: MediaQuery.of(context).copyWith(
//                 textScaler: const TextScaler.linear(1.0),
//               ),
//               child: widget!,
//             );
//           },
//         );
//       },
//     );
//   }
// }

//? =================================================================
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
// import 'package:useaapp_version_2/splashScreen/splash_screen.dart';
// import 'package:useaapp_version_2/GuestScreen/HomeScreen/home_screen.dart';

// import 'StudentDashboard/Screens/PaymentPage/bloc/payment_bloc.dart';
// import 'StudentDashboard/Screens/PerformancePage/UI/performance_page.dart';
// import 'StudentDashboard/Screens/SchedulePage/UI/schedule_page.dart';
// import 'StudentDashboard/auth/bloc/login_bloc.dart';
// import 'UsersScreen/Multiple_Users.dart';
// import 'utils/theme_provider/theme_provider.dart';
// import 'theme/text_style.dart';
// import 'localString/translations/translations_localString.dart';

// // students
// import 'StudentDashboard/Screens/AchievementPage/UI/AchievementPage.dart';
// import 'StudentDashboard/Screens/AttendancePage/UI/attendance/attendance_page.dart';
// import 'StudentDashboard/Screens/JobPage/UI/job_page.dart';
// import 'StudentDashboard/Screens/PaymentPage/UI/payment_page.dart';
// import 'StudentDashboard/Screens/PerformancePage/bloc/performance_bloc.dart';
// import 'StudentDashboard/Screens/ProfilePage/UI/ProfilePage.dart';
// import 'StudentDashboard/Screens/ProfilePage/bloc/profile_bloc.dart';
// import 'StudentDashboard/Screens/SchedulePage/bloc/schedule_bloc.dart';
// import 'StudentDashboard/Screens/StudyInfo/UI/studyInfo_page.dart';
// import 'StudentDashboard/api/fetch_schedule.dart';
// import 'StudentDashboard/auth/UI/LoginPage.dart';

// void main() {
//   runApp(
//     MultiBlocProvider(
//       providers: [
//         BlocProvider<LoginBloc>(
//           create: (context) => LoginBloc(),
//         ),
//         BlocProvider<ProfileBloc>(
//           create: (context) => ProfileBloc(),
//         ),
//         BlocProvider<ScheduleBloc>(
//           create: (context) => ScheduleBloc(ScheduleRepository()),
//         ),
//         BlocProvider<PerformanceBloc>(
//           create: (context) => PerformanceBloc(),
//         ),
//         // we don't need to declare BlocProvider of Attendance,
//         // because we already declare in attendance_page.dart
//         BlocProvider<PaymentBloc>(
//           create: (context) => PaymentBloc(),
//         ),
//       ],
//       // child: const MyApp(),
//       child: ChangeNotifierProvider(
//         create: (_) => ThemeProvider(), // Provide ThemeProvider here
//         child: const MyApp(),
//       ),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider =
//         Provider.of<ThemeProvider>(context); // Access ThemeProvider

//     return ScreenUtilInit(
//       // Size for an iPhone 11 Mini
//       designSize: const Size(375, 812),
//       minTextAdapt: true,
//       splitScreenMode: true,
//       builder: (context, child) {
//         return GetMaterialApp(
//           debugShowCheckedModeBanner: false,
//           title: 'USEA-APP-VERSION-2.0',
//           theme: buildThemeData(), // default Theme
//           darkTheme: buildDarkThemeData(), // Dark Theme
//           themeMode: themeProvider.themeMode,
//           translations: LocaleString(), // Use GetX translations
//           locale: const Locale('km'), // Default locale
//           fallbackLocale: const Locale('en'), // Fallback locale
//           routes: {
//             '/': (context) => const SplashScreen(),
//             '/home': (context) => const HomeScreen(),
//             '/user': (context) => const MultipleUsers(),
//             // define for students routes
//             '/login': (context) => const LoginPage(),
//             '/profile': (context) => const ProfilePage(),
//             '/schedule': (context) => const SchedulePage(),
//             '/performance': (context) => const PerformanceScreen(),
//             '/attendance': (context) => const AttendancePage(),
//             '/payment': (context) => const PaymentPage(),
//             '/job': (context) => const JobPage(),
//             '/study': (context) => const StudyInfoPage(),
//             '/achievement': (context) => const AchievementPage(),
//           },
//           // home: const SplashScreen(),
//           builder: (context, widget) {
//             return MediaQuery(
//               data: MediaQuery.of(context).copyWith(
//                 textScaler: const TextScaler.linear(1.0),
//               ),
//               child: widget!,
//             );
//           },
//         );
//       },
//     );
//   }
// }

//? save language =================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:useaapp_version_2/splashScreen/splash_screen.dart';
import 'package:useaapp_version_2/GuestScreen/HomeScreen/home_screen.dart';

import 'StudentDashboard/Screens/PaymentPage/bloc/payment_bloc.dart';
import 'StudentDashboard/Screens/PerformancePage/UI/performance_page.dart';
import 'StudentDashboard/Screens/SchedulePage/UI/schedule_page.dart';
import 'StudentDashboard/auth/bloc/login_bloc.dart';
import 'UsersScreen/Multiple_Users.dart';
import 'func/shared_pref_language.dart';
import 'utils/theme_provider/theme_provider.dart';
import 'theme/text_style.dart';
import 'localString/translations/translations_localString.dart';

// students
import 'StudentDashboard/Screens/AchievementPage/UI/AchievementPage.dart';
import 'StudentDashboard/Screens/AttendancePage/UI/attendance/attendance_page.dart';
import 'StudentDashboard/Screens/JobPage/UI/job_page.dart';
import 'StudentDashboard/Screens/PaymentPage/UI/payment_page.dart';
import 'StudentDashboard/Screens/PerformancePage/bloc/performance_bloc.dart';
import 'StudentDashboard/Screens/ProfilePage/UI/ProfilePage.dart';
import 'StudentDashboard/Screens/ProfilePage/bloc/profile_bloc.dart';
import 'StudentDashboard/Screens/SchedulePage/bloc/schedule_bloc.dart';
import 'StudentDashboard/Screens/StudyInfo/UI/studyInfo_page.dart';
import 'StudentDashboard/api/fetch_schedule.dart';
import 'StudentDashboard/auth/UI/LoginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load saved language from SharedPreferences
  String? savedLanguageCode = await SharedPrefHelperLanguage.getLanguageCode();
  // print("Saved Language Code: $savedLanguageCode");
  Locale locale = const Locale('km'); // Default to Khmer

  if (savedLanguageCode != null) {
    locale = Locale(savedLanguageCode); // Set saved locale
  }

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(),
        ),
        BlocProvider<ScheduleBloc>(
          create: (context) => ScheduleBloc(ScheduleRepository()),
        ),
        BlocProvider<PerformanceBloc>(
          create: (context) => PerformanceBloc(),
        ),
        BlocProvider<PaymentBloc>(
          create: (context) => PaymentBloc(),
        ),
      ],
      // child: const MyApp(),
      child: ChangeNotifierProvider(
        create: (_) => ThemeProvider(), // Provide ThemeProvider here
        child: MyApp(initialLocale: locale), // Pass the loaded locale
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Locale initialLocale; // Receive the initial locale

  const MyApp({super.key, required this.initialLocale});

  @override
  Widget build(BuildContext context) {
    final themeProvider =
        Provider.of<ThemeProvider>(context); // Access ThemeProvider

    return ScreenUtilInit(
      // Size for an iPhone 11 Mini
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'USEA-APP-VERSION-2.0',
          theme: buildThemeData(), // default Theme
          darkTheme: buildDarkThemeData(), // Dark Theme
          themeMode: themeProvider.themeMode,
          translations: LocaleString(), // Use GetX translations
          locale: Get.locale ?? initialLocale, // Set the loaded locale
          fallbackLocale: const Locale('en'), // Fallback locale
          routes: {
            '/': (context) => const SplashScreen(),
            '/home': (context) => const HomeScreen(),
            '/user': (context) => const MultipleUsers(),
            // define for students routes
            '/login': (context) => const LoginPage(),
            '/profile': (context) => const ProfilePage(),
            '/schedule': (context) => const SchedulePage(),
            '/performance': (context) => const PerformanceScreen(),
            '/attendance': (context) => const AttendancePage(),
            '/payment': (context) => const PaymentPage(),
            '/job': (context) => const JobPage(),
            '/study': (context) => const StudyInfoPage(),
            '/achievement': (context) => const AchievementPage(),
          },
          // home: const SplashScreen(),
          builder: (context, widget) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: const TextScaler.linear(1.0),
              ),
              child: widget!,
            );
          },
        );
      },
    );
  }
}
