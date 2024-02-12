// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:watt_test/core/service_locator/service_locator.dart';
import 'package:watt_test/features/auth/model/user_model.dart';

import 'session.dart';

class GlobalSessionImpl implements GlobalSession {
  final secureStorage = ServiceLocator.secureStorage;

  @override
  Future<String?> getToken() async {
    return await secureStorage.read(key: "token");
  }

  @override
  Future<UserModel>? getUser() async {
    String userJson = await secureStorage.read(key: "user") ?? "";
    jsonDecode(userJson);
    return UserModel.fromJson(jsonDecode(userJson));
  }

  //=================================

  @override
  Future<void> setToken(String token) async {
    await secureStorage.write(key: "token", value: token);
  }

  @override
  Future<void> setUser(String user) async {
    await secureStorage.write(key: "user", value: user);
  }

  @override
  Future<void> clearSessions() async {
    await secureStorage.deleteAll();
  }
}
