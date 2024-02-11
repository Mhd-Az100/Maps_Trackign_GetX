import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watt_test/core/api/exceptions.dart';
import 'package:watt_test/core/api/handle_controller.dart';
import 'package:watt_test/core/constants/styles.dart';
import 'package:watt_test/core/service_locator/service_locator.dart';
import 'package:watt_test/routes/app_pages.dart';

mixin BaseHandleApi {
  final handleController = Get.find<HandleOperationController>();
  handleError(exception) {
    if (exception is FetchDataException) {
      handleController.showError(exception.message ?? "Somthing went wrong");
    }
    //
    else if (exception is InvalidInputException) {
      handleController.showError(exception.message ?? "Somthing went wrong");
    }
    //
    else if (exception is UnauthorisedException) {
      sessionExpiredDialog(exception);
    }
    //
    else if (exception is ApiNotRespondingException) {
      handleController.showError(exception.message ?? "Somthing went wrong");
    }
  }

  sessionExpiredDialog(AppException exception) {
    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
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
