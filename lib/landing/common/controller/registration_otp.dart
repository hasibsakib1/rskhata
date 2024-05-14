import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api.dart';
import '../../../main.dart';

final registrationOtpControllerProvider = StateNotifierProvider<RegistrationOtpController, String?>((ref) {
  return RegistrationOtpController();
});

class RegistrationOtpController extends StateNotifier<String?> {
  RegistrationOtpController(): super(null);

  void verifyRegistrationOtp(String identifier, String otp) async{

    final regOtp = FormData.fromMap({
      'identifier_id': identifier,
      'otp_code': otp
    });

    for (var field in regOtp.fields) {
      print('${field.key}: ${field.value}');
    }
    try{
      final response = await dio.post(registrationOtpApi, data: regOtp);
      log.i(response.data);
      final data = response.data;
      if(data['status'] == 200){
        final apiToken = data['data']['api_token'];
        state = apiToken;
      } else {
        throw Exception('Failed to verify OTP');
      }
    } catch(e){
      // log error
    }
  }
  
}