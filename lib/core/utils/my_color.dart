import 'package:flutter/material.dart';

class MyColor{

  static const Color primaryColor     = Color(0xff007BFF);
  static const Color secondaryColor   = Color(0xffF6F7FE);
  static const Color screenBgColor    = Color(0xFFF9F9F9);
  static const Color primaryTextColor = Color(0xff262626);
  static const Color contentTextColor = Color(0xff777777);
  static const Color naturalDark      = Color(0xff6D7B84);
  static const Color lightGray      = Color(0xffBDBDBD);
  // static const Color lineColor                   = Color(0xffECECEC);
  static const Color borderColor                 = Color(0xffD9D9D9);
  static const Color lightBodyText                    = Color(0xffABA8B0);
  // static const Color bodyTextColor               = Color(0xFF747475);

  static const Color titleColor                  = Color(0xff212121);
  static const Color labelTextColor              = Color(0xff444444);
  static const Color smallTextColor1             = Color(0xff555555);

  static const Color appBarColor                 = primaryColor;
  static const Color appBarContentColor          = colorWhite;

  static const Color textFieldDisableBorderColor = Color(0xffCFCEDB);
  static const Color textFieldEnableBorderColor  = primaryColor;
  static const Color hintTextColor               = Color(0xff98a1ab);

  static const Color primaryButtonColor          = primaryColor;
  static const Color primaryButtonTextColor      = colorWhite;
  static const Color secondaryButtonColor        = colorWhite;
  static const Color secondaryButtonTextColor    = colorBlack;

  static const Color iconColor                   = Color(0xff555555);
  static const Color titleTextColor              = Color(0xff263141);
  static const Color info                        = Color(0xff056998);
  static const Color filterEnableIconColor       = primaryColor;
  static const Color filterIconColor             = iconColor;

  static const Color colorWhite                  = Color(0xffFFFFFF);
  static const Color colorBlack                  = Color(0xff262626);
  static const Color colorGreen                  = Color(0xff28C76F);
  static const Color colorRed                    = Color(0xFFD92027);
  static const Color colorGrey                   = Color(0xff555555);
  static const Color colorOrange                 = Color(0xfffd7e14);
  static const Color colorGreyLight              = Color(0xffb8c2cc);
  static const Color transparentColor            = Colors.transparent;

  static const Color greenSuccessColor       = greenP;
  static const Color redCancelTextColor      = Color(0xFFF93E2C);
  static const Color dangerColor             = Color(0xFFf33a3a);
  static const Color highPriorityPurpleColor = Color(0xFF7367F0);
  static const Color pendingColor            = Colors.orange;
  static const Color colorYellow             = Color(0xffffc107);
  static const Color bodyTextGrey             = Color(0xffA1ABB9);
  static const Color tealColor             = Color(0xff29A893);

  static const Color greenP           = Color(0xFF28C76F);
  static const Color containerBgColor = Color(0xffF9F9F9);
  static const Color bodyTextColor2   = Color(0xff6e6b7b);
  static const Color thinTextColor   = Color(0xff474F5A);
  static const Color textFieldFillColor   = Color(0xffA1ABB9);
  static const Color dividerColor   = Color(0xffDDE3EB);

  static const Color bodyTextColor   = Color(0xff9E9E9E);
  static const Color grayScale800    = Color(0xff424242);
  static const Color grayScale100    = Color(0xffF5F5F5);
  static const Color grayScale600    = Color(0xff757575);
  static const Color backgroundColor = Color(0xffF5F5F5);
  static const Color primary50       = Color(0xffC0DBFB);
  static const Color bgColor2        = Color(0xffF7F8FA);
  static const Color lineColor       = Color(0xffDDE3EB);
  static const Color appBarColor2    = colorWhite;

  static const Color textFieldColor  = Color(0xffF1F4F7);
  static const Color bgColor         = Color(0xffebf0f4);
  static const Color starColor       = Color(0xffFFC107);
  static const Color skyBlue       = Color(0xffecf3fd);
  static const Color darkBlue       = Color(0xff346aae);
  static const Color naturalLight   = Color(0xffA1ACB2);
  static Color primaryTxtColor700    = primaryTextColor.withOpacity(.7);
  static Color primaryTxtColor800    = primaryTextColor.withOpacity(.8);

  static Color highlightColorShimmer = colorGrey.withOpacity(0.2);
  static Color baseColorShimmer      = primaryColor.withOpacity(0.4);
  static Color componentColorShimmer      = colorGrey.withOpacity(.2);

  static const Color shadowColor = Color(0xffEAEAEA);

  static Color getPrimaryColor(){
    return primaryColor;
  }

  static Color getShadowColor() {
    return shadowColor;
  }

  static Color getScreenBgColor({bool isWhite = false}){
    return isWhite?colorWhite : screenBgColor;
  }

  static Color getGreyText(){
    return  MyColor.colorBlack.withOpacity(0.5);
  }

  static Color getAppBarColor(){
    return appBarColor;
  }
  static Color getAppBarContentColor(){
    return appBarContentColor;
  }

  static Color getHeadingTextColor(){
    return primaryTextColor;
  }

  static Color getContentTextColor(){
    return contentTextColor;
  }

  static Color getLabelTextColor(){
    return thinTextColor;
  }

  static Color getHintTextColor(){
    return hintTextColor;
  }

  static Color getTextFieldDisableBorder(){
    return textFieldDisableBorderColor;
  }

  static Color getTextFieldEnableBorder(){
    return textFieldEnableBorderColor;
  }

  static Color getPrimaryButtonColor(){
    return primaryButtonColor;
  }

  static Color getPrimaryButtonTextColor(){
    return primaryButtonTextColor;
  }

  static Color getSecondaryButtonColor(){
    return secondaryButtonColor;
  }

  static Color getSecondaryButtonTextColor(){
    return secondaryButtonTextColor;
  }

  static Color getIconColor(){
    return iconColor;
  }

  static Color getFilterDisableIconColor(){
    return filterIconColor;
  }

  static Color getSearchEnableIconColor(){
    return colorRed;
  }

  static Color getTransparentColor(){
    return transparentColor;
  }

  static Color getTextColor(){
    return colorBlack;
  }

  static Color getCardBgColor(){
    return colorWhite;
  }

  static List<Color>symbolPlate = [
  const Color(0xffDE3163),
  const Color(0xffC70039),
  const Color(0xff900C3F),
  const Color(0xff581845),
  const Color(0xffFF7F50),
  const Color(0xffFF5733),
  const Color(0xff6495ED),
  const Color(0xffCD5C5C),
  const Color(0xffF08080),
  const Color(0xffFA8072),
  const Color(0xffE9967A),
  const Color(0xff9FE2BF),
  ];

  static getSymbolColor(int index) {
     int colorIndex = index>10?index%10:index;
     return symbolPlate[colorIndex];
  }

}