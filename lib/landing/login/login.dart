import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rskhata/utils/number_validator.dart';

import '../../utils/show_snackbar.dart';
import 'controller/login_otp_request.dart';


class LoginPage extends ConsumerWidget {
  LoginPage({super.key});

  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              maxLength: 11,
              decoration: const InputDecoration(
                labelText: 'Phone',
                hintText: 'Enter your phone number',
                counterText: '',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                )
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                numberValidator(phoneController.text)?
                 ref.read(loginOtpRequestProvider.notifier).loginOtpRequest(context, phoneController.text) : 
                 showSnackBar(context, 'Invalid phone number');
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
              child: const Text('Login'),
            ),
          )
        ],
      )
    );
  }
}