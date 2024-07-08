import 'dart:convert';

import 'package:booking_box/data/model/popular_car/popular_car_response_model.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../view/components/snack_bar/show_custom_snackbar.dart';
import '../../model/global/response_model/response_model.dart';
import '../../repo/popular_car/popular_car_repo.dart';

class PopularCarController extends GetxController {
  PopularCarRepo popularCarRepo;
  PopularCarController({required this.popularCarRepo});

  bool isLoading = true;

  Future<void> loadData() async {
    isLoading = true;
    update();

    await loadPopularCarData();

    isLoading = false;
    update();
  }

  List<Datum> popularCarList = [];

  Future<void> loadPopularCarData() async {
    ResponseModel model = await popularCarRepo.getData(page.toString());
    if (model.statusCode == 200) {
      PopularCarResponseModel popularCarResponseModel =
          PopularCarResponseModel.fromJson(jsonDecode(model.responseJson));

      nextPageUrl = popularCarResponseModel.data?.owners?.nextPageUrl ?? '';

      if (popularCarResponseModel.data?.owners?.data != null &&
          popularCarResponseModel.data!.owners!.data!.isNotEmpty) {
        popularCarList.clear();
        popularCarList.addAll(popularCarResponseModel.data!.owners!.data!);
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }
  }

  Future<void> fetchPopularCarData() async {
    page = page + 1;

    ResponseModel model = await popularCarRepo.getData(page.toString());
    if (model.statusCode == 200) {
      PopularCarResponseModel popularCarResponseModel =
          PopularCarResponseModel.fromJson(jsonDecode(model.responseJson));

      nextPageUrl = popularCarResponseModel.data?.owners?.nextPageUrl ?? '';

      if (popularCarResponseModel.data?.owners?.data != null &&
          popularCarResponseModel.data!.owners!.data!.isNotEmpty) {
        popularCarList.addAll(popularCarResponseModel.data!.owners!.data!);
      }

      update();
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }
  }

  String? nextPageUrl = '';
  int page = 1;
  bool hasNext() {
    if (nextPageUrl != null && nextPageUrl!.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
