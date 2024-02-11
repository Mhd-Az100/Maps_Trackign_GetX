import 'package:get/get.dart';
import 'package:watt_test/core/service_locator/service_locator.dart';
import 'package:watt_test/features/auth/model/user_model.dart';
import 'package:watt_test/routes/app_pages.dart';
import 'package:watt_test/services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService authService = AuthService();
  final session = ServiceLocator.globalSession;
  //
  RxBool loading = false.obs;
  RxBool visible = true.obs;
  //
  Rx<UserModel> user = const UserModel().obs;

  Future<void> login(String username, String password) async {
    try {
      loading.value = true;
      await authService.login(username, password).then((user) async {
        if (user != null) {
          await session.setToken(user.token ?? "");
          Get.offAllNamed(Routes.HOME);
        }
      });
    } finally {
      loading.value = false;
    }
  }
}
