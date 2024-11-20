import 'package:flutter/material.dart';

class NoteSettings extends StatelessWidget {
  const NoteSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //opcion de editar
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            onEditTap!();
          },
          child: Container(
            height: 50,
            color: Theme.of(context).colorScheme.background,
            child: Center(
              child: Text(
                "Editar",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
              ),
            ),
           ),
         ),
       ),

        //opcion de borrar
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            onDeleteTap;
          },
          child: Container(
            height: 50,
            color: Theme.of(context).colorScheme.background,
            child: Center(child: Text("Eliminar")),
          ),
        ),
      ],
    );
  }
}