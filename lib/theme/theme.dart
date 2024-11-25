import 'package:flutter/material.dart';

//modo luz
// Define el tema claro (modo luz).
ThemeData lightMode = ThemeData(
  brightness: Brightness.light, // Configura el tema con un esquema de color claro.
  colorScheme: ColorScheme.light( // Define el esquema de color para el modo claro.
    // ignore: deprecated_member_use
    background:Colors.grey.shade300, // Color de fondo principal (gris claro).
   primary: Colors.grey.shade200, // Color primario (usado para elementos destacados como AppBars o botones).
    secondary: Colors.grey.shade400, // Color secundario (usado para elementos complementarios como chips).
    inversePrimary: Colors.grey.shade800, // Color inverso para contraste (texto oscuro en elementos claros).
  ),
);

//modo oscuro 
//// Define el tema oscuro (modo oscuro).
ThemeData darkMode = ThemeData(
  brightness: Brightness.dark, // Configura el tema con un esquema de color oscuro.
  colorScheme: ColorScheme.dark( // Define el esquema de color para el modo oscuro.  
    // ignore: deprecated_member_use
    background:const Color.fromARGB(255, 24, 24, 24),// Color de fondo principal (negro casi puro).
     primary: const Color.fromARGB(255, 34, 34, 34), // Color primario (gris oscuro para elementos destacados).
    secondary: const Color.fromARGB(255, 49, 49, 49), // Color secundario (gris más claro para elementos complementarios).
    inversePrimary: Colors.grey.shade300, // Color inverso para contraste (texto claro en elementos oscuros).
  ),
);