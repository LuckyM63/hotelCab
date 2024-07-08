import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/utils/my_images.dart';
import 'package:booking_box/data/controller/home/home_controller.dart';

import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/style.dart';

class CustomSearchTextField extends StatefulWidget {

  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final FormFieldValidator? validator;
  final TextInputType? textInputType;
  final bool isEnable;
  final bool isPassword;
  final bool isShowSuffixIcon;
  final bool isIcon;
  final VoidCallback onSuffixTap;
  final TextInputAction inputAction;
  final bool needOutlineBorder;
  final bool readOnly;
  final int maxLines;
  final Color fillColor;
  final bool isRequired;
  final String? prefixIconSvg;
  final Color? svgIconColor;
  final VoidCallback? onEditCompleted;

  const CustomSearchTextField({
    Key? key,
    this.labelText,
    this.readOnly = false,
    this.fillColor = MyColor.transparentColor,
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
    required this.onSuffixTap,
    this.inputAction = TextInputAction.next,
    this.needOutlineBorder = false,
    this.maxLines = 1,
    this.isRequired = false,
    this.prefixIconSvg,
    this.svgIconColor,
    this.onEditCompleted,
  }) : super(key: key);

  @override
  State<CustomSearchTextField> createState() => _CustomSearchTextFieldState();
}

class _CustomSearchTextFieldState extends State<CustomSearchTextField> {

  bool obscureText = true;

  @override
  Widget build(BuildContext context) {

    return GetBuilder<HomeController>(
      builder: (controller) => PhysicalModel(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
        elevation: 1.5,
        shadowColor: MyColor.bgColor2,
        child: TextFormField(
            textInputAction: widget.inputAction,
            autofocus: true,
            controller: widget.controller,
            focusNode: widget.focusNode,
            onFieldSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus) : null,
            onChanged: (value) {
              // controller.filterData(value);
            },
            decoration: InputDecoration(
              
              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical:0),
              fillColor: widget.fillColor,
              filled: true,
              hintText: widget.labelText?.tr,
              hintStyle: const TextStyle(color: MyColor.naturalDark,fontWeight: FontWeight.w400,fontSize: 14),
              suffixIcon: GestureDetector(
                onTap: widget.onSuffixTap,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12,bottom: 12,right: 10),
                  child: SvgPicture.asset(MyImages.searchSvg,width: 10,height: 10,colorFilter: ColorFilter.mode(MyColor.naturalDark.withOpacity(.7), BlendMode.srcIn),),
                ),
              ),
              prefixIcon: Container(
                padding: EdgeInsets.zero,
                  margin: const EdgeInsets.symmetric(vertical: 15,horizontal: 0),
                  child: SvgPicture.asset(MyImages.location,colorFilter: const ColorFilter.mode(MyColor.naturalDark, BlendMode.srcIn),)),
              labelStyle: regularDefault.copyWith(color: MyColor.colorBlack,fontWeight: FontWeight.w400),
              enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: MyColor.transparentColor),borderRadius: BorderRadius.circular(18)),
              focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: MyColor.transparentColor),borderRadius: BorderRadius.circular(18)),
            ),
            validator: widget.validator,
            onEditingComplete: widget.onEditCompleted,
        ),
      ),
    );
  }
}