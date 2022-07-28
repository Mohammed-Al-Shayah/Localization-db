import 'package:flutter/cupertino.dart';
import 'package:myproject/shared_pref/shared_pref_controller.dart';

class LanguageProvider extends ChangeNotifier{
  String language = SharedPrefController().language;
  void changeLanguage() async {
     language =language== 'en'?'ar':'en';
    await SharedPrefController().changeLanguage(newLanguage: language);
    notifyListeners();
  }
}