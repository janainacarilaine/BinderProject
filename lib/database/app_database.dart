import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async{
  final String dbPath = await getDatabasesPath();
  final String path = join(dbPath,'binder.db');
  return openDatabase(path , onCreate: (db,version){
    db.execute('CREATE TABLE materia(''id INTEGER PRIMARY KEY,''nome_materia TEXT,''data_escolhida DATETIME,''anotacoes Text,' 'path_pdf TEXT,' 'path_img TEXT)');
  },version: 1,);
}