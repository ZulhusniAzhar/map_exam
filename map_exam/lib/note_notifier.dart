import 'package:flutter/material.dart';
import 'note.dart';

class NoteNotifier with ChangeNotifier{
  List<Note> _noteList=[];
  Note? _currentNote;

  List<Note> get noteList => (_noteList);

  Note get currentNote => _currentNote!;

  set noteList(List<Note> noteList) {
    _noteList = noteList;
    notifyListeners();
  }

  set currentNote(Note note) {
    _currentNote = note;
    notifyListeners();
  }

  addNote(Note note) {
    _noteList.add(note);
    notifyListeners();
  }

  deleteNode(Note note) {
    _noteList.removeWhere((element) => element.id == note.id);
    notifyListeners();
  }


}