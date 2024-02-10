import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 0;

  @override
  RouteSettings? redirect(String? route) {
    String? authService = GetStorage().read("token");
    return authService?.isNotEmpty ?? false
        ? null
        : const RouteSettings(name: '/login');
  }
}
