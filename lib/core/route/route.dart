import 'package:booking_box/view/components/bottom-nav-bar/bottom_nav_bar.dart';
import 'package:booking_box/view/screens/Profile/profile_screen.dart';
import 'package:booking_box/view/screens/account/change-password/change_password_screen.dart';
import 'package:booking_box/view/screens/auth/email_verification_page/email_verification_screen.dart';
import 'package:booking_box/view/screens/auth/forget_password/forget_password/forget_password.dart';
import 'package:booking_box/view/screens/auth/forget_password/reset_password/reset_password_screen.dart';
import 'package:booking_box/view/screens/auth/forget_password/verify_forget_password/verify_forget_password_screen.dart';
import 'package:booking_box/view/screens/auth/kyc/kyc.dart';
import 'package:booking_box/view/screens/auth/login/login_screen.dart';
import 'package:booking_box/view/screens/auth/profile_complete/profile_complete_screen.dart';
import 'package:booking_box/view/screens/auth/registration/registration_screen.dart';
import 'package:booking_box/view/screens/auth/sms_verification_page/sms_verification_screen.dart';
import 'package:booking_box/view/screens/auth/two_factor_screen/two_factor_verification_screen.dart';
import 'package:booking_box/view/screens/booking_history/booking_request_screen.dart';
import 'package:booking_box/view/screens/edit_profile/edit_profile_screen.dart';
import 'package:booking_box/view/screens/featured_car/featured_car_screen.dart';
import 'package:booking_box/view/screens/featured_hotel/featured_hotel_screen.dart';
import 'package:booking_box/view/screens/filter/filter_screen.dart';
import 'package:booking_box/view/screens/language/language_screen.dart';
import 'package:booking_box/view/screens/notification_screen/notification_screen.dart';
import 'package:booking_box/view/screens/onboard/onboard_screen.dart';
import 'package:booking_box/view/screens/payment_log/payment_log_screen.dart';
import 'package:booking_box/view/screens/popular_city/popular_city_screen.dart';
import 'package:booking_box/view/screens/popular_hotel/popular_hotel_screen.dart';
import 'package:booking_box/view/screens/privacy_policy/privacy_policy_screen.dart';
import 'package:booking_box/view/screens/review_booking/review_booking_screen.dart';
import 'package:booking_box/view/screens/room_details/room_details_screen.dart';
import 'package:booking_box/view/screens/search/search_screen.dart';
import 'package:booking_box/view/screens/search_result/search_result_screen.dart';
import 'package:booking_box/view/screens/select_room/select_room_screen.dart';
import 'package:booking_box/view/screens/splash/splash_screen.dart';
import 'package:get/get.dart';

import '../../view/screens/bottom_nav_section/my_booking/my_booking_screen.dart';
import '../../view/screens/car_details_screen/car_details_screen.dart';
import '../../view/screens/deposits/deposit_webview/my_webview_screen.dart';
import '../../view/screens/deposits/deposits_screen.dart';
import '../../view/screens/deposits/payment/complement_payment.dart';
import '../../view/screens/hotel_detials_screen/hotel_details_screen.dart';
import '../../view/screens/photo_view_screen/photo_view_screen.dart';
import '../../view/screens/popular_car/popular_car_screen.dart';

class RouteHelper {
  static const String splashScreen = "/splash_screen";
  static const String loginScreen = "/login_screen";
  static const String forgotPasswordScreen = "/forgot_password_screen";
  static const String changePasswordScreen = "/change_password_screen";
  static const String registrationScreen = "/registration_screen";
  static const String bottomNavBar = "/bottom_nav_bar";
  static const String profileCompleteScreen = "/profile_complete_screen";
  static const String emailVerificationScreen = "/verify_email_screen";
  static const String smsVerificationScreen = "/verify_sms_screen";
  static const String verifyPassCodeScreen = "/verify_pass_code_screen";
  static const String twoFactorScreen = "/two-factor-screen";
  static const String resetPasswordScreen = "/reset_pass_screen";
  static const String notificationScreen = "/notification_screen";
  static const String profileScreen = "/profile_screen";
  static const String editProfileScreen = "/edit_profile_screen";
  static const String kycScreen = "/kyc_screen";
  static const String privacyScreen = "/privacy-screen";

