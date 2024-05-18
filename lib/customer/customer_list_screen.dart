import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../dashboard/branch/model/branch_model.dart';
import 'controller/customer_list_controller.dart';
import 'controller/supplier_list_controller.dart';
import 'customer_add_update_screen.dart';
import 'model/customer_list_model.dart';

class CustomerListScreen extends ConsumerStatefulWidget {
  const CustomerListScreen({super.key, required this.branch});

  final BranchModel branch;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomerListScreenState();
}

class _CustomerListScreenState extends ConsumerState<CustomerListScreen> {
  List<CustomerListModel> customerList = [];
  List<CustomerListModel> supplierList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCustomerList();
    getSupplierList();
  }

  void getCustomerList() {
    ref
        .read(customerListControllerProvider.notifier)
        .getCustomerList(branchId: widget.branch.id!);
  }

  void getSupplierList() {
    ref
        .read(supplierListControllerProvider.notifier)
        .getSupplierList(branchId: widget.branch.id!);
  }

  @override
  Widget build(BuildContext context) {

    Widget showCustomerSupplierList(List<CustomerListModel> list,
        {bool isSupplier = false}) {
      return list.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return Slidable(
                  endActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CustomerAddUpdateScreen(
                                      branchId: widget.branch.id!,
                                      customerId: list[index].id))).then((value) {
                            // getCustomerList();
                            // getSupplierList();
                            setState(() {
                              customerList =
                                  ref.watch(customerListControllerProvider);
                              supplierList =
                                  ref.watch(supplierListControllerProvider);
                            });
                          });
                        },
                        icon: Icons.edit,
                        label: 'Edit',
                      ),
                      SlidableAction(
                        onPressed: (context) {
                          isSupplier
                              ? ref
                                  .read(supplierListControllerProvider.notifier)
                                  .deleteSupplier(
                                      branchId: widget.branch.id!,
                                      customerId: list[index].id)
                              : ref
                                  .read(customerListControllerProvider.notifier)
                                  .deleteCustomer(
                                      branchId: widget.branch.id!,
                                      customerId: list[index].id);
                        },
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: Card(
                    child: ListTile(
                      title: Text(list[index].name),
                      subtitle: Text(list[index].phone),
                      leading: const Icon(Icons.account_box_outlined),
                      trailing: Text(list[index].balance),
                    ),
                  ),
                );
              },
            );
    }

    setState(() {
      customerList = ref.watch(customerListControllerProvider);
      supplierList = ref.watch(supplierListControllerProvider);
    });

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.branch.name ?? "Default Branch"),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Customers'),
              Tab(text: 'Suppliers'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            showCustomerSupplierList(customerList),
            showCustomerSupplierList(supplierList, isSupplier: true),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CustomerAddUpdateScreen(branchId: widget.branch.id!))).then((value) 
                      {
                        // getCustomerList();
                        // getSupplierList();
                        setState(() {
                          customerList = ref.watch(customerListControllerProvider);
                          supplierList = ref.watch(supplierListControllerProvider);
                        });
                      });
          },
          child: const Icon(Icons.person_add_outlined),
        ),
      ),
    );
  }
}
