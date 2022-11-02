//This page for connect database and work some funcs.

import 'package:flag_quiz/Flags.dart';
import 'package:flag_quiz/dbHelper.dart';

class Flagsdao {
  Future<List<Flags>> randomFlags() async {
    var db = await databaseHelper.dbConnect();

    List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM flags ORDER BY RANDOM() LIMIT 5");

    return List.generate(maps.length, (i) {
      var row = maps[i];

      return Flags(row["flag_id"], row["flag_name"], row["flag_img"]);
    });
  }

  Future<List<Flags>> randomWrongFlags(int flag_id) async {
    var db = await databaseHelper.dbConnect();

    List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT * FROM flags WHERE flag_id != $flag_id ORDER BY RANDOM() LIMIT 3");

    return List.generate(maps.length, (i) {
      var row = maps[i];

      return Flags(row["flag_id"], row["flag_name"], row["flag_img"]);
    });
  }
}
