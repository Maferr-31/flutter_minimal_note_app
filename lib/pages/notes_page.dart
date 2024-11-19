import 'package:flutter/material.dart';
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
      title: Text("Descargar Nota"),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          //Heading
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Text('Notes',style: GoogleFonts.dmSeriText(fontSize: 48),),
          ),
          //lista de notas
          Expanded(
            child: ListView.builder(
              itemCount: currentNotes.length,
              itemBuilder: (context, index) {
                //una nota individual
                final note = currentNotes[index];
            
                //lista de interfaz de usuario
                return ListTile(
                  title: Text(note.text),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                     // boton editar
                     IconButton(
                      onPressed: () => updateNote(note), 
                      icon: const Icon(Icons.edit),
                      ),
                     
                     //boton borrar
                     IconButton(
                      onPressed:() => updateNote(note), 
                      icon: const Icon(Icons.delete),
                     ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}