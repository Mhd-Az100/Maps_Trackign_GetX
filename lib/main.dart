import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:watt_test/core/api/api_provider.dart';
import 'package:watt_test/core/api/handle_controller.dart';
import 'package:watt_test/core/constants/colors.dart';
import 'package:watt_test/core/constants/enums.dart';
import 'package:watt_test/core/service_locator/service_locator.dart';
import 'package:watt_test/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //device screen portrait mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Future.wait([
    // service locator setup
    ServiceLocator.setup(),
    //dotenv load the .env file
    dotenv.load(fileName: "assets/config/.env"),
  ]);

  //bottoast for toast message
  final botToastBuilder = BotToastInit();
  // opperation controller instance
  Get.put<HandleOperationController>(HandleOperationController(),
      permanent: true);
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
              GetX<HandleOperationController>(
                builder: (controller) {
                  if (controller.operationState.value == OperationState.error) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showSnackBar(
                        context,
                        "Operation Failed",
                        controller.errorMessage.value,
                        ContentType.failure,
                        AppColors.red,
                        controller,
                      );
                    });
                  } else if (controller.operationState.value ==
                      OperationState.success) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showSnackBar(
                        context,
                        "Operation Success",
                        controller.successMessage.value,
                        ContentType.success,
                        AppColors.green,
                        controller,
                      );
                    });
                  }
                  return child!;
                },
              ),
            ),
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.INITIAL,
          getPages: AppRoutes.routes,
          theme: ThemeData(
            primaryColor: AppColors.primaryBlue,
            colorScheme: ColorScheme.fromSwatch()
                .copyWith(
                    secondary: AppColors.secondary,
                    primary: AppColors.primaryBlue)
                .copyWith(background: Colors.white)
                .copyWith(surfaceTint: Colors.white),
          ),
          initialBinding: BindingsBuilder(() =>
              Get.lazyPut<BaseApiService>(() => BaseApiService(), fenix: true)),
        );
      },
    );
  }

  void showSnackBar(
    BuildContext context,
    String title,
    String message,
    ContentType contentType,
    Color color,
    HandleOperationController controller,
  ) {
    final snackBar = SnackBar(
      elevation: 0,
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: contentType,
        color: color,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar).closed.then((_) {
        // Reset the state after the Snackbar is closed
        controller.resetState();
      });
  }
}
