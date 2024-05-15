import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rskhata/core/shared_pref.dart';
import 'package:rskhata/landing/common/model/login_success_model.dart';

import '../landing/common/controller/login_otp.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {

  late String? apiKey = '';

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    getApiKey();
  }

  void getApiKey() async{
    apiKey = await SharedPref.getString("api_key") ?? "";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final LoginSuccessModel userInfo = ref.read(loginOtpControllerProvider)!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello, ${userInfo.name}'),
        actions: [
          IconButton(
            onPressed: (){
              
            },
            tooltip: "Profile",
            icon: const Icon(Icons.account_circle),
          ),
          IconButton(
            onPressed: (){
              SharedPref.setString("api_key", "");
              Navigator.of(context).pop();
            },
            tooltip: "Logout",
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: Text(apiKey??'No API Key'),
      ),
    );
  }
}