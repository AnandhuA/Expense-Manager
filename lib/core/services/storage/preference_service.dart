import 'package:expense_manager/core/constants/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  PreferencesService._internal();
  static final PreferencesService _instance = PreferencesService._internal();
  factory PreferencesService() => _instance;

  SharedPreferences? _prefs;

  /// INIT once in main()
  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // SAVE DATA

  Future<void> saveToken(String token) async {
    await _prefs?.setString(AppKeys.token, token);
  }

  Future<void> saveNickname(String nickname) async {
    await _prefs?.setString(AppKeys.nickname, nickname);
  }

  Future<void> savePhone(String phone) async {
    await _prefs?.setString(AppKeys.phone, phone);
  }

  // GET DATA

  String? get token => _prefs?.getString(AppKeys.token);
  String? get nickname => _prefs?.getString(AppKeys.nickname);
  String? get phone => _prefs?.getString(AppKeys.phone);

  // REMOVE

  Future<void> clearUser() async {
    await _prefs?.remove(AppKeys.token);
    await _prefs?.remove(AppKeys.nickname);
    await _prefs?.remove(AppKeys.phone);
  }

  Future<void> clearAll() async {
    await _prefs?.clear();
  }



// SAVE ALERT LIMIT
  Future<void> saveAlertLimit(double limit) async {
    await _prefs?.setDouble(AppKeys.alertLimit, limit);
  }

  // GET ALERT LIMIT
  double get alertLimit => _prefs?.getDouble(AppKeys.alertLimit) ?? 1000;

  // MONTHLY ALERT FLAG (to avoid multiple notifications)
  Future<void> markAlertTriggered(String monthKey) async {
    await _prefs?.setString(AppKeys.alertTriggeredMonth, monthKey);
  }

  String? get alertTriggeredMonth =>
      _prefs?.getString(AppKeys.alertTriggeredMonth);

// RESET MONTH FLAG (optional)
  Future<void> clearAlertTrigger() async {
    await _prefs?.remove(AppKeys.alertTriggeredMonth);
  }
}
