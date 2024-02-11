import 'package:get/get.dart';
import 'package:watt_test/core/api/api_provider.dart';
import 'package:watt_test/core/api/handle_exception.dart';
import 'package:watt_test/core/constants/enums.dart';
import 'package:watt_test/features/auth/model/user_model.dart';

class AuthService with BaseHandleApi {
  // get instance of api service by injection
  final apiService = Get.find<BaseApiService>();

  //login with username and password
  Future<UserModel?> login(String username, String password) async {
    try {
      var res = await apiService.goApi(
          url: "auth/login",
          method: ApiMethod.post,
          params: {
            "username": username,
            "password": password
          }).catchError(
          handleError); //use catchError to handle error and show error message
      if (res?.body != null) {
        return UserModel.fromJson(res!.body!);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
  //
}
