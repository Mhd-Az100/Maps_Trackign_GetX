import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watt_test/core/api/exceptions.dart';
import 'package:watt_test/core/api/handle_controller.dart';
import 'package:watt_test/core/constants/styles.dart';
import 'package:watt_test/core/service_locator/service_locator.dart';
import 'package:watt_test/routes/app_pages.dart';

mixin BaseHandleApi {
  final handleController = Get.find<HandleOperationController>();

  // Handle different types of exceptions and display appropriate messages
  handleError(exception) {
    if (exception is FetchDataException ||
        exception is InvalidInputException ||
        exception is ApiNotRespondingException) {
      handleController.showError(exception.message ?? "Something went wrong");
    } else if (exception is UnauthorisedException) {
      sessionExpiredDialog(exception);
    }
  }

  // Display a session expired dialog
  sessionExpiredDialog(AppException exception) {
    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: const Text("Warning"),
            content: Text(
              "Your session expired, please sign in again",
              style: AppTextStyles.regular18.copyWith(color: Colors.grey[850]),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  await ServiceLocator.globalSession.clearSessions();
                  Get.offAllNamed(Routes.LOGIN);
                },
                child: Text("Sign In", style: AppTextStyles.bold18),
              ),
            ],
          ),
        );
      },
    );
  }
}
