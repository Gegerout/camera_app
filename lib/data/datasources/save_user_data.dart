import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class SaveUserData {
  Future<void> savePersonalData(String? name, String? surname, String? image) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userData = UserModel(name, surname, image);
    prefs.setString("user_data", json.encode(userData));
  }
}