import 'package:sql_course_work/data/base/data_result.dart';
import 'package:sql_course_work/data/service/travel_service.dart';

import 'model/travel_model.dart';

abstract class TravelRepository {
  Future<DataResult> insertTravel(TravelModel imageUrl, String tableName);
  Future<DataResult> getAllTravelInfor();
}

class TravelRepositoryImplement implements TravelRepository {
  final TravelService _travelService;

  TravelRepositoryImplement(this._travelService);

  @override
  Future<DataResult> insertTravel(TravelModel travel, String tableName) {
    return _travelService.insertTravel(travel, tableName);
  }

  @override
  Future<DataResult> getAllTravelInfor() {
    return _travelService.getAllTravelInfor();
  }
}
