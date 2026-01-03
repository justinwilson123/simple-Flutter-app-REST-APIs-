import 'package:shared_preferences/shared_preferences.dart';

class CachUser {
  final SharedPreferences sharedPreferences;

  CachUser(this.sharedPreferences);

  Future<void> saveUser(int userId) async {
    await sharedPreferences.setInt("UserId", userId);
  }

  Future<int> getUserId() async {
    int? userId = sharedPreferences.getInt("UserId");
    if (userId != null) {
      return await Future.value(userId);
    } else {
      return await Future.value(0);
    }
  }
}
