import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rskhata/core/shared_pref.dart';

import '../../../core/api.dart';
import '../../../dashboard/homepage.dart';
import '../../../main.dart';
import '../model/login_success_model.dart';

final loginOtpControllerProvider =
    StateNotifierProvider<LoginOtpController, LoginSuccessModel?>((ref) {
  return LoginOtpController();
});

class LoginOtpController extends StateNotifier<LoginSuccessModel?> {
  LoginOtpController() : super(null);

  void verifyLoginOtp(
      BuildContext context, String identifier, String otp) async {
    final loginOtp =
        FormData.fromMap({'identifier': identifier, 'otp_code': otp});

    for (var field in loginOtp.fields) {
      print('${field.key}: ${field.value}');
    }
    try {
      final response = await dio.post(loginApi, data: loginOtp);
      log.i(response.data);
      final data = response.data;
      if (data['status'] == 200) {
        final userInfo = LoginSuccessModel.fromJson(data['user']);
        state = userInfo;
        log.i(userInfo.apiToken!);
        SharedPref.setString("api_key", userInfo.apiToken!);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomePage()),
            (route) => false);
      } else {
        throw Exception('Failed to verify OTP');
      }
    } catch (e) {
      log.e(e);
    }
  }
}
