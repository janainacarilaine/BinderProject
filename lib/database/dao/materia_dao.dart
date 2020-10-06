import 'package:sqflite/sqflite.dart';
import 'package:trabalho_sistemas/model/materias.dart';

import '../app_database.dart';

class MateriaDao{

  Future<int> save(Materia materia) async{
    final Database db = await getDatabase();
    final Map<String, dynamic> materiaMap = Map();
    materiaMap ["nome_materia"] = materia.nomeMateria;
    materiaMap ["data_escolhida"] = materia.dataEscolhida;
    materiaMap ["anotacoes"] = materia.anotacoes;
    materiaMap ["path_pdf"] = materia.pathPdf;
    materiaMap ["path_img"] = materia.pathImg;
    return db.insert('materia', materiaMap);

  }
  Future<void> update(Materia materia) async {
    // Get a reference to the database.
    final db = await getDatabase();
    // Update the given Dog.
    await db.update(
      'materia',
      materia.toMap(),
      // Ensure that the Dog has a matching id.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [materia.id],
    );
  }

  Future<List<Materia>> findAll() async{
    final Database db = await getDatabase();
    final List<Map<String, dynamic>>result = await db.query('materia');
    final List<Materia> materias = List();
    for (Map<String, dynamic> row in result) {
      final Materia materia = Materia(id: row['id'], nomeMateria: row['nome_materia'],dataEscolhida: row['data_escolhida'],anotacoes: row['anotacoes'],pathImg: row['path_pdf'],pathPdf :row['path_img']);
      materias.add(materia);
    }
    return materias;
  }

  Future<void> delete(int id) async {
    // Get a reference to the database.
    final db = await getDatabase();
    // Remove from the Database.
    await db.delete(
      'materia',
      // Use a `where` clause to delete a specific dog.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
}