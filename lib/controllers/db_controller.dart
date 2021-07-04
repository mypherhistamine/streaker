import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:streaker/models/deep_work_model.dart';

class DBController {
  void insertDeepWorkData(
      Future<Database> database, DeepWorkModel model) async {
    //insert new data in the db
    final db = await database;
    await db.insert("deepwork", model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  void deleteDeepWorkData(Future<Database> database) async {
    final db = await database;
    db.delete('deepwork', where: 'id = id', whereArgs: []);
  }

  Future<List<DeepWorkModel>> showAllData(Future<Database> database) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('deepwork');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    maps.forEach((element) {
      print(element);
    });
    return List.generate(maps.length, (i) {
      return DeepWorkModel(
          hoursOfDeepWork: maps[i]['hoursOfDeepWork'],
          deepWorkdate: DateTime.parse(maps[i]['date_time']));
    });
  }
}
