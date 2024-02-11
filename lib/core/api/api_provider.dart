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

      if (response?.status.connectionError ?? false) {
        throw ApiNotRespondingException(response?.body?["message"] ??
            "There is connection error, please try again later");
      }

      return handleStatus(response);
    } on SocketException {
      throw ApiNotRespondingException("Api not responded in time");
    } on TimeoutException {
      throw ApiNotRespondingException("Api not responded in time");
    }
  }

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
        throw InvalidInputException(
            response?.body?["message"] ?? "Wrong in inputed data");
      case 401:
      case 403:
        throw UnauthorisedException(response?.body?["message"] ??
            "Session Expired, please login again");
      case 500:
        throw FetchDataException(response?.body?["message"] ??
            "There is server error, please try again later");
      default:
        throw FetchDataException(response?.body?["message"] ??
            "There is server error, please try again later");
    }
  }

  //
  @override
  void onInit() {
    httpClient.baseUrl = BaseUrl.devServer;
    httpClient.defaultContentType = 'application/json';
    //
    httpClient.addResponseModifier<dynamic>(
        (dynamic request, Response<dynamic> response) async {
      inspect(response);
      return response;
    });
    //
    httpClient.addRequestModifier<void>((request) async {
      request.headers.addAll({
        'Accept': 'application/json',
        'Authorization': 'Bearer ${session.getToken()}',
        'locale': 'en',
        'type': 'mobile',
      });

      return request;
    });
    //
    httpClient.addAuthenticator<void>((request) async {
      request.headers.addAll({'Authorization': 'Bearer ${session.getToken()}'});
      return request;
    });

    super.onInit();
  }
}
