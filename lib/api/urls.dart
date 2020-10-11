class Urls {
  final url = '';
  // static const BASE_URL = "https://focial1.herokuapp.com/api/v1";

  static const baseUrl = "http://10.0.2.2:7000/api/v1";

  static final assetsBase = baseUrl.replaceAll("api/v1", "");

  ///-------------------- Register and login
  static const String register = "auth/register";
  static const String login = "auth/login";
  static const String fcmId = "auth/fcm/token";
  static const String facebookAuth = "auth/fb";
  static const String googleAuth = "auth/google";
  static const String resendAccVerificationLink = "auth/token/resend";

  ///-------------------- password
  static const String sendPasswordResetCode = "auth/password/reset/code";
  static const String resendPasswordResetCode = "auth/password/reset/code/resend";
  static const String resetPassword = "auth/password/reset";
  static const String updatePassword = "auth/password";

  /// Refresh token
  static const String token = "auth/token";

  static const String user = "user";
  static const String checkUsername = "user/check/";
  static const String uploadProfilePicture = "user/pp";
  static const String uploadCoverPicture = "user/cover";

  static const String story = "story";
  static const String post = "post";
  static const String postImageUpload = "post/image";
}
