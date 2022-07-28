import 'package:flutter/foundation.dart';
import 'package:myproject/database/controller/user_db_controller.dart';
import 'package:myproject/models/process_Response.dart';
import 'package:myproject/models/user.dart';

class UserProvider extends ChangeNotifier{
 final UserDbController _dbController = UserDbController();

  Future<ProcessResponse<User>> login({required String email,required String password})async{
    return await _dbController.login(email: email, password: password);
  }

  Future<ProcessResponse<User>> register({required User user}) async{
    return await _dbController.register(user);
  }


}