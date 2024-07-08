import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_box/data/controller/auth/auth/registration_controller.dart';
import 'package:booking_box/data/controller/review_booking/review_booking_controller.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/style.dart';
import '../../../../data/repo/auth/general_setting_repo.dart';
import '../../../../data/repo/auth/signup_repo.dart';
import '../../../../data/services/api_service.dart';
import 'country_bottom_sheet_review_booking.dart';

class BookingTextField extends StatefulWidget {

  final String? labelText;
  final String? hintText;
  final Function? onChanged;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final FormFieldValidator? validator;
  final TextInputType? textInputType;
  final bool isEnable;
  final bool isPassword;
  final bool isShowSuffixIcon;
  final bool isIcon;
  final VoidCallback? onSuffixTap;
  final TextInputAction inputAction;
  final bool needOutlineBorder;
  final bool readOnly;
  final int maxLines;
  final Color fillColor;
  final bool isRequired;
  final String? prefixIconSvg;
  final Color? svgIconColor;
  final bool phoneNumberTextField;

  const BookingTextField({
    Key? key,
    this.labelText,
    this.readOnly = false,
    this.fillColor = MyColor.transparentColor,
    required this.onChanged,
    this.hintText,
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.validator,
    this.textInputType,
    this.isEnable = true,
    this.isPassword = false,
    this.isShowSuffixIcon = false,
    this.isIcon = false,
    this.onSuffixTap,
    this.inputAction = TextInputAction.next,
    this.needOutlineBorder = false,
    this.maxLines = 1,
    this.isRequired = false,
    this.prefixIconSvg,
    this.svgIconColor,
    this.phoneNumberTextField = false
  }) : super(key: key);

  @override
  State<BookingTextField> createState() => _BookingTextFieldState();
}

class _BookingTextFieldState extends State<BookingTextField> {

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GeneralSettingRepo(apiClient: Get.find()));
    Get.put(RegistrationRepo(apiClient: Get.find()));
    Get.put(RegistrationController(registrationRepo: Get.find(), generalSettingRepo: Get.find()));
    super.initState();
  }

  bool obscureText = true;

  @override
  Widget build(BuildContext context) {

    return widget.phoneNumberTextField == false ? TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        onFieldSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus) : null,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: Dimensions.space20, vertical: Dimensions.space5),
          fillColor: widget.fillColor,
          filled: true,
          labelText: widget.labelText,
          labelStyle: regularLarge.copyWith(color: MyColor.bodyTextColor2,fontWeight: FontWeight.w500),
          enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: MyColor.transparentColor),borderRadius: BorderRadius.circular(6)),
          focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: MyColor.transparentColor),borderRadius: BorderRadius.circular(6)),
          errorBorder: OutlineInputBorder(borderSide: const BorderSide(width:0.5,color: MyColor.colorRed), borderRadius: BorderRadius.circular(6)),
          focusedErrorBorder: OutlineInputBorder(borderSide: const BorderSide(width:0.5,color: MyColor.colorRed), borderRadius: BorderRadius.circular(6)),
        ),
        validator: widget.validator
    ):
    GetBuilder<ReviewBookingController>(
      builder: (controller) => Row(
        children: [
          Expanded(
            flex: 5,
            child: GestureDetector(
              onTap: () {
                CountryBottomSheetReviewBooking.bottomSheet(context, Get.find());
              },
              child: Container(
                padding: const EdgeInsets.only(left: Dimensions.space11,top: 17,bottom: 17,),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(6),bottomLeft: Radius.circular(6)),
                  color: widget.fillColor,
                  // color: Colors.green,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(controller.selectedCountryDialCode,style: regularLarge,),
                    Container(
                      margin: const EdgeInsets.only(left: 7),
                      width: 1,
                      height: 10,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 16,
            child: TextFormField(
                controller: widget.controller,
                focusNode: widget.focusNode,
                keyboardType: TextInputType.number,
                onFieldSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus) : null,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: Dimensions.space16),
                  fillColor: widget.fillColor,
                  filled: true,
                  labelText: widget.labelText,
                  labelStyle: regularLarge.copyWith(color: MyColor.bodyTextColor2,fontWeight: FontWeight.w500),
                  enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: MyColor.transparentColor),borderRadius: BorderRadius.only(topRight: Radius.circular(6),bottomRight: Radius.circular(6))),
                  focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: MyColor.transparentColor),borderRadius: BorderRadius.only(topRight: Radius.circular(6),bottomRight: Radius.circular(6))),
                ),
                validator: widget.validator
            ),
          ),
        ],
      ),
    );
  }
}