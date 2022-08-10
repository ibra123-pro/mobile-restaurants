import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurants/data/preferences/preferences_helper.dart';
import 'package:restaurants/utils/background_service.dart';
import 'package:restaurants/utils/date_time_helper.dart';

class SchedulingProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;
  SchedulingProvider({required this.preferencesHelper}) {
    _getRestaurantNoticationPreference();
  }

  bool _isScheduled = true;
  bool get isScheduled => _isScheduled;

  void _getRestaurantNoticationPreference() async {
    _isScheduled = await preferencesHelper.isRestaurantNoticationActive;
    notifyListeners();
  }

  void enableRestaurantNotication(bool value) {
    preferencesHelper.setRestaurantNotication(value);
    scheduledRestaurant(value);
    _getRestaurantNoticationPreference();
  }

  Future<bool> scheduledRestaurant(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      debugPrint('Notifikasi Restaurant Aktif');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      debugPrint('Notifikasi Restaurant Cancel');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
