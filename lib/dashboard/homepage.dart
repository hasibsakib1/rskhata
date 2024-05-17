import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../core/shared_pref.dart';
import '../landing/common/model/login_success_model.dart';
import '../landing/landing_page.dart';
import '../landing/common/controller/login_otp.dart';
import 'branch/controller/branch_controller.dart';
import 'branch/create_branch.dart';
import 'branch/model/branch_model.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late String? apiKey = '';
  final TextEditingController branchNameController = TextEditingController();
  List<BranchModel> branchList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBranchList();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    branchList = ref.watch(branchControllerProvider);
  }

  void getBranchList() {
    ref.read(branchControllerProvider.notifier).getBranchList();
  }

  @override
  Widget build(BuildContext context) {
    // final LoginSuccessModel? userInfo = ref.watch(loginOtpControllerProvider);

    Widget showBranchList() {
      return branchList.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: branchList.length,
              itemBuilder: (context, index) {
                return Slidable(
                  endActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (context) => CreateBranch(isEdit: true, branchId: branchList[index].id!)))
                              .then((_) {
                            setState(() {
                              branchList = ref.read(branchControllerProvider);
                            });
                          });
                        },
                        icon: Icons.edit,
                        label: 'Edit',
                      ),
                      SlidableAction(
                        onPressed: (context) {
                          ref
                              .read(branchControllerProvider.notifier)
                              .deleteBranch(branchList[index].id!);
                        },
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: Card(
                    child: ListTile(
                      leading: Icon(Icons.store),
                      title: Text(branchList[index].name!),
                    ),
                  ),
                );
              });
    }

    setState(() {
      branchList = ref.watch(branchControllerProvider);
    });

    return Scaffold(
        appBar: AppBar(
          title: Text('Hello'),
          actions: [
            IconButton(
              onPressed: () {
                // print(userInfo.toJson());
              },
              tooltip: "Profile",
              icon: const Icon(Icons.account_circle),
            ),
            IconButton(
              onPressed: () {
                SharedPref.setString("api_key", "");
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LandingPage()),
                    (route) => false);
              },
              tooltip: "Logout",
              icon: const Icon(Icons.logout),
            )
          ],
        ),
        body: showBranchList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => CreateBranch()))
                .then((_) {
              setState(() {
                branchList = ref.read(branchControllerProvider);
              });
            });
          },
          tooltip: "Add Branch",
          child: const Icon(Icons.add_business),
        ));
  }
}
