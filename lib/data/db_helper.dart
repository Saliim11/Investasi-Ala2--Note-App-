import 'package:investasi_ala_ala/model/investasi.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Future<Database>? database;
  static void createTable() async {
    database = openDatabase(
    join(await getDatabasesPath(), 'db_investasi'),

    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE investasi(id INTEGER PRIMARY KEY, nama TEXT, nominal REAL, deskripsi TEXT, tgl_mulai TEXT, deadline TEXT, is_prio INTEGER, is_invest INTEGER)',
      );
    },
    version: 1
  );
  }

  Future<void> insertInvestasi(Investasi inv) async {
    final db = await database;

    await db?.insert(
      "investasi", 
      inv.toMap(), 
      // conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  


}