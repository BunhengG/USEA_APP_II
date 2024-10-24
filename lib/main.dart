import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:useaapp_version_2/splashScreen/splash_screen.dart';

import 'GuestDashboard/Screen/HomeScreen/home_screen.dart';
import 'StudentDashboard/Screens/PaymentScreen/bloc/payment_bloc.dart';
import 'StudentDashboard/Screens/PerformanceScreen/UI/performance_page.dart';
import 'StudentDashboard/Screens/ScheduleScreen/UI/schedule_page.dart';
import 'StudentDashboard/auth/bloc/login_bloc.dart';
import 'UsersScreen/Multiple_Users.dart';
import 'func/shared_pref_language.dart';
import 'theme/theme_provider/theme_provider.dart';
import 'theme/text_style.dart';
import 'theme/localString/translations/translations_localString.dart';

// students
import 'StudentDashboard/Screens/AchievementScreen/UI/AchievementPage.dart';
import 'StudentDashboard/Screens/AttendanceScreen/UI/attendance/attendance_page.dart';
import 'StudentDashboard/Screens/JobHistoryScreen/UI/job_page.dart';
import 'StudentDashboard/Screens/PaymentScreen/UI/payment_page.dart';
import 'StudentDashboard/Screens/PerformanceScreen/bloc/performance_bloc.dart';
import 'StudentDashboard/Screens/ProfileDetailsScreen/UI/ProfilePage.dart';
import 'StudentDashboard/Screens/ProfileDetailsScreen/bloc/profile_bloc.dart';
import 'StudentDashboard/Screens/ScheduleScreen/bloc/schedule_bloc.dart';
import 'StudentDashboard/Screens/StudyInfoScreen/UI/studyInfo_page.dart';
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
          theme: buildThemeData(),
          darkTheme: buildDarkThemeData(),
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
