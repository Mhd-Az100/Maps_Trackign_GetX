import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'api_response.dart';

enum Method { post, get, put, delete, patch }

class BaseApiService extends GetConnect {
  Future<JsonResponse?> goApi({
    required String url,
    required Method method,
    Map<String, dynamic>? params,
    Map<String, String>? header,
    bool? showDialog,
  }) async {
    //
    Response<JsonResponse>? response;
    //
    switch (method) {
      //
      case Method.get:
        //
        response = await get<JsonResponse>(
          url,
          query: params,
          headers: header,
        );

        break;
      //
      case Method.post:
        response = await post<JsonResponse>(
          url,
          params,
          headers: header,
        );

        break;

      case Method.put:
        response = await put<JsonResponse>(
          url,
          params,
          headers: header,
        );

        break;

      case Method.delete:
        response = await delete(url);
        break;

      default:
    }
    response?.body?.code = response.statusCode;
    //
    if (response?.status.connectionError ?? false) {
      return JsonResponse(
          message: response?.body?.message ?? "No Internet !!!");
    }
    //
    if (showDialog ?? false) {
      switch (response?.statusCode) {
        case 200:
        case 201:
        case 202:
          // return response;
          if (response?.body?.status == false) {
            methodDialog(response?.body?.message ?? "retry again");
            return null;
          } else {
            return response?.body;
          }
        case 400:
          methodDialog(response?.body?.message ?? "retry again");
          return JsonResponse(
              message: response?.body?.message ?? 'retry again', code: 400);
        case 401:
        case 403:
          methodDialog(
              response?.body?.message?.toString() ?? 'Session Expired');
          return JsonResponse(message: "Session Expired ", code: 401);
        case 500:
          methodDialog("Server Error");
          return JsonResponse(message: "Server Error");

        case 422:
          methodDialog(response?.body?.message ?? "wrong password");
          return JsonResponse(
              message: response?.body?.message ?? "wrong password", code: 422);
        default:
          methodDialog(response?.statusText ?? "retry again");
          return JsonResponse(message: response?.statusText ?? "retry again");
      }
    } else {
      switch (response?.statusCode) {
        case 200:
        case 201:
        case 202:
          return response?.body;
        case 401:
          return JsonResponse(message: "Session Expired", code: 401);
        case 400:
          return JsonResponse(
              message: response?.body?.message ?? 'retry again', code: 400);
        case 500:
          return JsonResponse(message: "Server Error");
        case 403:
          return JsonResponse(message: "No Internet !!");
        case 422:
        default:
          return JsonResponse(message: response?.statusText ?? "retry again");
      }
    }
    //
    //
  }

  //
  void methodDialog(String message) {
    // AwesomeDialog(
    //   context: Get.context!,
    //   dialogType: DialogType.error,
    //   headerAnimationLoop: false,
    //   animType: AnimType.topSlide,
    //   showCloseIcon: true,
    //   titleTextStyle: style25S.copyWith(color: darkgreyColor),
    //   buttonsTextStyle: style30S.copyWith(color: whiteColor),
    //   title: 'خطأ في العملية',
    //   desc: message,
    //   descTextStyle: style18M,
    //   onDismissCallback: (type) {},
    //   btnOkOnPress: () {
    //     Get.back();
    //   },
    //   btnOkText: "رجوع",
    //   btnOkColor: redColor,
    // ).show();
  }

  @override
  void onInit() {
    httpClient.defaultDecoder = JsonResponse.fromJson;
    httpClient.baseUrl = "https://numberone.warshatec.com/api/v1/";
    httpClient.defaultContentType = "application/json";
    httpClient.addResponseModifier<dynamic>(
        (dynamic request, Response<dynamic> response) async {
      inspect(response);
      return response;
    });

    httpClient.addRequestModifier<void>((request) async {
      request.headers.addAll({
        'Accept': "application/json",
        'Authorization': "Bearer ${GetStorage().read('token') ?? ''}"
      });
      request.headers['locale'] = 'en';
      request.headers['type'] = 'mobile';

      //
      return request;
    });
    //
    httpClient.addAuthenticator<void>((request) async {
      request.headers.addAll(
          {'Authorization': "Bearer ${GetStorage().read('token') ?? ''}"});
      request.headers['Authorization'] =
          "Bearer ${GetStorage().read('token') ?? ''}";
      log(GetStorage().read('token'));
      return request;
    });
    //

    super.onInit();
  }
  //
}
