class EndPoints {
  static const String baseUrl = "https://fixflex.onrender.com/api/v1/";
  static const String login = "auth/login";
  static const String register = "auth/signup";
  static const String logout = "auth/logout";
  static const String users = "users";
  static const String categories = "categories";
  static const String tasks = "tasks";
  static String deleteTask({required String id}) => "$tasks/$id";
  static String getTask({required String id}) => "$tasks/$id";
  static String getUserData({required String id}) => "$users/$id";
}
