// ignore_for_file: camel_case_types, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:myproject/models/process_Response.dart';
import 'package:myproject/models/user.dart';
import 'package:myproject/provider/languageProvider.dart';
import 'package:myproject/provider/user_provider.dart';
import 'package:myproject/shared_pref/shared_pref_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:provider/provider.dart';

class register_Screen extends StatefulWidget {
  const register_Screen({Key? key}) : super(key: key);

  @override
  State<register_Screen> createState() => _register_ScreenState();
}

class _register_ScreenState extends State<register_Screen> {
  late TextEditingController _nameTextController;
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;

  @override
  void initState() {
    // TODO: implement initState
    _nameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _passwordTextController.dispose();
    _emailTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme:const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.register,
          style:const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<LanguageProvider>(context , listen: false).changeLanguage();
        },
        child: const Icon(Icons.language),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.register_hint,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                AppLocalizations.of(context)!.register_message,
                style: const TextStyle(
                  color: Colors.black45,
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _nameTextController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.name,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _emailTextController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.email,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _passwordTextController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.password,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: ()async {
                 await _preformLogin();
                },

                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 40),
                ),
                child: Text(AppLocalizations.of(context)!.register),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _preformLogin() async {
    if (_checkData()) {
      await _register();
    }
  }

  bool _checkData() {
    if (_nameTextController.text.isNotEmpty && _emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      return true;
    }
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
        content: Text(AppLocalizations.of(context)!.error_message),
        backgroundColor: Colors.red,
        dismissDirection: DismissDirection.horizontal,
      ),
    );
    return false;
  }

  Future<void> _register() async {
   ProcessResponse<User> response=await Provider.of<UserProvider>(context ,listen: false).register(user: user);
   if(response.success){
     Navigator.pop(context);
   }
   ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
         content: Text(response.message),
         backgroundColor:response.success?Colors.green :Colors.red,
         dismissDirection: DismissDirection.horizontal,
       ),
   );


  }

   User get user {
    User user = User();
    user.name=_nameTextController.text;
    user.email=_emailTextController.text;
    user.password=_passwordTextController.text;
    return user;
   }
}
