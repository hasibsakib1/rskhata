import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'controller/customer_add_update_controller.dart';
import 'model/customer_create_model.dart';
import '../utils/number_validator.dart';
import '../utils/show_snackbar.dart';


class CustomerAddUpdateScreen extends ConsumerWidget {
  CustomerAddUpdateScreen(
      {super.key, required this.branchId, this.isEdit = false, this.customerId});

  final int branchId;
  final bool isEdit;
  final int? customerId;


  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController postCodeController = TextEditingController();
  final TextEditingController accountNameController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int customerType = 0;
    return Scaffold(
      appBar: AppBar(
        title: isEdit
            ? const Text("Update Customer/Supplier")
            : const Text("Create Customer/Supplier"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                    labelText: 'Name',
                    hintText: 'Enter name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                maxLength: 11,
                decoration: const InputDecoration(
                    labelText: 'Phone',
                    hintText: 'Enter phone',
                    counterText: '',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
              ),
            ),
            // Container(
            //   padding: const EdgeInsets.all(10),
            //   child: TextFormField(
            //     controller: typeController,
            //     decoration: const InputDecoration(
            //         labelText: 'Type',
            //         hintText: 'Enter type',
            //         border: OutlineInputBorder(
            //           borderRadius: BorderRadius.all(Radius.circular(10)),
            //         )),
            //   ),
            // ),
            Container(
              padding: const EdgeInsets.all(10),
              child: DropdownButtonFormField(
                decoration: const InputDecoration(
                    labelText: 'Customer Type',
                    hintText: 'Enter type',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
                value: customerType,
                onChanged: (int? value) {
                  customerType = value!;
                },
                items: const [
                  DropdownMenuItem(
                    value: 0,
                    child: Text("Customer"),
                  ),
                  DropdownMenuItem(
                    value: 1,
                    child: Text("Supplier"),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: addressController,
                decoration: const InputDecoration(
                    labelText: 'Address',
                    hintText: 'Enter address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: areaController,
                decoration: const InputDecoration(
                    labelText: 'Area',
                    hintText: 'Enter area',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: cityController,
                decoration: const InputDecoration(
                  labelText: 'City',
                  hintText: 'Enter city',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: postCodeController,
                decoration: const InputDecoration(
                  labelText: 'Post Code',
                  hintText: 'Enter post code',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
            // Container(
            //   padding: const EdgeInsets.all(10),
            //   child: TextFormField(
            //     decoration: const InputDecoration(
            //       labelText: 'State',
            //       hintText: 'Enter state',
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.all(Radius.circular(10)),
            //       ),
            //     ),
            //   ),
            // ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: accountNameController,
                decoration: const InputDecoration(
                  labelText: 'Account Name',
                  hintText: 'Enter account name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: accountNumberController,
                decoration: const InputDecoration(
                  labelText: 'Account Number',
                  hintText: 'Enter account number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
            // Container(
            //   padding: const EdgeInsets.all(10),
            //   child: TextFormField(
            //     decoration: const InputDecoration(
            //       labelText: 'Routing Number',
            //       hintText: 'Enter routing number',
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.all(Radius.circular(10)),
            //       ),
            //     ),
            //   ),
            // ),
            // Container(
            //   padding: const EdgeInsets.all(10),
            //   child: TextFormField(
            //     decoration: const InputDecoration(
            //       labelText: 'Swift Code',
            //       hintText: 'Enter swift code',
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.all(Radius.circular(10)),
            //       ),
            //     ),
            //   ),
            // ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () async{
                  if (numberValidator(phoneController.text)) {
                    final customer = CustomerCreateModel(
                      name: nameController.text,
                      phone: phoneController.text,
                      email: emailController.text,
                      type: customerType.toString(),
                      address: addressController.text,
                      area: areaController.text,
                      postCode: postCodeController.text,
                      city: cityController.text,
                      accountName: accountNameController.text,
                      accountNumber: accountNumberController.text,
                    );
                    isEdit
                    ? await ref.read(customerAddUpdateControllerProvider.notifier).updateCustomer(ref, customer, branchId: branchId, customerId: customerId!)
                    : await ref.read(customerAddUpdateControllerProvider.notifier).createCustomer(ref, customer, branchId: branchId);

                  } else {
                    showSnackBar(context, "Invalid Phone Number");
                  }

                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.primary.withAlpha(150),
                  foregroundColor: Theme.of(context).colorScheme.secondary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: isEdit
                    ? const Text("Update Customer/Supplier")
                    : const Text("Create Customer/Supplier"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
