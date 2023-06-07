import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/services/services_locator.dart';
import 'shared_prefs_response.dart';

abstract class LocalDataSource{
  Future<void> setToken(String value);
  Future<String> getToken();
}

class SharedPrefsLocalDataSource implements LocalDataSource{
  @override
  Future<String> getToken() {
    final token = sl<SharedPreferences>().getString(SharedPrefsJsonKeys.token) ?? "";
    return Future.value(token);

  }

  @override
  Future<void> setToken(String value) {
    return sl<SharedPreferences>().setString(SharedPrefsJsonKeys.token, value);
  }

}