abstract class GlobalSession {
  Future<String?> getToken();
  String? getUser();
  Future<void> clearSessions();
  //========================
  Future<void> setToken(String token);
  void setUser(String userJson);
}
