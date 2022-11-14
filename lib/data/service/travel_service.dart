import 'package:sqflite/sqflite.dart';
import 'package:sql_course_work/data/base/data_result.dart';
import 'package:sql_course_work/data/database/travel_database.dart';
import 'package:sql_course_work/data/model/travel_model.dart';

class TravelService {
  Future<DataResult> insertTravel(TravelModel travel, String tableName) async {
    try {
      Database db = await TravelDatabase.getInstance();
      int lastInsertedRow = await db.insert(tableName, travel.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      return DataResult.success(lastInsertedRow);
    } catch (ex) {
      return DataResult.failure(DatabaseFailure(ex.toString()));
    }
  }

  Future<DataResult> getAllTravelInfor() async {
    try {
      Database db = await TravelDatabase.getInstance();
      final List<Map<String, dynamic>> maps = await db.query("travel");
      List<TravelModel> students =
          maps.map((e) => TravelModel.fromMap(e)).toList();
      return DataResult.success(students);
    } catch (ex) {
      return DataResult.failure(DatabaseFailure(ex.toString()));
    }
  }
}
