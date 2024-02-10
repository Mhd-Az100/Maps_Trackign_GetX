import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:watt_test/core/api/api_provider.dart';
import 'package:watt_test/core/constants/colors.dart';
import 'package:watt_test/core/service_locator/service_locator.dart';
import 'package:watt_test/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator.setup();
  final botToastBuilder = BotToastInit();

  runApp(MainApp(
    botToastBuilder: botToastBuilder,
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({required this.botToastBuilder, super.key});

  final TransitionBuilder botToastBuilder;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            builder: (context, child) => MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1.0)),
                child: botToastBuilder(
                  context,
                  child,
                )),
            debugShowCheckedModeBanner: false,
            initialRoute: AppRoutes.INITIAL,
            getPages: AppRoutes.routes,
            theme: ThemeData(
              primaryColor: AppColors.primaryBlue,
              textTheme: const TextTheme(
                labelLarge: TextStyle(fontFamily: "Somar"),
              ),
              colorScheme: ColorScheme.fromSwatch().copyWith(
                  secondary: AppColors.secondary,
                  primary: AppColors.primaryBlue),
            ),
            initialBinding: BindingsBuilder(() =>
                Get.put<BaseApiService>(BaseApiService(), permanent: true)),
          );
        });
  }
}
