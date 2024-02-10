//
class JsonResponse {
  bool? status;
  dynamic code;
  String? message;
  dynamic data;
  dynamic pagination;
  //
  JsonResponse({
    this.status,
    this.code,
    this.message,
    this.data,
    this.pagination,
  });
  //
  factory JsonResponse.fromJson(json) {
    return JsonResponse(
      status: json?['status'] ?? false,
      pagination: json?['pagination'],
      code: json?['code'] ?? 200,
      message: json?['message'] as String?,
      data: json?['data'] ?? [],
    );
  }
  //
}
