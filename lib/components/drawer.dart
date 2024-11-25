import 'package:flutter/material.dart'; 
import 'package:flutter_minimal_note_app/components/drawer_tile.dart'; 
import 'package:flutter_minimal_note_app/pages/settings_page.dart'; 

// Define un widget sin estado (StatelessWidget) para representar un menú lateral (Drawer).
class MyDrawer extends StatelessWidget { 
  // Constructor de la clase con una clave opcional para su identificación.
  const MyDrawer({super.key});

  // Sobrescribe el método build para construir la interfaz de usuario del Drawer.
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Establece el color de fondo del Drawer utilizando el esquema de colores definido en el tema actual.
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column( // Usa un diseño de columna para apilar los elementos verticalmente.
        children: [
          // Encabezado del Drawer que contiene un ícono.
          const DrawerHeader(
            child: Icon(Icons.edit), // Muestra un ícono de "editar".
          ),

          const SizedBox(height: 25), // Espaciado entre el encabezado y los elementos del Drawer.

          // Mosaico para la sección de notas.
          DrawerTile(
            title: "Notes", // Título que indica "Notas".
            leading: const Icon(Icons.home), // Ícono representativo de "inicio".
            onTap: () => Navigator.pop(context), // Cierra el Drawer al hacer clic.
          ),
          
          // Mosaico para la sección de configuración.
          DrawerTile(
            title: "Settings", // Título que indica "Configuración".
            leading: const Icon(Icons.settings), // Ícono representativo de "configuración".
            onTap: () { 
              // Al tocar, cierra el Drawer y navega hacia la página de configuración.
              Navigator.pop(context); // Cierra el Drawer actual.
              Navigator.push( // Navega hacia la nueva página.
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(), // Construye la página de configuración.
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
