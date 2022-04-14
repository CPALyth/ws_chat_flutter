import 'package:ws_chat_flutter/common/models/user.dart';
import 'package:ws_chat_flutter/common/utils/http.dart';

// 用户接口
class UserAPI {
  static Future<UserLoginResponse> login({UserLoginRequest? data}) async {
    var response = await HttpUtil().post(
      '/user/login',
      data: data?.toJson(),
    );
    return UserLoginResponse.fromJson(response);
  }
}
