import 'dart:convert';

import 'package:get/get.dart';
import 'package:watt_test/core/api/api_provider.dart';
import 'package:watt_test/core/api/handle_exception.dart';
import 'package:watt_test/core/constants/enums.dart';
import 'package:watt_test/core/service_locator/service_locator.dart';
import 'package:watt_test/features/auth/model/user_model.dart';

class AuthService with BaseHandleApi {
  // Get an instance of the API service through dependency injection
  final apiService = Get.find<BaseApiService>();

  // Login with username and password
  Future<UserModel?> login(String username, String password) async {
    try {
      // Make an API request to authenticate the user
      var response = await apiService.goApi(
        url: "auth/login",
        method: ApiMethod.post,
        params: {
          "username": username,
          "password": password,
        },
      ).catchError(
        handleError,
      ); // Use catchError to handle errors and show error messages

      if (response?.body != null) {
        // Save user information in the session
        await ServiceLocator.globalSession.setUser(jsonEncode(response?.body));

        // Return the user model parsed from the API response
        return UserModel.fromJson(response!.body!);
      } else {
        // Return null if the response body is empty
        return null;
      }
    } catch (e) {
      // Return null if an exception occurs during the login process
      return null;
    }
  }
}
