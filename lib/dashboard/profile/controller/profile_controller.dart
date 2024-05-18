import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rskhata/landing/landing_page.dart';


import '../../../core/api.dart';
import '../model/profile_model.dart';
import '../../../core/networking/request_base.dart';
import '../../../main.dart';

final profileControllerProvider = StateNotifierProvider<ProfileController, ProfileModel?>((ref) {
  return ProfileController();
});

class ProfileController extends StateNotifier<ProfileModel?> {
  ProfileController(): super(null);

  final RequestBase requestBase = RequestBase();

  Future<void> getProfile() async {
    try {
      final response = await requestBase.get(profileApi);
      if (response.statusCode == 200) {
        final data = response.data['response_user'];
        final profile = ProfileModel.fromJson(data);
        state = profile;
      } else {
        throw Exception('Failed to get profile');
      }
    } catch (e) {
      log.i(e);
    }
  }

  Future<void> updateProfile(String name, int businessTypeId) async {
    FormData formData = FormData.fromMap({
      'name': name,
      'business_type_id': businessTypeId,
    });
    try {
      final response = await requestBase.post(profileUpdateApi, formData);
      if (response.statusCode == 200) {
        await getProfile();
      } else {
        throw Exception('Failed to update profile');
      }
    } catch (e) {
      log.i(e);
    }
  }

  Future<void> deleteProfile(BuildContext context) async {
    try {
      final response = await requestBase.delete(deleteProfileApi);
      if (response.statusCode == 200) {
        state = null;
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> LandingPage()), (route) => false);
      } else {
        throw Exception('Failed to delete profile');
      }
    } catch (e) {
      log.i(e);
    }
  }
  
}