import 'package:get/get.dart';
import 'package:watt_test/core/constants/enums.dart';

// opperation controller
class HandleOperationController extends GetxController {
  Rx<OperationState> operationState = OperationState.none.obs;
  RxString errorMessage = ''.obs;
  RxString successMessage = ''.obs;
  //
  void showError(String message) {
    operationState.value = OperationState.error;
    errorMessage.value = message;
    update();
  }

  //
  void resetState() {
    operationState.value = OperationState.none;
    errorMessage.value = '';
    successMessage.value = '';
    update();
  }

  //
  void showSuccess(String message) {
    operationState.value = OperationState.success;
    successMessage.value = message;
    update();
  }
}
