import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:watt_test/core/api/base_url.dart';
import 'package:watt_test/core/api/exceptions.dart';
import 'package:watt_test/core/constants/enums.dart';
import 'package:watt_test/core/service_locator/service_locator.dart';

class BaseApiService extends GetConnect {
  final session = ServiceLocator.globalSession;

  /// Make API requests based on the specified parameters.
  Future<Response<Map<String, dynamic>>?> goApi({
    required String url,
    required ApiMethod method,
    Map<String, dynamic>? params,
    Map<String, String>? header,
  }) async {
    try {
      Response<Map<String, dynamic>>? response;

      switch (method) {
        case ApiMethod.fetch:
          response = await get<Map<String, dynamic>>(
            url,
            query: params,
            headers: header,
          );
          break;
        case ApiMethod.post:
          response = await post<Map<String, dynamic>>(
            url,
            params,
            headers: header,
          );
          break;
        case ApiMethod.put:
          response = await put<Map<String, dynamic>>(
            url,
            params,
            headers: header,
          );
          break;
        case ApiMethod.delete:
          response = await delete(url);
          break;
        default:
      }

      // Check for connection errors
      if (response?.status.connectionError ?? false) {
        throw ApiNotRespondingException(response?.body?["message"] ??
            "There is a connection error, please try again later");
      }

      return handleStatus(response);
    } on SocketException {
      // Handle socket exceptions
      throw ApiNotRespondingException("Api did not respond in time");
    } on TimeoutException {
      // Handle timeout exceptions
      throw ApiNotRespondingException("Api did not respond in time");
    }
  }

  /// Handle API response status and throw appropriate exceptions.
  Response<Map<String, dynamic>>? handleStatus(
    Response<Map<String, dynamic>>? response,
  ) {
    switch (response?.statusCode) {
      case 200:
      case 201:
      case 202:
      case 203:
        return response;
      case 400:
      case 422:
        // Throw exception for invalid input
        throw InvalidInputException(
            response?.body?["message"] ?? "Wrong input data");
      case 401:
      case 403:
        // Throw exception for unauthorized access
        throw UnauthorisedException(response?.body?["message"] ??
            "Session Expired, please login again");
      case 500:
        // Throw exception for server error
        throw FetchDataException(response?.body?["message"] ??
            "There is a server error, please try again later");
      default:
        // Throw exception for unknown errors
        throw FetchDataException(response?.body?["message"] ??
            "There is a server error, please try again later");
    }
  }

  @override
  void onInit() {
    httpClient.baseUrl = BaseUrl.devServer;
    httpClient.defaultContentType = 'application/json';

    // Add a response modifier to inspect responses
    httpClient.addResponseModifier<dynamic>((request, response) async {
      inspect(response);
      return response;
    });

    // Add a request modifier to set common headers
    httpClient.addRequestModifier<void>((request) async {
      request.headers.addAll({
        'Accept': 'application/json',
        'Authorization': 'Bearer ${session.getToken()}',
        'locale': 'en',
        'type': 'mobile',
      });

      return request;
    });

    // Add an authenticator to include authorization headers
    httpClient.addAuthenticator<void>((request) async {
      request.headers.addAll({'Authorization': 'Bearer ${session.getToken()}'});
      return request;
    });

    super.onInit();
  }
}
