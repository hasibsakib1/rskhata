import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/api.dart';
import '../../core/networking/request_base.dart';
import '../../main.dart';
import '../model/customer_list_model.dart';


final supplierListControllerProvider = StateNotifierProvider<SupplierListController, List<CustomerListModel>>((ref) => SupplierListController());

class SupplierListController extends StateNotifier<List<CustomerListModel>>{
  SupplierListController(): super([]);

  final RequestBase requestBase = RequestBase();

  Future<void> getSupplierList({required int branchId}) async{
    try {
      final response = await requestBase.get(getCustomersApi(branchId: branchId, customerType: 1));
      if(response.statusCode == 200) {
        final data = response.data['customers']['customers'];
        print(data);
        final supplierList = data.map<CustomerListModel>((e) => CustomerListModel.fromJson(e)).toList();
        print(supplierList);
        state = supplierList;
      } else {
        throw Exception('Failed to load customer list');
      }
    } catch(e) {
      log.i(e);
    }
  }

  void deleteSupplier({ required int branchId ,required int customerId}) async{
    try {
      final response = await requestBase.delete(deleteCustomerApi(branchId: branchId, customerId: customerId));
      if(response.statusCode == 200) {
        final data = response.data;
        print(data);
        getSupplierList(branchId: branchId);
      } else {
        throw Exception('Failed to delete customer');
      }
    } catch(e) {
      log.i(e);
    }
  }
  
}

