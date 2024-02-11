// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:watt_test/core/service_locator/service_locator.dart';

import 'session.dart';

class GlobalSessionImpl implements GlobalSession {
  final secureStorage = ServiceLocator.secureStorage;
  final storage = ServiceLocator.getStorage;

  @override
  Future<String?> getToken() async {
    return await secureStorage.read(key: "token");
  }

  @override
  String? getUser() {
    return storage.read("user");
  }

  //=================================

  @override
  Future<void> setToken(String token) async {
    await secureStorage.write(key: "token", value: token);
  }

  @override
  void setUser(String userJson) {
    storage.write("user", userJson);
  }

  @override
  Future<void> clearSessions() async {
    await secureStorage.deleteAll();
    await storage.erase();
  }
}
