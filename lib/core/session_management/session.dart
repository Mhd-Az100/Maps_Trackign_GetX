import 'package:watt_test/features/auth/model/user_model.dart';

abstract class GlobalSession {
  Future<String?> getToken();
  Future<UserModel>? getUser();
  Future<void> clearSessions();
  //========================
  Future<void> setToken(String token);
  Future<void> setUser(String user);
}
