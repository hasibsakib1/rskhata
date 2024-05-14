import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api.dart';
import '../../../main.dart';
import '../model/login_success_model.dart';

final loginOtpControllerProvider = StateNotifierProvider<LoginOtpController, LoginSuccessModel?>((ref) {
  return LoginOtpController();
});

class LoginOtpController extends StateNotifier<LoginSuccessModel?> {
  LoginOtpController(): super(null);

  void verifyLoginOtp(String identifier, String otp) async{

    final loginOtp = FormData.fromMap({
      'identifier': identifier,
      'otp_code': otp
    });

    for (var field in loginOtp.fields) {
      print('${field.key}: ${field.value}');
    }
    try{
      final response = await dio.post(loginApi, data: loginOtp);
      log.i(response.data);
      final data = response.data;
      if(data['status'] == 200){
        final userInfo = LoginSuccessModel.fromJson(data['user']);
        state = userInfo;
      } else {
        throw Exception('Failed to verify OTP');
      }
    } catch(e){
      log.e(e);
    }
  }
  
}