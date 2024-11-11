import 'dart:developer';

import 'package:budgey/domain/report.dart';
import 'package:sqflite/sqflite.dart' as sql;

class Database {
  static Future<sql.Database> db() async {
    return sql.openDatabase('budgey', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTable(database);
    });
  }

  static Future<void> createTable(sql.Database database) async {
    await database.execute("""
      CREATE TABLE Reports (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        description TEXT,
        amount INT,
        date TEXT,
        type TEXT
      )
    """);
  }

  static Future<int> insert(Report rt) async {
    final db = await Database.db();
    final report = {
      'description': rt.description,
      'amount': rt.amount,
      'date': rt.date,
      'type': rt.type
    };
    final id = await db.insert('Reports', report,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<void> delete(int id) async {
    final db = await Database.db();
    try {
      await db.delete("Reports", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      print("Something went wrong: $err");
    }
  }

  static Future<List<Map<String, dynamic>>> index() async {
    final db = await Database.db();
    return db.query('Reports', orderBy: "id DESC");
  }

  static Future<List<Map<String, dynamic>>> getSpents(String type) async {
    final db = await Database.db();
    return db.query(
      'Reports',
      where: 'type = ?',
      whereArgs: [type],
      orderBy: "id DESC",
    );
  }

  static Future<List<Map<String, dynamic>>> getReportByID(int id) async {
    final db = await Database.db();
    return db.query(
      'Reports',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<int> update(int id, String description, double amount, String type) async {
    final db = await Database.db();

    final data = {
      'description': description,
      'amount': amount,
      'type': type,
    };
    var result;
    try {
      result =
          await db.update('Reports', data, where: "id = ?", whereArgs: [id]);
    } catch (e) {
      print("AOWK ERROR $e");
    }
    return result;
  }
}
