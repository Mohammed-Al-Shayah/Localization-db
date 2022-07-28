import 'package:flutter/foundation.dart';
import 'package:myproject/database/controller/notes_db_controller.dart';
import 'package:myproject/models/notes.dart';
import 'package:myproject/models/process_Response.dart';

class NoteProvider extends ChangeNotifier{
  final NotesDbController _dbController =NotesDbController();
  List<Notes> notes= <Notes>[];

  Future<ProcessResponse> createNote ({required Notes note})async{
    int newRowId=await _dbController.create(note);
    if(newRowId !=0){
      note.id=newRowId;
      notes.add(note);
      notifyListeners();
    }
    return ProcessResponse(message:newRowId!=0?'Note Created Sucess':'Filed to created',success:newRowId!=0 );
  }


    Future<ProcessResponse>deleteNote({required int index})async{
    bool deleted =await _dbController.delete(notes[index].id);
    if(deleted){
      notes.removeAt(index);
      notifyListeners();
    }
    return ProcessResponse(message:deleted?'Deleted successfully':'Filed to deleted',success:deleted );
  }

  Future<ProcessResponse>updateNote({required Notes updateNote,required int index})async{
    bool updated =await _dbController.update(updateNote);
    if(updated){
      notes[index]=updateNote;
      notifyListeners();
    }
    return ProcessResponse(message:updated?'updated successfully':'Filed to updated',success:updated );
  }

  Future<void>readNote()async{
      notes =await _dbController.read();
      notifyListeners();
  }



}