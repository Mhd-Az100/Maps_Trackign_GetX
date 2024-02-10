//
class JsonResponse {
  bool? status;
  int? code;
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
      status: json?['status'],
      pagination: json?['pagination'],
      code: json?['code'] as int?,
      message: json?['message'] as String?,
      data: json?['data'],
    );
  }
  //
  Map<String, dynamic> toJson() =>
      {'status': status, 'code': code, 'message': message, 'data': data};
}
