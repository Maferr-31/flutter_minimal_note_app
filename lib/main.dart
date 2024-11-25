import 'package:flutter/material.dart';
import 'package:flutter_minimal_note_app/models/note_database.dart';
import 'package:flutter_minimal_note_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'pages/notes_page.dart';

void main() async {

//Asegura que los servicios de Flutter estén completamente inicializados antes de ejecutar cualquier código relacionado con ellos.
  WidgetsFlutterBinding.ensureInitialized();
//Llama al método `initialize` de `NoteDatabase` para configurar e inicializar la base de datos antes de que la app se ejecute.
  await NoteDatabase.initialize();

// Inicia la aplicación Flutter
  runApp(
   //permite proporcionar múltiples objetos que pueden ser accedidos por los widgets descendientes. 
    MultiProvider(
      providers: [
        //gestiona el estado relacionado con la base de datos (como agregar, leer, actualizar o eliminar).
        ChangeNotifierProvider(create: (context) => NoteDatabase()),
        //gestiona el tema de la aplicación (como modo claro/oscuro)
        ChangeNotifierProvider(create: (context) => ThemeProvider())
      ],
      // Define el widget raíz de la aplicación.
      child: const MyApp(),
    ),
  );
}

//Clase MyApp, extiende `StatelessWidget` porque no tiene estado mutable.
class MyApp extends StatelessWidget {
   // Constructor constante de la clase.
  const MyApp({super.key});

//define cómo se construye el árbol de widgets de este componente.
  @override
  Widget build(BuildContext context) {
      // Retorna un `MaterialApp`
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const NotesPage(),
      theme: Provider.of<ThemeProvider>(context).themeData, // problem
    );
  }
}