import 'package:myproject/database/controller/dbOpreations.dart';
import 'package:myproject/models/process_Response.dart';
import 'package:myproject/models/user.dart';

class UserDbController extends DbOperations<User> {
  @override
  Future<ProcessResponse<User>> login(
      {required String email, required String password}) async {
    List<Map<String, dynamic>> rowMap = await database.query('users',
        where: 'email = ? AND password=?', whereArgs: [email, password]);

    if (rowMap.isNotEmpty) {
      User user = User.fromMap(rowMap: rowMap.first);
      return ProcessResponse<User>(
          message: 'logged in successfully', success: true, object: user);
    }
    return ProcessResponse<User>(message: 'logged failed', success: false);
  }

  Future<ProcessResponse<User>> register(User model) async {
    if (await _isEmailNotExist(email: model.email)) {
      int newRowId = await database.insert('users', model.toMap());
      model.id = newRowId;
      return ProcessResponse<User>(
        message: newRowId != 0
            ? 'users registered successfully'
            : 'users registered failed',
        success: newRowId != 0,
        object: model,
      );
    }else{
    return ProcessResponse(message: 'Email exists', success: false);
    }
  }

  Future<int> create(User model) async {
    int newRowId = await database.insert('users', model.toMap());
    return newRowId;
  }

  Future<bool> _isEmailNotExist({required email}) async {
    List<Map<String, dynamic>> rowMap =
        await database.query('users', where: 'email=?', whereArgs: [email]);
    return rowMap.isEmpty;
  }

  @override
  Future<bool> delete(int id) async {
    int countOfDeletedRows =
        await database.delete('users', where: 'id=?', whereArgs: [id]);
    return countOfDeletedRows > 0;
  }

  @override
  Future<List<User>> read() async {
    List<Map<String, dynamic>> rowsMaps = await database.query('users');
    return rowsMaps.map((rowMap) => User.fromMap(rowMap: rowMap)).toList();
  }

  @override
  Future<User?> show(int id) async {
    List<Map<String, dynamic>> rowsMaps =
        await database.query('users', where: 'id=?', whereArgs: [id]);
    return rowsMaps.isNotEmpty ? User.fromMap(rowMap: rowsMaps.first) : null;
  }

  @override
  Future<bool> update(User model) async {
    int countOfUpdatedRows = await database
        .update('users', model.toMap(), where: 'id=?', whereArgs: [model.id]);
    return countOfUpdatedRows > 0;
  }
}