  static const String addWithdrawMethodScreen = "/withdraw-method";
  static const String withdrawConfirmScreenScreen = "/withdraw-preview-screen";
  static const String featuredHotelScreen = "/featured_hotel_screen";
  static const String featuredCarScreen = "/featured_car_screen";
  static const String depositsScreen = "/deposits";
  static const String newDepositScreenScreen = "/deposits_money";
  static const String depositWebViewScreen = '/deposit_webView';
  static const String searchScreen = '/search_screen';
  static const String searchResultScreen = '/search_result_screen';
  static const String filterScreen = '/filter_screen';
  static const String myBookingScreen = '/my_booking_screen';
  static const String activityScreen = '/activity_screen';
  static const String paymentLogScreen = '/payment_log_screen';
  static const String hotelDetailsScreen = '/hotel_details_screen';
  static const String carDetailsScreen = '/car_details_screen';
  static const String selectRoomScreen = '/select_room_screen';
  static const String roomDetailsScreen = '/room_details_screen';
  static const String reviewBookingScreen = '/review_booking_screen';
  static const String popularHotelScreen = '/popular_hotel_screen';
  static const String popularCarScreen = '/popular_car_screen';
  static const String popularCityScreen = '/popular_destination_screen';
  static const String bookingRequestScreen = '/booking_request_screen';
  static const String onboardScreen = '/onboard_screen';
  static const String bookingHistoryScreen = '/booking_history_screen';
  static const String photoViewScreen = '/photo_view_screen';
  static const String languageScreen = '/language_screen';

  List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(
        name: forgotPasswordScreen, page: () => const ForgetPasswordScreen()),
    GetPage(
        name: changePasswordScreen, page: () => const ChangePasswordScreen()),
    GetPage(name: registrationScreen, page: () => const RegistrationScreen()),
    GetPage(
        name: profileCompleteScreen, page: () => const ProfileCompleteScreen()),
    GetPage(name: bottomNavBar, page: () => const BottomNavBar()),
    GetPage(name: profileScreen, page: () => const ProfileScreen()),
    GetPage(name: editProfileScreen, page: () => const EditProfileScreen()),
    GetPage(name: kycScreen, page: () => const KycScreen()),
    GetPage(
        name: depositWebViewScreen,
        page: () => MyWebViewScreen(redirectUrl: Get.arguments)),
    GetPage(name: depositsScreen, page: () => const DepositsScreen()),
    GetPage(
        name: newDepositScreenScreen,
        page: () => const CompletePaymentScreen(bookingId: '')),
    GetPage(
        name: emailVerificationScreen,
        page: () => EmailVerificationScreen(
              needSmsVerification: Get.arguments[0],
              isProfileCompleteEnabled: Get.arguments[1],
              needTwoFactor: Get.arguments[2],
            )),
    GetPage(
        name: smsVerificationScreen, page: () => const SmsVerificationScreen()),
    GetPage(
        name: verifyPassCodeScreen, page: () => const VerifyForgetPassScreen()),
    GetPage(name: resetPasswordScreen, page: () => const ResetPasswordScreen()),
    GetPage(
        name: twoFactorScreen,
        page: () => TwoFactorVerificationScreen(
            isProfileCompleteEnable: Get.arguments)),
    GetPage(name: onboardScreen, page: () => const OnBoardScreen()),
    GetPage(name: kycScreen, page: () => const KycScreen()),
    GetPage(name: privacyScreen, page: () => const PrivacyPolicyScreen()),
    GetPage(name: searchScreen, page: () => const SearchScreen()),
    GetPage(
        name: searchResultScreen,
        page: () => SearchResultScreen(
              isFromDestination: Get.arguments,
            )),
    GetPage(name: filterScreen, page: () => const FilterScreen()),
    GetPage(name: myBookingScreen, page: () => const MyBookingScreen()),
    GetPage(
        name: hotelDetailsScreen,
        page: () => HotelDetailsScreen(
              hotelId: Get.arguments,
            )),
    GetPage(name: selectRoomScreen, page: () => const SelectRoomScreen()),
    GetPage(
        name: roomDetailsScreen,
        page: () => RoomDetailsScreen(
              index: Get.arguments,
            )),
    GetPage(name: reviewBookingScreen, page: () => const ReviewBookingScreen()),
    GetPage(name: popularHotelScreen, page: () => const PopularHotelScreen()),
    GetPage(name: popularCityScreen, page: () => const PopularCityScreen()),
    GetPage(
        name: bookingRequestScreen,
        page: () => BookingRequestScreen(isFromMenu: Get.arguments)),
    GetPage(name: featuredHotelScreen, page: () => const FeaturedHotelScreen()),
    GetPage(name: notificationScreen, page: () => const NotificationScreen()),
    GetPage(name: paymentLogScreen, page: () => const PaymentLogScreen()),
    GetPage(name: languageScreen, page: () => const LanguageScreen()),
    GetPage(
        name: photoViewScreen,
        page: () => PhotoViewScreen(
            imageUrl: Get.arguments[0], initialIndex: Get.arguments[1])),
    GetPage(
        name: carDetailsScreen,
        page: () => CarDetailsScreen(
              hotelId: Get.arguments,
            )),
    GetPage(name: featuredCarScreen, page: () => const FeaturedCarScreen()),
    GetPage(name: popularCarScreen, page: () => const PopularCarScreen()),
  ];
}
