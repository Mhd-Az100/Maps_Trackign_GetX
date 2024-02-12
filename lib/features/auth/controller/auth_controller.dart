import 'package:get/get.dart';
import 'package:watt_test/core/service_locator/service_locator.dart';
import 'package:watt_test/features/auth/model/user_model.dart';
import 'package:watt_test/routes/app_pages.dart';
import 'package:watt_test/services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService authService = AuthService();
  final session = ServiceLocator.globalSession;

  // Observables for managing loading state and password visibility
  RxBool loading = false.obs;
  RxBool visible = true.obs;

  // Observable for storing user information
  Rx<UserModel> user = const UserModel().obs;

  // Method to handle the login process
  Future<void> login(String username, String password) async {
    try {
      // Set loading state to true during the login process
      loading.value = true;

      // Call the login method from the AuthService
      await authService.login(username, password).then((user) async {
        if (user != null) {
          // Save user token in the session
          await session.setToken(user.token ?? "");

          // Navigate to the home screen
          Get.offAllNamed(Routes.HOME);
        }
      });
    } finally {
      // Set loading state to false after the login process
      loading.value = false;
    }
  }
}
