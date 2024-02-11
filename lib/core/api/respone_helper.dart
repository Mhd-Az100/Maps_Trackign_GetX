class ResponseHelper {
  static List<T> handleListResponse<T>(
      List<dynamic>? data, T Function(Map<String, dynamic>) fromJsonData) {
    List<T> resultList = <T>[];

    if (data != null) {
      resultList = data.map((e) => fromJsonData(e)).toList();
    }

    return resultList;
  }
}
