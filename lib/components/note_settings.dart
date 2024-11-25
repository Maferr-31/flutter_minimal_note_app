// Importa el paquete de Flutter necesario para crear interfaces gráficas.
import 'package:flutter/material.dart';

// Define un widget sin estado (StatelessWidget) llamado `NoteSettings`.
// Este widget muestra opciones para editar o eliminar una nota.
class NoteSettings extends StatelessWidget {
  // Propiedad que almacena una función opcional que se ejecutará al tocar "Editar".
  final void Function()? onEditTap;

  // Propiedad que almacena una función opcional que se ejecutará al tocar "Eliminar".
  final void Function()? onDeleteTap;

  // Constructor que recibe las funciones `onEditTap` y `onDeleteTap` como parámetros obligatorios.
  const NoteSettings({
    super.key, // Clave única opcional para identificar el widget.
    required this.onDeleteTap, // Parámetro obligatorio para la acción de eliminar.
    required this.onEditTap,   // Parámetro obligatorio para la acción de editar.
  });

  // Sobrescribe el método `build` para construir la interfaz gráfica del widget.
  @override
  Widget build(BuildContext context) {
    return Column( // Contenedor que organiza sus hijos en una columna.
      children: [
        // Primera opción: Editar
        GestureDetector(
          // Detecta el evento táctil.
          onTap: () {
            Navigator.pop(context); // Cierra el cuadro de diálogo actual.
            onEditTap!(); // Llama a la función proporcionada para la acción de editar.
          },
          child: Container( // Contenedor para la opción "Editar".
            height: 50, // Altura fija de 50 píxeles.
            // ignore: deprecated_member_use
            color: Theme.of(context).colorScheme.background, // Color de fondo basado en el tema actual.
            child: Center( // Centra el contenido dentro del contenedor.
              child: Text( // Muestra el texto "Editar".
                "Editar",
                style: TextStyle( // Aplica un estilo al texto.
                  color: Theme.of(context).colorScheme.inversePrimary, // Color del texto basado en el tema.
                  fontWeight: FontWeight.bold, // Texto en negrita.
                ),
              ),
            ),
          ),
        ),

        // Segunda opción: Eliminar
        GestureDetector(
          // Detecta el evento táctil.
          onTap: () {
            Navigator.pop(context); // Cierra el cuadro de diálogo actual.
            onDeleteTap; // **Nota:** Este código no ejecuta la función, debería ser `onDeleteTap!();`.
          },
          child: Container( // Contenedor para la opción "Eliminar".
            height: 50, // Altura fija de 50 píxeles.
            // ignore: deprecated_member_use
            color: Theme.of(context).colorScheme.background, // Color de fondo basado en el tema actual.
            child: const Center( // Centra el contenido dentro del contenedor.
              child: Text("Eliminar"), // Muestra el texto "Eliminar".
            ),
          ),
        ),
      ],
    );
  }
}
