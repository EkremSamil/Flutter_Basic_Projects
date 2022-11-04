import 'package:notes_app/dbHelper.dart';
import 'package:notes_app/notes.dart';

class notesDao {
  Future<List<Notes>> allNotes() async {
    var db = await databaseHelper.dbConnect();

    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM note");

    return List.generate(maps.length, (i) {
      var row = maps[i];
      return Notes(
          row["note_id"], row["course_name"], row["score1"], row["score2"]);
    });
  }

  Future<void> addNote(String course_name, int score1, int score2) async {
    var db = await databaseHelper.dbConnect();

    var info = Map<String, dynamic>();

    info["course_name"] = course_name;
    info["score1"] = score1;
    info["score2"] = score2;

    await db.insert("note", info);
  }

  Future<void> upgradeNote(
      int note_id, String course_name, int score1, int score2) async {
    var db = await databaseHelper.dbConnect();

    var info = Map<String, dynamic>();

    info["course_name"] = course_name;
    info["score1"] = score1;
    info["score2"] = score2;

    await db.update("note", info, where: "note_id=?", whereArgs: [note_id]);
  }

  Future<void> deleteNote(int note_id) async {
    var db = await databaseHelper.dbConnect();

    db.delete("note", where: "note_id=?", whereArgs: [note_id]);
  }
}
