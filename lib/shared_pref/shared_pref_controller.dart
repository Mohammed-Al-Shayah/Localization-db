import 'package:myproject/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
enum PrefKey{
  name,email,loggedIn,language
}
class SharedPrefController{
  static final SharedPrefController _instance=SharedPrefController._();
  late SharedPreferences _sharedPrefController;

  SharedPrefController._();

  factory SharedPrefController(){
    return _instance;
  }


  Future<void>initPreferences() async{
    _sharedPrefController = (await SharedPreferences.getInstance()) ;
  }

  Future<void> save(User user) async {
    await _sharedPrefController.setBool(PrefKey.loggedIn.name,true);
    await _sharedPrefController.setString(PrefKey.name.name,user.name);
    await _sharedPrefController.setString(PrefKey.email.name,user.email);

  }

  //// laguage

  Future<void> changeLanguage  ({required String newLanguage})async{
   await _sharedPrefController.setString(PrefKey.language.name, newLanguage) ;
  }

  String get language =>_sharedPrefController.getString(PrefKey.language.name)??'en';

  //////////////

  bool get loggedIn=>_sharedPrefController.getBool(PrefKey.loggedIn.name)??false;

  Future<bool> deleteValueFor({required String key}) async{
    if(_sharedPrefController.containsKey(key)){
      return await _sharedPrefController.remove(key);
    }
    return false;
  }

  Future<bool>clear()async {
    return await _sharedPrefController.clear();
  }




  }

