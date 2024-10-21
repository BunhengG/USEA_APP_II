/*

when you want to retrieve data from sharePreferences just import this class to use.

*/

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth/model/login_model_class.dart';

class SharedPrefHelper {
  // defined keys
  static const String studentIdKey = 'student_id';
  static const String passwordKey = 'password';

  // Save StudentID and Password
  static Future<void> saveStudentIdAndPassword(
      String studentId, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('student_id', studentId);
    await prefs.setString('password', password);
  }

  // Get StudentID
  static Future<String?> getStudentId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(studentIdKey);
  }

  // Get Password
  static Future<String?> getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(passwordKey);
  }

  // Save UserData (StudentUsers and UserData)
  static Future<void> saveUserData(
      StudentUsers studentUser, UserData userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save StudentUsers as JSON
    String studentUserJson = jsonEncode(studentUser.toJson());
    await prefs.setString('student_users', studentUserJson);

    // Save UserData as JSON
    String userDataJson = jsonEncode(userData.toJson());
    await prefs.setString('user_data', userDataJson);
  }

  // Get stored StudentUsers
  static Future<StudentUsers?> getStoredStudentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? studentUserJson = prefs.getString('student_users');
    if (studentUserJson != null && studentUserJson.isNotEmpty) {
      Map<String, dynamic> userMap = jsonDecode(studentUserJson);
      return StudentUsers.fromJson(userMap);
    }
    return null;
  }

  // Get stored UserData
  static Future<UserData?> getStoredUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataJson = prefs.getString('user_data');
    if (userDataJson != null && userDataJson.isNotEmpty) {
      Map<String, dynamic> userDataMap = jsonDecode(userDataJson);
      return UserData.fromJson(userDataMap);
    }
    return null;
  }

  // Clear SharedPreferences (Logout)
  static Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // Clear StudentID and Password (e.g., during logout)
  static Future<void> clearStudentIdAndPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(studentIdKey);
    await prefs.remove(passwordKey);
  }
}
