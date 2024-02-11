import 'package:get/get.dart';
import 'package:watt_test/features/auth/bindings/AUTH_binding.dart';
import 'package:watt_test/features/auth/view/login_view.dart';
import 'package:watt_test/features/home/bindings/home_binding.dart';
import 'package:watt_test/features/home/middleware/auth_middleware.dart';
import 'package:watt_test/features/home/view/home_view.dart';

part 'app_routes.dart';

class AppRoutes {
  AppRoutes._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: AuthBinding(),
    ),
  ];
}
