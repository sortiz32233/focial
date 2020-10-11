import 'dart:async';

import 'package:chopper/chopper.dart' show Response;
import 'package:focial/models/auth.dart';
import 'package:focial/services/api.dart';
import 'package:focial/services/finder.dart';
import 'package:focial/services/shared_prefs.dart';
import 'package:focial/utils/server_responses.dart' as sr;

enum AuthState { loggedIn, busy, loggedOut }

class AuthService {
  final api = find<APIService>().api;

  final StreamController<AuthState> _authStream = StreamController();

  Sink<AuthState> get _authStateSink => _authStream.sink;

  Stream<AuthState> get authState => _authStream.stream;

  Auth authData = Auth();

  Future<Auth> init() async {
    await SharedPrefs.init();
    final String accessToken = SharedPrefs.getString(sr.accessToken);
    final String refreshToken = SharedPrefs.getString(sr.refreshToken);
    authData = authData.copyWith(accessToken: accessToken, refreshToken: refreshToken);
    _authStateSink.add(authData.isLoggedIn ? AuthState.loggedIn : AuthState.loggedOut);

    return authData;
  }

  void dispose() {
    _authStream.sink.close();
    _authStream.close();
  }

  Future<Response> register({String name, String email, String password}) async {
    final response = await api.register(
      name: name,
      email: email,
      password: password,
    );
    return response;
  }

  Future<Response> login({String email, String password}) async {
    _authStateSink.add(AuthState.busy);
    final response = await api.login(
      email: email,
      password: password,
    );
    if (response.isSuccessful) {
      _authStateSink.add(AuthState.loggedIn);
    } else {
      _authStateSink.add(AuthState.loggedOut);
    }
    await storeAuthTokens(response.headers);
    return response;
  }

  Future<Response> resendAccountVerificationLink({String email, String password}) async {
    final response = await api.resendAccountVerifyLink(
      email: email,
      password: password,
    );
    return response;
  }

  Future<Response> sendPasswordResetCode(String email) async {
    final response = await api.sendPasswordResetCode(email: email);
    return response;
  }

  Future<Response> resendPasswordResetCode(String email) async {
    final response = await api.resendPasswordResetCode(email: email);
    return response;
  }

  Future<void> storeAuthTokens(Map<String, String> headers) async {
    authData = authData.copyWith(accessToken: headers[sr.accessToken], refreshToken: headers[sr.refreshToken]);
    await SharedPrefs.putString(sr.accessToken, authData.accessToken);
    await SharedPrefs.putString(sr.refreshToken, authData.refreshToken);
  }
}
