import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rskhata/utils/number_validator.dart';

import '../../utils/show_snackbar.dart';
import 'controller/registration_request_controller.dart';
import 'controller/business_type_controller.dart';
import 'model/registration_request_model.dart';

class RegistrationPage extends ConsumerStatefulWidget {
  const RegistrationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegistrationPageState();
}

class _RegistrationPageState extends ConsumerState<RegistrationPage> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController businessNameController = TextEditingController();
  int? businessTypeId;

  @override
  Widget build(BuildContext context) {
    final businessTypes = ref.watch(businessTypeProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
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
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      labelText: 'Name',
                      hintText: 'Enter your name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      )),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: businessNameController,
                  decoration: const InputDecoration(
                      labelText: 'Business Name',
                      hintText: 'Enter your business name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      )),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                      labelText: 'Business Type',
                      hintText: 'Enter your business type',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      )),
                  items: [
                    for (var businessType in businessTypes)
                      DropdownMenuItem(
                        value: businessType.id,
                        child: Text(businessType.name),
                      ),
                  ],
                  onChanged: (value) {
                    businessTypeId = value;
                  },
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    numberValidator(phoneController.text)?
                      ref.read(registrationControllerProvider.notifier).registrationRequest( context,
                          RegistrationRequestModel(
                            phone: phoneController.text,
                            email: emailController.text,
                            name: nameController.text,
                            businessName: businessNameController.text,
                            businessTypeId: businessTypeId ?? 0,
                          ),
                        )
                      : showSnackBar(context, 'Invalid phone number');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.primary.withAlpha(150),
                    foregroundColor: Theme.of(context).colorScheme.secondary,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Register'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
