import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {

  static final UserPreferences _instance = UserPreferences._ctor();
  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._ctor();

  SharedPreferences _prefs;

  init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  get data {
    return _prefs.getString('data') ?? '';
  }

  set data(String value) {
    _prefs.setString('data', value);
  }

  Future setJwtToken(String value) {
    return _prefs.setString('jwtToken', value);
  }
}
