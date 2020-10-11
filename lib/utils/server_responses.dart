import 'dart:convert';

import 'package:chopper/chopper.dart';

const String token = "token";
const String accessToken = "access_token";
const String refreshToken = "refresh_token";
const String email = "email";
const String password = "password";
const String expired = "Expired";
const String expire = "expire";
const String message = "message";

class ServerResponse {
  static String getMessage(Response response) {
    return response.isSuccessful ? response.body[message].toString() : json.decode(response.error.toString())[message].toString();
  }
}
