import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_minimal_note_app/components/drawer_tile.dart';
import 'package:flutter_minimal_note_app/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer ({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          //encabezado
          const DrawerHeader(
            child: Icon(Icons.note),
          ),

          //mosaico de notas
          DrawerTile(
            title: "Notes", 
            leading: const Icon(Icons.home), 
            onTap: () => Navigator.pop(context),
          ),
          
          //mosaico de configuración
          DrawerTile(
            title: "Settings", 
            leading: const Icon(Icons.settings), 
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}