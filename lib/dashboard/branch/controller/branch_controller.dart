import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api.dart';
import '../../../core/networking/request_base.dart';
import '../../../main.dart';
import '../model/branch_model.dart';

final branchControllerProvider =
    StateNotifierProvider<BranchController, List<BranchModel>>(
        (ref) => BranchController());

class BranchController extends StateNotifier<List<BranchModel>> {
  BranchController() : super([]);

  RequestBase requestBase = RequestBase();

  void getBranchList() async {
    try {
      final response = await requestBase.get(getBranchesApi);
      if (response.statusCode == 200) {
        final data = response.data['branches']['branches'];
        final branches = data.map<BranchModel>((e) => BranchModel.fromJson(e)).toList();
        state = branches;
      } else {
        throw Exception('Failed to load branches');
      }
    } on Exception catch (e) {
      log.e(e);
    }
  }

  void createBranch(String name) async {

    final newBranchName = FormData.fromMap(
      {"name": name}
    );

    try {
      final response = await requestBase.post(createBranchApi, newBranchName);
      if (response.statusCode == 200) {
        // final data = response.data['branches']['branches'];
        // final branches = data.map<BranchModel>((e) => BranchModel.fromJson(e)).toList();
        // state = branches;
        getBranchList();
      } else {
        throw Exception('Failed to create branch');
      }
    } on Exception catch (e) {
      log.e(e);
    }
  }

  void updateBranch(int id, String name) async {
    final updatedBranchName = FormData.fromMap(
      {"name": name}
    );

    try {
      final response = await requestBase.post(updateBranchApi(id), updatedBranchName);
      if (response.statusCode == 200) {
        getBranchList();
      } else {
        throw Exception('Failed to update branch');
      }
    } on Exception catch (e) {
      log.e(e);
    }
  }

  void deleteBranch(int id) async {
    try {
      final response = await requestBase.delete(deleteBranchApi(id));
      if (response.statusCode == 200) {
        getBranchList();
      } else {
        throw Exception('Failed to delete branch');
      }
    } on Exception catch (e) {
      log.e(e);
    }
  }

}
