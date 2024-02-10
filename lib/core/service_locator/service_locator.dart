import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';

class ServiceLocator {
  static final GetIt _locator = GetIt.instance;

  // Register services
  static Future<void> setup() async {
    _locator.registerLazySingleton<GetStorage>(() => GetStorage());
    _locator.registerLazySingleton<FlutterSecureStorage>(
        () => const FlutterSecureStorage());
  }

  // Getters for services
  static GetStorage get getStorage => _locator<GetStorage>();
  static FlutterSecureStorage get secureStorage =>
      _locator<FlutterSecureStorage>();
}
