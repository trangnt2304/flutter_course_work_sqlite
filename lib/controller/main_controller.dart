import 'dart:developer';

import 'package:sql_course_work/data/base/data_result.dart';
import 'package:sql_course_work/data/travel_repository.dart';
import 'package:sql_course_work/data/model/travel_model.dart';

class MainController {
  final ImageRepositoryImplement _imageRepositoryImplement;
  List<TravelModel> listImageUrl = List.empty(growable: true);

  MainController(this._imageRepositoryImplement);

  Future<List<TravelModel>> insertImageUrl(TravelModel student) async {
    DataResult dataResult =
        await _imageRepositoryImplement.insertTravel(student, "imageUrl");
    if (dataResult.isSuccess) {
      await getAllImageUrl();
      log("Success ${listImageUrl.length}");
      return listImageUrl;
    } else {
      if (dataResult.error is DatabaseFailure) {
        log("Error ${(dataResult.error as DatabaseFailure).errorMessage}");
        return <TravelModel>[];
      }
    }
    return <TravelModel>[];
  }

  Future<void> getAllImageUrl() async {
    DataResult dataResult = await _imageRepositoryImplement.getAllTravelInfor();
    if (dataResult.isSuccess) {
      listImageUrl = dataResult.data;
    } else {
      if (dataResult.error is DatabaseFailure) {
        log("Error ${(dataResult.error as DatabaseFailure).errorMessage}");
        listImageUrl = List.empty();
      }
    }
  }
}
