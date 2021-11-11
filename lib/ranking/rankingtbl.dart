import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'dart:async';

class Rankings {
  // final int id;
  final String name;
  final String description;
  final int point;
  final String image;
  Rankings(this.name, this.description, this.point, this.image);
  Map<String, dynamic> toMap() {
    return {
      // "id": id,
      "name": name,
      "description": description,
      "point": point,
      "image": image,
    };
  }

  @override
  String toString() {
    return "Rankings{name: $name, description: $description, point: $point, image: $image}";
  }
}

void sqlite() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = openDatabase(
    join(await getDatabasesPath(), "hakathon"),
    onCreate: (db, version) {
      return db.execute(
        ' create table rankings (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ,name, description, point, image)',
      );
    },
    version: 1,
  );
  Future<void> insertRanking(Rankings ranking) async {
    final db = await database;

    await db.insert("rankings", ranking.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Rankings>> rankings() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query("rankings");
    return List.generate(maps.length, (i) {
      return Rankings(
        maps[i]["name"],
        maps[i]["description"],
        maps[i]["point"],
        maps[i]["point"],
      );
    });
  }

  // Future<void> updateRankings(Rankings rankings) async {
  //   final db = await database;

  //   await db.update(
  //     "rankings",
  //     rankings.toMap(),
  //     where: "id=?",
  //     whereArgs: [id],
  //   );
  // }

  Future<void> deleteRankings(int id) async {
    final db = await database;
    await db.delete(
      "rankings",
      where: "id=?",
      whereArgs: [id],
    );
  }

  var ranking = Rankings("insert db", "すごい！！！", 2000, "shop_icon.png");
  await insertRanking(ranking);
  print(await ranking);
}
