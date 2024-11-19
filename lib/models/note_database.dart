import 'package:flutter/material.dart';
import 'package:flutter_minimal_note_app/models/note.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;

  // iniciar base
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [NoteSchema], 
      directory: dir.path,
    );
  }
  //lista de notas
  final List<Note> currentNotes = [];
  // crear 
  Future<void> addNote(String textFromUser) async {
    //crear nueva nota
    final newNote = Note()..text = textFromUser;

    //guardar 
    await isar.writeTxn(() => isar.notes.put(newNote));

    //re-leer from db
    fetchNotes();
  }

  //leer
  Future<void> fetchNotes() async {
    List<Note> fetchedNotes = await isar.notes.where().findAll(); 
    currentNotes.clear();
    currentNotes.addAll(fetchedNotes);
    notifyListeners();
    }

  //descargar
    Future<void> updateNote(int id, String newText) async{
      final existingNote = await isar.notes.get(id);
      if (existingNote != null) {
        existingNote.text = newText;
        await isar.writeTxn(() => isar.notes.put(existingNote));
        await fetchNotes();
      }
    }

  //borrar
  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    await fetchNotes();
  }
}