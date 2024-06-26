import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'controller/login_otp.dart';
import 'controller/registration_otp.dart';

class OtpScreen extends ConsumerWidget {
  final String phoneOrIdentifier;
  final bool isLogin;

  OtpScreen({super.key, required this.phoneOrIdentifier, this.isLogin = true});

  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: otpController,
              keyboardType: TextInputType.phone,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              maxLength: 6,
              decoration: const InputDecoration(
                  labelText: 'OTP',
                  hintText: 'Enter the OTP sent to your phone',
                  counterText: '',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  )),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                isLogin ?
                ref.read(loginOtpControllerProvider.notifier).verifyLoginOtp(context, phoneOrIdentifier, otpController.text) :
                ref.read(registrationOtpControllerProvider.notifier).verifyRegistrationOtp(context, ref, phoneOrIdentifier, otpController.text);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(150),
                foregroundColor: Theme.of(context).colorScheme.secondary,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Submit'),
            ),
          )
        ],
      ),
    );
  }
}
