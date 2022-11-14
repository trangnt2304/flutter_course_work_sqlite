import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TravelDatabase {
  static Database? _database;

  static Future<Database> getInstance() async {
    _database ??= await openDatabase(
        join(await getDatabasesPath(), "travel.db"),

        /// This function will be called in the first time database is created
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE travel(name TEXT, destination TEXT, dateTime TEXT, require TEXT, description TEXT)");
    },

        /// This version will use when you want to upgrade or downgrade the database
        version: 1,
        singleInstance: true);
    return _database!;
  }
}
