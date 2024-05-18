import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rskhata/customer/controller/supplier_list_controller.dart';

import '../../core/api.dart';
import '../../core/networking/request_base.dart';
import '../../main.dart';
import '../model/customer_create_model.dart';
import 'customer_list_controller.dart';

final customerAddUpdateControllerProvider = StateNotifierProvider<CustomerAddUpdateController, dynamic>((ref) => CustomerAddUpdateController());

class CustomerAddUpdateController extends StateNotifier<dynamic> {
  CustomerAddUpdateController(): super([]);

  final RequestBase requestBase = RequestBase();

  Future<void> createCustomer(WidgetRef ref, CustomerCreateModel newCustomer, {required int branchId}) async {
    FormData formData = FormData.fromMap({
      'name': newCustomer.name,
      'phone':  newCustomer.phone,
      'email': newCustomer.email,
      'type': newCustomer.type,
      'address': newCustomer.address,
      'area': newCustomer.area,
      'post_code': newCustomer.postCode,
      'city':   newCustomer.city,
      'state':  newCustomer.state,
      'account_name[]':   newCustomer.accountName,
      'account_number[]': newCustomer.accountNumber,
    });

    try {
      final response = await requestBase.post(
          createCustomerApi(branchId: branchId), formData);
      if (response.statusCode == 200) {
        await ref.read(customerListControllerProvider.notifier).getCustomerList(branchId: branchId);
        await ref.read(supplierListControllerProvider.notifier).getSupplierList(branchId: branchId);
      } else {
        throw Exception('Failed to create customer');
      }
    } catch (e) {
      log.i(e);
    }
  }

  Future<void> updateCustomer(WidgetRef ref, CustomerCreateModel newCustomer, {required int branchId, required int customerId}) async {
    FormData formData = FormData.fromMap({
      'name': newCustomer.name,
      'phone':  newCustomer.phone,
      'email': newCustomer.email,
      'type': newCustomer.type,
      'address': newCustomer.address,
      'area': newCustomer.area,
      'post_code': newCustomer.postCode,
      'city':   newCustomer.city,
      'state':  newCustomer.state,
      'account_name[]':   newCustomer.accountName,
      'account_number[]': newCustomer.accountNumber,
    });

    try {
      final response = await requestBase.post(
          updateCustomerApi(branchId: branchId, customerId: customerId), formData);
      if (response.statusCode == 200) {
        await ref.read(customerListControllerProvider.notifier).getCustomerList(branchId: branchId);
        await ref.read(supplierListControllerProvider.notifier).getSupplierList(branchId: branchId);
      } else {
        throw Exception('Failed to update customer');
      }
    } catch (e) {
      log.i(e);
    }
  }
  
}