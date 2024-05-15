import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api.dart';
import '../../../core/shared_pref.dart';
import '../../../dashboard/homepage.dart';
import '../../../main.dart';
import '../model/login_success_model.dart';
import 'login_otp.dart';

final registrationOtpControllerProvider =
    StateNotifierProvider<RegistrationOtpController, String?>((ref) {
  return RegistrationOtpController();
});

class RegistrationOtpController extends StateNotifier<String?> {
  RegistrationOtpController() : super(null);

  void verifyRegistrationOtp(BuildContext context, String identifier, String otp) async {
    final providerContainer = ProviderContainer();

    final regOtp =
        FormData.fromMap({'identifier_id': identifier, 'otp_code': otp});

    for (var field in regOtp.fields) {
      print('${field.key}: ${field.value}');
    }
    try {
      final response = await dio.post(registrationOtpApi, data: regOtp);
      log.i(response.data);
      final data = response.data;
      if (data['status'] == 200) {
        final apiToken = data['response_user']['api_token'];
        log.i(apiToken);
        state = apiToken;
        final userInfo = LoginSuccessModel.fromJson(data['response_user']);
        SharedPref.setString("api_key", userInfo.apiToken!);
        providerContainer.read(loginOtpControllerProvider.notifier).state = userInfo;
        log.i(providerContainer.read(loginOtpControllerProvider));
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false);
      } else {
        throw Exception('Failed to verify OTP');
      }
    } catch (e) {
      log.e(e);
    } finally {
      providerContainer.dispose();
    }
  }
}
