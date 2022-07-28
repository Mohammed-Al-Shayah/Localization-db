import 'package:myproject/database/controller/dbOpreations.dart';
import 'package:myproject/models/notes.dart';

class NotesDbController extends DbOperations<Notes>{
  @override
  Future<int> create(Notes model)async {
    int newRowId=  await database.insert('notes', model.toMap());
    return newRowId;
  }

  @override
  Future<bool> delete(int id) async{
    int countOfDeletedRows = await database.delete('notes',where: 'id=?', whereArgs:[id]);
    return countOfDeletedRows >0;
  }

  @override
  Future<List<Notes>> read()async {
    List<Map<String,dynamic>> rowsMaps= await database.query('notes');
    return rowsMaps.map((rowMap) => Notes.fromMap(rowMap: rowMap)).toList();
  }

  @override
  Future<Notes?> show(int id)async {
    List<Map<String,dynamic>> rowsMaps= await database.query('notes',where: 'id=?',whereArgs: [id]);
    return rowsMaps.isNotEmpty?Notes.fromMap(rowMap: rowsMaps.first):null;
  }

  @override
  Future<bool> update(Notes model) async{
    int countOfUpdatedRows = await database.update('notes',model.toMap(),where: 'id=?', whereArgs: [model.id]);
    return countOfUpdatedRows >0;
  }

}