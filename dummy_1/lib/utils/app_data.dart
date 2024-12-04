import 'package:shared_preferences/shared_preferences.dart';

class AppData {
  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences?> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  static bool get isUserLoggedIn =>
      _prefsInstance?.getBool("IsUserLoggedIn") ?? false;
  static set isUserLoggedIn(bool value) =>
      _prefsInstance?.setBool("IsUserLoggedIn", value);

  static String get email => _prefsInstance?.getString("email") ?? "";
  static set email(String value) => _prefsInstance?.setString("email", value);

  static String get verifyCode =>
      _prefsInstance?.getString("verificationId") ?? "";
  static set verifyCode(String value) =>
      _prefsInstance?.setString("verificationId", value);

  static String get name => _prefsInstance?.getString("name") ?? "";
  static set name(String value) => _prefsInstance?.setString("name", value);

  static String get address => _prefsInstance?.getString("address") ?? "";
  static set address(String value) =>
      _prefsInstance?.setString("address", value);

  static String get phone => _prefsInstance?.getString("phone") ?? "";
  static set phone(String value) => _prefsInstance?.setString("phone", value);

  static String get pincode => _prefsInstance?.getString("pincode") ?? "";
  static set pincode(String value) =>
      _prefsInstance?.setString("pincode", value);

  static String get profilePic => _prefsInstance?.getString("profilePic") ?? "";
  static set profilePic(String value) =>
      _prefsInstance?.setString("profilePic", value);

  static bool get isFirstTime => _prefsInstance?.getBool("isFirstTime") ?? true;
  static set isFirstTime(bool value) =>
      _prefsInstance?.setBool("isFirstTime", value);

  static List<String> get cartList =>
      _prefsInstance?.getStringList("cartList") ?? [];
  static set cartList(List<String> value) =>
      _prefsInstance?.setStringList("cartList", value);

  static void clear() {
    _prefsInstance?.clear();
  }
}
