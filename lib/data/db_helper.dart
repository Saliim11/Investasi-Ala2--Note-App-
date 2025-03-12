import 'package:investasi_ala_ala/model/investasi.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  
  static Future<Database> openDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'db_investasi.db'),

      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE IF NOT EXISTS investasi(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, nama TEXT, nominal REAL, deskripsi TEXT, tglMulai TEXT, deadline TEXT, isPrio INTEGER, isInvest INTEGER)',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute("DROP TABLE IF EXISTS investasi");
        return db.execute(
          'CREATE TABLE IF NOT EXISTS investasi(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, nama TEXT, nominal REAL, deskripsi TEXT, tglMulai TEXT, deadline TEXT, isPrio INTEGER, isInvest INTEGER)',
        );
      },
      
      version: 3
    );
  }

  Future<bool> insertInvestasi(Investasi inv) async {
    final db = await openDB();

      try {
      // print("inv.toMap()");
      // print(inv.toMap());

      await db.insert(
        "investasi",
        {
          "nama": inv.nama,
          "nominal": inv.nominal,
          "deskripsi": inv.deskripsi,
          "tglMulai": inv.tglMulai,
          "deadline": inv.deadline,
          "isPrio": inv.isPrio ? 1 : 0,
          "isInvest": inv.isInvest ? 1 : 0,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      
      return true; // Berhasil
    } catch (e) {
      print("Error saat menyimpan data: $e");
      return false; // Gagal
    }
  }


  Future<List<Investasi>> getInvestasi() async {
    final db = await openDB();
    final investasiMaps = await db.query("investasi");

    return [
      for (
        final {
          'id': id as int, 
          'nama': nama as String, 
          'nominal': nominal as double,
          'deskripsi': deskripsi as String,
          'tglMulai': tglMulai as String,
          'deadline': deadline as String,
          'isPrio': isPrio as int,
          'isInvest': isInvest as int,
        } 
        in investasiMaps)
        Investasi(id: id, nama: nama, nominal: nominal, deskripsi: deskripsi, tglMulai: tglMulai, deadline: deadline, isPrio: isPrio==1 ? true:false, isInvest: isInvest==1 ? true:false),
    ];
  }

  Future<void> updatePrio(int id, bool isPrio) async{
    final db = await openDB();

    db.update(
      "investasi", 
      {
        "isPrio": isPrio? 0 : 1
      },
      where: 'id = ?',
      whereArgs: [id]
    );
  }
  
  Future<void> updateInvest(int id, bool isPrio) async{
    final db = await openDB();

    db.update(
      "investasi", 
      {
        "isPrio": isPrio? 0 : 1
      },
      where: 'id = ?',
      whereArgs: [id]
    );
  }

  Future<void> deleteInvestasi(int id) async{
    final db = await openDB();

    db.delete(
      "investasi",
      where: 'id = ?',
      whereArgs: [id]
    );
  }


}