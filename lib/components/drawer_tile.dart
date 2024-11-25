import 'package:flutter/material.dart';

// Define un widget sin estado (StatelessWidget) que representa un elemento del menú lateral (DrawerTile).
class DrawerTile extends StatelessWidget {
  // Propiedad para almacenar el título del elemento del drawer.
  final String title;

  // Propiedad para almacenar un widget que se mostrará como ícono líder en el drawer.
  final Widget leading;

  // Propiedad para manejar la acción al tocar el elemento (evento onTap).
  final void Function()? onTap;

  // Constructor de la clase, que requiere un título, un ícono líder y una función opcional onTap.
  const DrawerTile({
    super.key, // Clave única opcional para identificar el widget.
    required this.title, // Parámetro obligatorio para el título.
    required this.leading, // Parámetro obligatorio para el ícono líder.
    required this.onTap, // Parámetro obligatorio para la acción al tocar.
  });

  // Sobrescribe el método build para construir la interfaz gráfica del DrawerTile.
  @override
  Widget build(BuildContext context) {
    return Padding(
      // Agrega un margen a la izquierda para separar visualmente el elemento del borde.
      padding: const EdgeInsets.only(left: 25.0),
      child: ListTile(
        // Establece el título del elemento usando un widget de texto.
        title: Text(
          title, // Muestra el texto proporcionado en la propiedad `title`.
          style: TextStyle(
            // Aplica un color al texto basado en el esquema de colores del tema actual.
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        // Asigna el widget líder proporcionado (como un ícono o cualquier otro widget).
        leading: leading,
        // Define la acción a realizar cuando se toca el elemento.
        onTap: onTap,
      ),
    );
  }
}
