import 'dart:async';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:focial/api/urls.dart';
import 'package:focial/services/auth.dart';
import 'package:focial/services/finder.dart';

part 'api.chopper.dart';

final auth = find<AuthService>();

@ChopperApi()
abstract class FocialAPI extends ChopperService {
  /// auth apis
  @Post(path: Urls.register)
  Future<Response<dynamic>> register({@Field() String name, @Field() String email, @Field() String password});

  @Post(path: Urls.login)
  Future<Response<dynamic>> login({@Field() String email, @Field() String password});

  @Post(path: Urls.resendAccVerificationLink)
  Future<Response<dynamic>> resendAccountVerifyLink({@Field() String email, @Field() String password});

  @Patch(path: Urls.updatePassword)
  Future<Response<dynamic>> updatePassword({@Field() String oldPassword, @Field() String newPassword});

  @Post(path: Urls.sendPasswordResetCode)
  Future<Response<dynamic>> sendPasswordResetCode({@Field() String email});

  @Post(path: Urls.resendPasswordResetCode)
  Future<Response<dynamic>> resendPasswordResetCode({@Field() String email});

  @Post(path: Urls.resetPassword)
  Future<Response<dynamic>> resetPassword({@Field() String email, @Field() String otp, @Field() String password});

  @Get(path: Urls.user)
  Future<Response<dynamic>> getUser();

  @Patch(path: Urls.user)
  Future<Response<dynamic>> updateUser(@body Map<String, dynamic> body);

  @Get(path: "${Urls.checkUsername}{username}")
  Future<Response<dynamic>> checkUsername(@Path() String username);

  @Post(path: Urls.uploadProfilePicture)
  @multipart
  Future<Response> uploadProfilePicture(@PartFile("file") String file);

  @Post(path: Urls.uploadCoverPicture)
  @multipart
  Future<Response> uploadCoverPicture(@PartFile("file") String file);

  @Get(path: Urls.story)
  Future<Response<dynamic>> getStoryFeed();

  @Post(path: Urls.story)
  Future<Response<dynamic>> newStory(@body Map<String, dynamic> body);

  @Post(path: Urls.post)
  Future<Response<dynamic>> newPost(@body Map<String, dynamic> body);

  @Post(path: Urls.postImageUpload)
  @multipart
  Future<Response> uploadPostImage(@PartFile("file") String file);

  @Get(path: Urls.post)
  Future<Response<dynamic>> getPosts();

  static FocialAPI create() {
    final client = ChopperClient(
        baseUrl: Urls.baseUrl,
        services: [
          _$FocialAPI(),
        ],
        interceptors: [HttpLoggingInterceptor(), HeadersInterceptor()],
        converter: const JsonConverter());
    return _$FocialAPI(client);
  }
}

class HeadersInterceptor extends RequestInterceptor {
  @override
  FutureOr<Request> onRequest(Request request) {
    final headers = {
      "Content-Type": "application/json",
    };

    print(auth.authData.accessToken);
    // print(request.body);
    headers.addAll({HttpHeaders.authorizationHeader: "Bearer ${auth.authData.accessToken}"});

    return request.copyWith(headers: headers);
  }
}
