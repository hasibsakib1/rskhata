import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rskhata/core/networking/request_base.dart';

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
      final response = await requestBase.get("admin/branches");
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
}
