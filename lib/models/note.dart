import 'package:isar/isar.dart';

// Esta línea indica que se esta generado un archivo asociado, llamado 'note.g.dart'.
part 'note.g.dart';

// Anotación que marca esta clase como una colección en Isar.
@Collection()
class Note {
  // Campo de identificación único para cada objeto en la colección.
  Id id = Isar.autoIncrement;

  //`late` significa que este campo será inicializado más adelante, pero es obligatorio antes de ser usado.
  late String text;
}
