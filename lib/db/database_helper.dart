import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
      CREATE TABLE rankings (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        description TEXT,
        point number,
        image TEXT
      )
    """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      "hakathon.db",
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }
  // Create new item (journal)
  // static Future<int> createRanking(String title, String? descrption) async {
  //   final db = await SQLHelper.db();

  //   final data = {'title': title, 'description': descrption};
  //   final id = await db.insert('rankings', data,
  //       conflictAlgorithm: sql.ConflictAlgorithm.replace);
  //   return id;
  // }
// Read all items (journals)
  static Future<List<Map<String, dynamic>>> getRankings() async {
    final db = await SQLHelper.db();
    return db.query('rankings', orderBy: "point");
  }

  static Future<List<Map<String, dynamic>>> getRanking(int id) async {
    final db = await SQLHelper.db();
    return db.query('rankings', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update an item by id
  static Future<int> updateRanking(
      int id, String name, String? description, int point, String image) async {
    final db = await SQLHelper.db();

    final data = {
      'name': name,
      'description': description,
      'point': point,
      'image': image
    };

    final result =
        await db.update('rankings', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("items", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
