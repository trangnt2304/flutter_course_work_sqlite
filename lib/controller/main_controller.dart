import 'dart:developer';

import 'package:sql_course_work/data/base/data_result.dart';
import 'package:sql_course_work/data/travel_repository.dart';
import 'package:sql_course_work/data/model/travel_model.dart';

class MainController {
  final TravelRepositoryImplement _imageRepositoryImplement;
  List<TravelModel> listTravel = List.empty(growable: true);

  MainController(this._imageRepositoryImplement);

  Future<List<TravelModel>> insertTravel(TravelModel travel) async {
    DataResult dataResult =
        await _imageRepositoryImplement.insertTravel(travel, "travel");
    if (dataResult.isSuccess) {
      await getAllTravelInfor();
      log("Success ${listTravel.length}");
      print('Dong 20: ${listTravel.toString()}');
      return listTravel;
    } else {
      if (dataResult.error is DatabaseFailure) {
        log("Error ${(dataResult.error as DatabaseFailure).errorMessage}");
        return <TravelModel>[];
      }
    }
    return <TravelModel>[];
  }

  Future<void> getAllTravelInfor() async {
    DataResult dataResult = await _imageRepositoryImplement.getAllTravelInfor();
    if (dataResult.isSuccess) {
      listTravel = dataResult.data;
    } else {
      if (dataResult.error is DatabaseFailure) {
        log("Error ${(dataResult.error as DatabaseFailure).errorMessage}");
        listTravel = List.empty();
      }
    }
  }

  Future<void> deleteAllTravel() async {
    DataResult dataResult = await _imageRepositoryImplement.deleteAllTravel();
    if (dataResult.isSuccess) {
      listTravel = List.empty();
    } else {
      if (dataResult.error is DatabaseFailure) {
        log("Error ${(dataResult.error as DatabaseFailure).errorMessage}");
        listTravel = List.empty();
      }
    }
  }
}
