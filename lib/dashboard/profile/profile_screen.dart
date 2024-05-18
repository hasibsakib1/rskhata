import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rskhata/dashboard/profile/update_profile.dart';

import 'controller/profile_controller.dart';
import 'model/profile_model.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {

  ProfileModel? profile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
  }

  void getProfile() {
    ref.read(profileControllerProvider.notifier).getProfile();
  }

  @override
  Widget build(BuildContext context) {

    setState(() {
      profile = ref.watch(profileControllerProvider);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${profile?.name}'),
            Text('Email: ${profile?.email}'),
            Text('Mobile: ${profile?.phone}'),
            Text('Business Type: ${profile?.businessType}'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateProfile())).then((value){
            setState(() {
              profile = ref.watch(profileControllerProvider);
            });
          });
        },
        child: const Icon(Icons.edit),
      )
    );
  }
}