import 'package:flutter/material.dart';
import 'package:flutter_minimal_note_app/models/note.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

//Extiende ChangeNotifier para notificar a los widgets cuando hay cambios.
class NoteDatabase extends ChangeNotifier {
  static late Isar isar;  // Instancia estática de Isar para gestionar la base de datos.

//INICIALIZAR - BASE DE DATOS
  // Método estático para inicializar la base de datos de Isar.
  static Future<void> initialize() async {
    // Obtiene la ruta al directorio de documentos de la aplicación.
    final dir = await getApplicationDocumentsDirectory();
    // Abre la base de datos Isar, usando el esquema de la clase `Note` definido en `NoteSchema`.
    isar = await Isar.open(
      [NoteSchema], // Esquema de la colección Note.
      directory: dir.path, // Ruta del directorio donde se almacenará la base de datos.
    );
  }

  // Lista de notas en memoria que almacena las notas actuales. Se sincroniza con la base de datos.
  final List<Note> currentNotes = [];


//CREAR
  // Método para crear y agregar una nueva nota a la base de datos.
  Future<void> addNote(String textFromUser) async {
    // Crea una nueva instancia de la clase Note y asigna el texto proporcionado por el usuario.
    final newNote = Note()..text = textFromUser;
    // Guarda la nueva nota en la base de datos dentro de una transacción.
    await isar.writeTxn(() => isar.notes.put(newNote));
    // Actualiza la lista de notas leyendo nuevamente desde la base de datos.
    fetchNotes();
  }
//LEER
  // Método para leer todas las notas de la base de datos y actualizar la lista en memoria.
  Future<void> fetchNotes() async {
    // Obtiene todas las notas de la colección `notes` usando un query simple.
    List<Note> fetchedNotes = await isar.notes.where().findAll();
    // Limpia la lista actual de notas en memoria.
    currentNotes.clear();  
    // Agrega las notas obtenidas desde la base de datos a la lista en memoria.
    currentNotes.addAll(fetchedNotes);   
    // Notifica a los listeners (widgets) que la lista de notas ha cambiado.
    notifyListeners();
  }

//DESCARGAR
  // Método para actualizar el texto de una nota existente en la base de datos.
  Future<void> updateNote(int id, String newText) async {
    // Busca la nota existente en la base de datos usando su ID.
    final existingNote = await isar.notes.get(id);  
    // Si la nota existe, actualiza su texto.
    if (existingNote != null) {
      existingNote.text = newText;
      // Guarda los cambios en la base de datos dentro de una transacción.
      await isar.writeTxn(() => isar.notes.put(existingNote));
      // Actualiza la lista de notas leyendo nuevamente desde la base de datos.
      await fetchNotes();
    }
  }

//BORRAR
  // Método para eliminar una nota de la base de datos usando su ID.
  Future<void> deleteNote(int id) async {
    // Elimina la nota correspondiente dentro de una transacción.
    await isar.writeTxn(() => isar.notes.delete(id));

    // Actualiza la lista de notas leyendo nuevamente desde la base de datos.
    await fetchNotes();
  }
}
