import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class databaseHelper {
  static final String dbName = "flagquiz.sqlite";

  static Future<Database> dbConnect() async {
    String dbPath = join(await getDatabasesPath(), dbName);

    if (await databaseExists(dbPath)) {
      print("Database is not connected bcs its already working.");
    } else {
      ByteData data = await rootBundle.load("db/$dbName");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(dbPath).writeAsBytes(bytes, flush: true);

      print("Database is connected.");
    }
    return openDatabase(dbPath);
  }
}
