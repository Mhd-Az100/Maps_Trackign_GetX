import 'package:get/get.dart';
import 'package:watt_test/core/constants/enums.dart';

// opperation controller
class HandleOperationController extends GetxController {
  Rx<OperationState> operationState = OperationState.none.obs;
  RxString errorMessage = ''.obs;
  RxString successMessage = ''.obs;

  // Show error message and update operation state
  void showError(String message) {
    operationState.value = OperationState.error;
    errorMessage.value = message;
    update();
  }

  // Reset the controller state
  void resetState() {
    operationState.value = OperationState.none;
    errorMessage.value = '';
    successMessage.value = '';
    update();
  }

  // Show success message and update operation state
  void showSuccess(String message) {
    operationState.value = OperationState.success;
    successMessage.value = message;
    update();
  }
}
