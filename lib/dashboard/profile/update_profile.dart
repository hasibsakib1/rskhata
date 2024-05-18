import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rskhata/dashboard/profile/controller/profile_controller.dart';
import 'package:rskhata/landing/registration/model/business_type_model.dart';

import '../../landing/registration/controller/business_type_controller.dart';

class UpdateProfile extends ConsumerStatefulWidget {
  const UpdateProfile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends ConsumerState<UpdateProfile> {

  List<BusinessTypeModel> businessTypes = [];

  final TextEditingController nameController = TextEditingController();
  int businessTypeId = 1;


  getBusinessTypes() {
    ref.read(businessTypeProvider.notifier).fetchBusinessTypes();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBusinessTypes();
  }

  @override
  Widget build(BuildContext context) {

    setState(() {
      businessTypes = ref.watch(businessTypeProvider);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: 'Business Type',
                  border: OutlineInputBorder(),
                ),
                items: [
                  for (var businessType in businessTypes)
                      DropdownMenuItem(
                        value: businessType.id,
                        child: Text(businessType.name),
                      )
                    ],
                onChanged: (value) {
                  businessTypeId = value!;
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      ref.read(profileControllerProvider.notifier).updateProfile(nameController.text, businessTypeId);
                      Navigator.pop(context);
                    },
                    child: const Text('Update'),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                    onPressed: () {
                      showDialog(context: context, builder: (context) {
                        return AlertDialog(
                          title: const Text('Delete Profile'),
                          content: const Text('Are you sure you want to delete your profile?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all(Colors.red),
                              ),
                              onPressed: () {
                                ref.read(profileControllerProvider.notifier).deleteProfile(context);
                                Navigator.pop(context);
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        );
                      });
                    },
                    child: const Text('Delete Profile'),
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}