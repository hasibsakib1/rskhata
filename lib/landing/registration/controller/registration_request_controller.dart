
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api.dart';
import '../../../main.dart';
import '../../common/otp_screen.dart';
import '../model/registration_request_model.dart';

final registrationControllerProvider =
    StateNotifierProvider<RegistrationRequestController, int>((ref) {
  return RegistrationRequestController();
});

class RegistrationRequestController extends StateNotifier<int> {
  RegistrationRequestController() : super(0);

  void registrationRequest(BuildContext context, RegistrationRequestModel registration) async {
    log.i(registration.businessTypeId);
    final regInfo = FormData.fromMap({
      'phone': registration.phone,
      'email': registration.email,
      'name': registration.name,
      'business_name': registration.businessName,
      'business_type_id': registration.businessTypeId,
    });

    // for (var field in regInfo.fields) {
    //   print('${field.key}: ${field.value}');
    // }
    try {
      final response = await dio.post(registrationApi, data: regInfo);
      final data = response.data;
      log.i(data);
      if (data['status'] == 200) {
        state = data['identifier_id'] ?? 0;
        Navigator.push(context, MaterialPageRoute(builder: (context) => OtpScreen(phoneOrIdentifier: state.toString(), isLogin: false,)));
      } else {
        throw Exception('Failed to register');
      }
    } catch (e) {
      log.e(e);
    }
  }
}
