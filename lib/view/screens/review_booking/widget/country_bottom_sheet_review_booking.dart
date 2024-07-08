import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/style.dart';
import 'package:booking_box/data/controller/review_booking/review_booking_controller.dart';
import 'package:booking_box/view/components/bottom-sheet/bottom_sheet_header_row.dart';
import 'package:booking_box/view/components/bottom-sheet/custom_bottom_sheet.dart';

import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/my_strings.dart';
import '../../../../../core/utils/url_container.dart';
import '../../auth/registration/widget/my_image_widget.dart';

class CountryBottomSheetReviewBooking{

  static void bottomSheet(BuildContext context, ReviewBookingController controller) {
    CustomBottomSheet(
      child: StatefulBuilder(
        builder: (BuildContext context, setState) {
          if (controller.filteredCountries.isEmpty) {
            controller.filteredCountries = controller.countryList;
          }
          // Function to filter countries based on the search input.
          void filterCountries(String query) {
            if (query.isEmpty) {
              controller.filteredCountries = controller.countryList;
            } else {
              setState(() {
                controller.filteredCountries = controller.countryList.where((country) => country.name!.toLowerCase().contains(query.toLowerCase())).toList();
              });
              // controller.filteredCountries = controller.filteredCountries.where((country) => country.country!.toLowerCase().contains(query.toLowerCase())).toList();
            }
          }

          return Container(
            height: MediaQuery.of(context).size.height * .8,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            decoration: BoxDecoration(
              color: MyColor.getCardBgColor(),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                const BottomSheetHeaderRow(header: '', bottomSpace: 15),
                const SizedBox(
                  height: 15,
                ),
                // Add the search field.
                TextField(
                  controller: controller.searchController,
                  onChanged: filterCountries,
                  decoration: InputDecoration(
                    hintText: MyStrings.searchCountry.tr,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.grey), // Set the color for the normal border
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: MyColor.primaryColor), // Set the color for the focused border
                    ),
                  ),
                  cursorColor: MyColor.primaryColor,
                ),
                const SizedBox(
                  height: 15,
                ),
                Flexible(
                  child: ListView.builder(
                      itemCount: controller.filteredCountries.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        var countryItem = controller.filteredCountries[index];

                        return GestureDetector(
                          onTap: () {
                            controller.setCountryNameAndCode(
                              controller.filteredCountries[index].name.toString(),
                              controller.filteredCountries[index].code.toString(),
                              controller.filteredCountries[index].dialCode.toString(),
                            );
                            controller.selectCountryData(controller.filteredCountries[index]);
                            Navigator.pop(context);
                            FocusScopeNode currentFocus = FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            controller.phoneNumberFocusNode.nextFocus();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: MyColor.transparentColor,
                              border: Border(
                                bottom: BorderSide(
                                  color: MyColor.colorGrey.withOpacity(0.3),
                                  width: 0.5,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(end: Dimensions.space10),
                                  child: MyImageWidget(
                                    imageUrl: UrlContainer.countryFlagImageLink.replaceAll("{countryCode}", countryItem.code.toString().toLowerCase()),
                                    height: Dimensions.space25,
                                    width: Dimensions.space40 + 2,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(end: Dimensions.space10),
                                  child: Text(
                                    '${countryItem.dialCode}',
                                    style: regularDefault.copyWith(color: MyColor.getTextColor()),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '${countryItem.name?.tr}',
                                    style: regularDefault.copyWith(color: MyColor.getTextColor()),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          );
        },
      ),
    ).customBottomSheet(context);
  }
}