import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:map_exam/note_notifier.dart';
import 'note.dart';

getNote(NoteNotifier noteNotifier,String email) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('notes').get();
  List<Note> noteList = snapshot.docs.map((e) => Note.fromJson(e.data() as Map<String, dynamic>)).toList();

  noteNotifier.noteList = noteList;
}

Future getNoteFuture(NoteNotifier noteNotifier, String email) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('notes').get();
  List<Note> noteList = snapshot.docs.map((e) => Note.fromJson(e.data() as Map<String, dynamic>)).toList();

  noteNotifier.noteList = noteList;
}

Future deleteCurrentNote(Note currentNote) async {
  final CollectionReference db = FirebaseFirestore.instance.collection('notes');

  await db.doc(currentNote.id).delete();
}

Future<Note> updateCurrentNote(Note note) async {
  final CollectionReference db = FirebaseFirestore.instance.collection('notes');
  await db.doc(note.id).update({
    'title': note.title,
    'info': note.content,
  });
  return note;
}