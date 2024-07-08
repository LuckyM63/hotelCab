import 'dart:convert';

import 'package:booking_box/data/model/featured_car/featured_car_response_model.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../view/components/snack_bar/show_custom_snackbar.dart';
import '../../model/global/response_model/response_model.dart';
import '../../repo/featured_car/featured_car_repo.dart';

class FeaturedCarController extends GetxController {
  FeaturedCarRepo featuredCarRepo;
  FeaturedCarController({required this.featuredCarRepo});

  bool isLoading = true;
  List<Datum> featuredCarList = [];
  String? nextPageUrl = '';
  int page = 1;

  Future<void> loadData() async {
    isLoading = true;
    update();

    await loadFeaturedCarData();

    isLoading = false;
    update();
  }

  Future<void> loadFeaturedCarData() async {
    await _fetchAndProcessData(isInitialLoad: true);
  }

  Future<void> fetchFeaturedCarData() async {
    page++;
    await _fetchAndProcessData(isInitialLoad: false);
  }

  Future<void> _fetchAndProcessData({required bool isInitialLoad}) async {
    ResponseModel model = await featuredCarRepo.getData(page.toString());
    if (model.statusCode == 200) {
      FeaturedCarResponseModel featureCarResponseModel =
          FeaturedCarResponseModel.fromJson(jsonDecode(model.responseJson));

      nextPageUrl =
          featureCarResponseModel.data?.featuredCars?.nextPageUrl ?? '';

      if (featureCarResponseModel.data?.featuredCars?.data != null &&
          featureCarResponseModel.data!.featuredCars!.data!.isNotEmpty) {
        if (isInitialLoad) {
          featuredCarList.clear();
        }
        featuredCarList
            .addAll(featureCarResponseModel.data!.featuredCars!.data!);
      }

      update();
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }
  }

  bool hasNext() {
    return nextPageUrl != null && nextPageUrl!.isNotEmpty;
  }
}
