import 'package:flutter/material.dart'; 
import 'package:flutter_minimal_note_app/components/note_settings.dart'; 
import 'package:popover/popover.dart'; 

class NoteTile extends StatelessWidget {
  // Propiedades para el texto de la nota y las acciones de editar y eliminar.
  final String text; // Texto que se mostrará en la nota.
  final void Function()? onEditPressed; // Función a ejecutar al presionar "Editar".
  final void Function()? onDeletePressed; // Función a ejecutar al presionar "Eliminar".

  // Constructor que inicializa las propiedades requeridas.
  const NoteTile({
    super.key,
    required this.text,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    // Construye un contenedor que representa la nota.
    return Container(
      decoration: BoxDecoration(
        // Establece el color de fondo según el tema actual.
        color: Theme.of(context).colorScheme.primary,
        // Bordes redondeados con un radio de 8 píxeles.
        borderRadius: BorderRadius.circular(8),
      ),
      // Margen alrededor del contenedor.
      margin: const EdgeInsets.only(
        top: 10, // Margen superior.
        left: 25, // Margen izquierdo.
        right: 25, // Margen derecho.
      ),
      child: ListTile(
        // Muestra el texto de la nota.
        title: Text(text),
        // Agrega un botón de más opciones como elemento secundario.
        trailing: Builder(
          // Utiliza un `Builder` para proporcionar un contexto separado para este widget.
          builder: (context) => IconButton(
            icon: const Icon(Icons.more_vert), // Ícono de tres puntos verticales.
            onPressed: () => showPopover(
              // Muestra un popover con las opciones de configuración.
              width: 100, // Ancho del popover.
              height: 100, // Altura del popover.
              backgroundColor: Theme.of(context).colorScheme.background, // Fondo según el tema.
              context: context, // Contexto donde se muestra el popover.
              // Construye el cuerpo del popover utilizando el componente NoteSettings.
              bodyBuilder: (context) => NoteSettings(
                onEditTap: onEditPressed, // Asigna la acción de editar.
                onDeleteTap: onDeletePressed, // Asigna la acción de eliminar.
              ),
            ),
          ),
        ),
      ),
    );
  }
}
