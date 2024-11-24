import 'package:flutter/material.dart';
import 'package:flutter_minimal_note_app/components/drawer.dart';
import 'package:flutter_minimal_note_app/components/note_tile.dart';
import 'package:flutter_minimal_note_app/models/note.dart';
import 'package:flutter_minimal_note_app/models/note_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// Define un widget con estado para manejar la página de notas.
class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  // Crea el estado asociado a este widget.
  @override
  State<NotesPage> createState() => _NotesPageState();
}

// Clase que contiene la lógica y el estado del widget NotesPage.
class _NotesPageState extends State<NotesPage> {
  // Controlador de texto para capturar el texto ingresado por el usuario.
  final textController = TextEditingController();

  // Método que se ejecuta al inicializar el estado del widget.
  @override
  void initState() {
    super.initState(); // Llama al initState original.
    readNotes(); // Llama a la función para cargar las notas existentes.
  }

  // Función para crear una nueva nota.
  void createNote() {
    showDialog(
      context: context, // Contexto actual del widget.
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background, // Color del fondo del diálogo.
        content: TextField(
          controller: textController, // Asigna el controlador al campo de texto.
        ),
        actions: [
          // Botón para crear la nota.
          MaterialButton(
            onPressed: () {
              // Agrega la nota a la base de datos.
              context.read<NoteDatabase>().addNote(textController.text);
              textController.clear(); // Limpia el controlador.
              Navigator.pop(context); // Cierra el cuadro de diálogo.
            },
            child: const Text("Create"), // Texto del botón.
          ),
        ],
      ),
    );
  }

  // Función para cargar las notas desde la base de datos.
  void readNotes() {
    context.watch<NoteDatabase>().fetchNotes(); // Llama a `fetchNotes` del proveedor `NoteDatabase`.
  }

  // Función para actualizar una nota existente.
  void updateNote(Note note) {
    textController.text = note.text; // Precarga el texto existente en el controlador.
    showDialog(
      context: context, // Contexto actual.
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background, // Fondo del diálogo.
        title: const Text("Descargar Nota"), // Título del cuadro de diálogo.
        content: TextField(controller: textController), // Campo de texto con el controlador asignado.
        actions: [
          // Botón para actualizar la nota.
          MaterialButton(
            onPressed: () {
              // Actualiza la nota en la base de datos.
              context
                  .read<NoteDatabase>()
                  .updateNote(note.id, textController.text);
              textController.clear(); // Limpia el controlador.
              Navigator.pop(context); // Cierra el cuadro de diálogo.
            },
            child: const Text("Descargar"), // Texto del botón.
          ),
        ],
      ),
    );
  }

  // Función para eliminar una nota de la base de datos.
  void deleteNote(int id) {
    context.read<NoteDatabase>().deleteNote(id); // Llama al método `deleteNote` del proveedor.
  }

  // Construye la interfaz gráfica del widget.
  @override
  Widget build(BuildContext context) {
    final noteDatabase = context.watch<NoteDatabase>(); // Obtiene la instancia de `NoteDatabase`.
    List<Note> currentNotes = noteDatabase.currentNotes; // Lista actual de notas.

    return Scaffold(
      appBar: AppBar(
        elevation: 0, // Quita la sombra del AppBar.
        backgroundColor: Colors.transparent, // Hace transparente el fondo.
        foregroundColor: Theme.of(context).colorScheme.inversePrimary, // Color del texto e íconos.
      ),
      backgroundColor: Theme.of(context).colorScheme.background, // Fondo del Scaffold.
      floatingActionButton: FloatingActionButton(
        onPressed: createNote, // Llama a `createNote` al presionar.
        backgroundColor: Theme.of(context).colorScheme.primary, // Color de fondo del botón.
        child: Icon(
          Icons.add, // Ícono del botón flotante.
          color: Theme.of(context).colorScheme.inversePrimary, // Color del ícono.
        ),
      ),
      drawer: const MyDrawer(), // Drawer personalizado (menú lateral).
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Alinea los hijos al inicio horizontalmente.
        children: [
          // Título "Notes".
          Padding(
            padding: const EdgeInsets.only(left: 25.0), // Espaciado a la izquierda.
            child: Text(
              'Notes', // Texto del título.
              style: GoogleFonts.dmSerifText(
                fontSize: 48, // Tamaño de la fuente.
                color: Theme.of(context).colorScheme.inversePrimary, // Color del texto.
              ),
            ),
          ),
          // Lista de notas.
          Expanded(
            child: ListView.builder(
              itemCount: currentNotes.length, // Número de elementos en la lista.
              itemBuilder: (context, index) {
                final note = currentNotes[index]; // Nota actual.
                return NoteTile(
                  text: note.text, // Texto de la nota.
                  onEditPressed: () => updateNote(note), // Llama a `updateNote`.
                  onDeletePressed: () => deleteNote(note.id), // Llama a `deleteNote`.
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
