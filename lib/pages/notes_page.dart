import 'package:flutter/material.dart';
import 'package:flutter_minimal_note_app/components/drawer.dart';
import 'package:flutter_minimal_note_app/components/note_tile.dart';
import 'package:flutter_minimal_note_app/main.dart';
import 'package:flutter_minimal_note_app/models/note.dart';
import 'package:flutter_minimal_note_app/models/note_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage ({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  //controlador del tipo de texto
  final textController = TextEditingController();

   @override
   void initState() {
    //implementar estado init
    super.initState();

    //al iniciar la aplicación
    readNotes();
   }

//crear nota
void createNote() {
  showDialog(
    context: context, 
    builder: (context) => AlertDialog(
      // ignore: deprecated_member_use
      backgroundColor: Theme.of(context).colorScheme.background,
      content: TextField(
        controller: textController,
      ),
      actions: [
        //crear boton
        MaterialButton(
          onPressed: () {
            //agregar a la base de datos
            context.read<NoteDatabase>().addNote(textController.text);

            //borrar el controlador
            textController.clear();

            //pop dialog box
            Navigator.pop(context);
          },
          child: const Text("Create"),
        )
      ],
    )
  );
}

//leer nota
void readNotes() {
  context.watch<NoteDatabase>().fetchNotes();
}

//descargar nota
void updateNote(Note note) {
  textController.text = note.text;
  showDialog(
    context: context, 
    builder: (context) => AlertDialog(
      // ignore: deprecated_member_use
      backgroundColor: Theme.of(context).colorScheme.background,
      title: const Text("Descargar Nota"),
      content: TextField(controller: textController),
      actions: [
        //boton de descarga
        MaterialButton(
          onPressed: () {
         //descarga nota en base de datos
           context
              .read<NoteDatabase>()
              .updateNote(note.id, textController.text);
            //limpiar control
            textController.clear();
            //cuadro de diálogo emergente
            Navigator.pop(context);
          },
          child: const Text("Descargar"),
        )
      ],
    ),
  );
}

//borrar nota
void deleteNote(int id) {
  context.read<NoteDatabase>().deleteNote(id);
}

  @override
  Widget build(BuildContext context) {

   //base de datos de notas
   final noteDatabase = context.watch<NoteDatabase>();
    
    // current note
    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      // ignore: deprecated_member_use
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          Icons.add, 
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      drawer: const MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Heading
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              'Notes',
              style: GoogleFonts.dmSerifText(
                fontSize: 48,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          //lista de notas
          Expanded(
            child: ListView.builder(
              itemCount: currentNotes.length,
              itemBuilder: (context, index) {
                //una nota individual
                final note = currentNotes[index];
            
                //lista de interfaz de usuario
                return NoteTile(
                  text: note.text,
                  onEditPressed: () => updateNote(note),
                  onDeletePressed: () => deleteNote(note.id),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}