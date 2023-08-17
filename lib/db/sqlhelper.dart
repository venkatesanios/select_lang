import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE langu(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        defaultlang TEXT,
        english TEXT,
        tamil TEXT,
        hindi TEXT
       )
      """);
  }
// id: the id of a item
// title, description: name and description of your activity
// created_at: the time that the item was created. It will be automatically handled by SQLite

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'selectlang.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item (journal)
  static Future<int> createItem(
      String defaultlang, String? english, String? tamil, String? hindi) async {
    final db = await SQLHelper.db();

    final data = {
      'defaultlang': defaultlang,
      'english': english,
      'tamil': tamil,
      'hindi': hindi
    };
    final id = await db.insert('langu', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all items (journals)
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('langu', orderBy: "id");
  }

  // Read a single item by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query('langu', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update an item by id
  static Future<int> updateItem(int id, String defaultlang, String? english,
      String? tamil, String? hindi) async {
    final db = await SQLHelper.db();

    final data = {
      'defaultlang': defaultlang,
      'english': english,
      'tamil': tamil,
      'hindi': hindi
    };

    final result =
        await db.update('langu', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("langu", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
