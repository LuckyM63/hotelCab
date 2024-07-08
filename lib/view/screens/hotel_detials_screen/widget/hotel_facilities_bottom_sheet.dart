import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_strings.dart';
import '../../../../core/utils/style.dart';
import '../../../../data/controller/hotel_details/hotel_details_screen_controller.dart';
import '../../../components/bottom-sheet/bottom_sheet_header_row.dart';

class HotelFacilitiesBottomSheet extends StatelessWidget {
  const HotelFacilitiesBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HotelDetailsScreenController>(
      builder: (controller) => SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BottomSheetHeaderRow(bottomSpace: 0,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                controller.hotelFacilitiesList.isEmpty ? const SizedBox.shrink() :
                Text(MyStrings.facilities.tr,style: boldLarge.copyWith(color: MyColor.titleTextColor,fontSize: 16),),
                const SizedBox(height: 4,),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(controller.hotelFacilitiesList.length, (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: [
                          const Icon(Icons.fiber_manual_record,size: 6,color: MyColor.titleTextColor,),
                          const SizedBox(width: 4,),
                          Text(controller.hotelFacilitiesList[index].name.toString().tr,style: regularLarge.copyWith(color: MyColor.titleTextColor),),
                        ],
                      ),
                    ))
                ),
                controller.hotelFacilitiesList.isEmpty ? const SizedBox.shrink() :
                const SizedBox(height: 10),
                controller.hotelAmenitiesList.isEmpty ? const SizedBox.shrink() :
                Text(MyStrings.amenities.tr,style: boldLarge.copyWith(color: MyColor.titleTextColor,fontSize: 16),),
                const SizedBox(height: 4,),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(controller.hotelAmenitiesList.length, (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: [
                          const Icon(Icons.fiber_manual_record,size: 6,color: MyColor.titleTextColor ,),
                          const SizedBox(width: 4,),
                          Text(controller.hotelAmenitiesList[index].title.toString().tr,style: regularLarge.copyWith(color: MyColor.titleTextColor ),),
                        ],
                      ),
                    ))
                ),
        
              ],
            ),
          ],
        ),
      ),
    );
  }
}