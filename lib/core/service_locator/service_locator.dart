import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:watt_test/core/session_management/session.dart';
import 'package:watt_test/core/session_management/session_impl.dart';

class ServiceLocator {
  static final GetIt _locator = GetIt.instance;

  // Register services
  static Future<void> setup() async {
    _locator.registerLazySingleton<Client>(() => Client());
    _locator.registerLazySingleton<FlutterSecureStorage>(
        () => const FlutterSecureStorage());
    _locator.registerLazySingleton<GlobalSession>(() => GlobalSessionImpl());
  }

  // Getters for services
  static Client get httpProvider => _locator<Client>();
  static FlutterSecureStorage get secureStorage =>
      _locator<FlutterSecureStorage>();
  static GlobalSession get globalSession => _locator<GlobalSession>();
}
