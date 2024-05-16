import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'controller/branch_controller.dart';
import 'model/branch_model.dart';

class BranchPage extends ConsumerStatefulWidget {
  const BranchPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BranchPageState();
}

class _BranchPageState extends ConsumerState<BranchPage> {

  List<BranchModel> branchList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBranchList();
  }

  void getBranchList() {
    ref.read(branchControllerProvider.notifier).getBranchList();
    
  }

  @override
  Widget build(BuildContext context) {
  setState(() {
    branchList = ref.watch(branchControllerProvider);
  });
    return branchList.isEmpty
        ? Center(
            child: CircularProgressIndicator(),
          )
        :
      ListView.builder(
        itemCount: branchList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Icon(Icons.store),
              title: Text(branchList[index].name!),
            ),
          );
        });
  }
}
