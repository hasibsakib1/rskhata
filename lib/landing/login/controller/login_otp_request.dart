import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api.dart';
import '../../../main.dart';
import '../../common/otp_screen.dart';

final loginOtpRequestProvider = StateNotifierProvider<LoginOtpRequest, void>((ref) {
  return LoginOtpRequest();
});

class LoginOtpRequest extends StateNotifier<void> {
  LoginOtpRequest() : super(null);

  void loginOtpRequest(BuildContext context, String phone) async {

    final loginIdentifier = FormData.fromMap({
      'identifier': phone,
    });

    try{
      final response = await dio.post(loginOtpApi, data: loginIdentifier);
      log.i(response.data);
      final data = response.data;
      if(data['status'] == 200){
        Navigator.push(context, MaterialPageRoute(builder: (context) => OtpScreen(phoneOrIdentifier: phone)));
      } else {
        throw Exception('Failed to send OTP');
      }
    } catch(e){
      log.e(e);
    }
  } 
}