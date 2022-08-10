import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const notifRestaurant = 'Notifikasi Restaurant';

  Future<bool> get isRestaurantNoticationActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(notifRestaurant) ?? false;
  }

  void setRestaurantNotication(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(notifRestaurant, value);
  }
}
