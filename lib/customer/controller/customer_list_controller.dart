import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/api.dart';
import '../../core/networking/request_base.dart';
import '../../main.dart';
import '../model/customer_list_model.dart';

final customerListControllerProvider =
    StateNotifierProvider<CustomerListController, List<CustomerListModel>>(
        (ref) => CustomerListController());

class CustomerListController extends StateNotifier<List<CustomerListModel>> {
  CustomerListController() : super([]);

  final RequestBase requestBase = RequestBase();

  Future<void> getCustomerList({required int branchId}) async {
    try {
      final response = await requestBase
          .get(getCustomersApi(branchId: branchId, customerType: 0));
      if (response.statusCode == 200) {
        final data = response.data['customers']['customers'];
        final customerList = data
            .map<CustomerListModel>((e) => CustomerListModel.fromJson(e))
            .toList();
        state = customerList;
      } else {
        throw Exception('Failed to load customer list');
      }
    } catch (e) {
      log.i(e);
    }
  }

  void deleteCustomer({required int branchId, required int customerId}) async {
    try {
      final response = await requestBase.delete(
          deleteCustomerApi(branchId: branchId, customerId: customerId));
      if (response.statusCode == 200) {
        getCustomerList(branchId: branchId);
      } else {
        throw Exception('Failed to delete customer');
      }
    } catch (e) {
      log.i(e);
    }
  }

  
}
