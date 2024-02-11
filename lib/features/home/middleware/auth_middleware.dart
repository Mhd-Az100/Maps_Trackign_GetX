import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watt_test/core/service_locator/service_locator.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    checkTokenAndRedirect();
    return null;
  }
}

Future<void> checkTokenAndRedirect() async {
  String token = await ServiceLocator.globalSession.getToken() ?? "";

  if (token.isEmpty) {
    Get.offNamed('/login'); // or any other navigation logic you prefer
  }
}
