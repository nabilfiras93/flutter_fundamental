import 'package:shared_preferences/shared_preferences.dart';

class SettingService{
  Future<bool> setStatusSchedule(bool status) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("restaurant-schedule", status);
    return status;
  }

  Future<bool> getScheduleStatus() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("restaurant-schedule") ?? false;
  }
}