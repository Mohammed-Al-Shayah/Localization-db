// ignore_for_file: camel_case_types, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:myproject/shared_pref/shared_pref_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';


class Home_Screen extends StatefulWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(AppLocalizations.of(context)!.home),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
             await _logout();
            },
            icon:const Icon(Icons.logout),
          )
        ],
      ),
    );
  }

  Future<void> _logout() async {
      bool cleared= await SharedPrefController().clear();
    if(cleared) {
      Navigator.pushReplacementNamed(context, "/login_Screen");
    }
  }
}
