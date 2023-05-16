import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class GetUserData {
  Future<UserModel?> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = prefs.getString("user_data");
    if(data != null) {
      final user = UserModel.fromJson(json.decode(data));
      return user;
    }
    return null;
  }
  Future<UserModel> getAllUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = prefs.getString("user_data");
    final user = UserModel.fromJson(json.decode(data!));
    return user;
  }
}