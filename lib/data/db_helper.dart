import 'package:investasi_ala_ala/model/investasi.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Future<Database>? database;
  
  static void createTable() async {
    database = openDatabase(
    join(await getDatabasesPath(), 'db_investasi.db'),

    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE IF NOT EXISTS investasi(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, nama TEXT, nominal REAL, deskripsi TEXT, tglMulai TEXT, deadline TEXT, isPrio INTEGER, isInvest INTEGER)',
      );
    },
    version: 1
  );
  }

  Future<void> insertInvestasi(Investasi inv) async {
    final db = await database;

    print("inv.toMap()");
    print(inv.toMap());

    await db?.insert(
      "investasi", 
      inv.toMap(), 
      // conflictAlgorithm: ConflictAlgorithm.replace
    );
  }


  Future<List<Investasi>> getInvestasi() async {
    final db = await database;

    final investasiMaps = await db?.query(
      "investasi"
    );

    return [
      for (
        final {
          'id': id as int, 
          'nama': nama as String, 
          'nominal': nominal as double,
          'deskripsi': deskripsi as String,
          'tglMulai': tglMulai as String,
          'deadline': deadline as String,
          'isPrio': isPrio as bool,
          'isInvest': isInvest as bool,

        } 
        in investasiMaps!)
        Investasi(id: id, nama: nama, nominal: nominal, deskripsi: deskripsi, tglMulai: tglMulai, deadline: deadline, isPrio: isPrio, isInvest: isInvest),
    ];

    
  }




}