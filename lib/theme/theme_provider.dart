import 'package:flutter/material.dart';
import 'package:flutter_minimal_note_app/theme/theme.dart';

// Define una clase ThemeProvider que implementa ChangeNotifier, lo que permite que los widgets se actualicen automáticamente
// cuando cambian los datos del tema.
class ThemeProvider with ChangeNotifier { 
  // Propiedad privada que almacena el tema actual. Inicialmente, se establece en lightMode.
  ThemeData _themeData = lightMode;

  // Getter para acceder al tema actual (_themeData) desde fuera de la clase.
  ThemeData get themeData => _themeData;

  // Getter que verifica si el tema actual es el modo oscuro.
  bool get isDarkMode => _themeData == darkMode;

  // Setter para actualizar el tema actual. Cuando se cambia el tema, se notifica a los oyentes para redibujar la interfaz.
  set themeData(ThemeData themeData) {
    _themeData = themeData; // Actualiza el tema actual.
    notifyListeners(); // Notifica a los widgets dependientes para que se actualicen.
  }

  // Método para alternar entre los modos claro y oscuro.
  void togglerTheme() {
    // Si el tema actual es el modo claro, cambia al modo oscuro.
    if (_themeData == lightMode) {
      themeData = darkMode; // Cambia al modo oscuro.
    } else {
      // Si no, cambia al modo claro.
      themeData = lightMode;
    }
  }
}
