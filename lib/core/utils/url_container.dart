class UrlContainer {
  static const String domainUrl = 'https://bookinghotel.techsteck.com';
  static const String baseUrl = '$domainUrl/api/';
  static const String homeEndPoint = 'home';
  static const String searchDestinationEndPoint = 'search-cities';
  static const String searchEndPoint = 'hotel/search';
  static const String filterByCityEndPoint = 'hotel/filter-by-city';
  static const String filterPramEndPoint = 'hotel/filter-parameters';
  static const String hotelDetailEndPoint = 'hotel/detail/';
  static const String popularHotelEndPoint = 'popular-hotels';
  static const String featuredHotelEndPoint = 'featured-hotels';
  static const String popularCityEndPoint = 'popular-cities';
  static const String bookingRequestEndPoint = 'booking-request/send';
  static const String bookingHistoryEndPoint = 'booking/history';
  static const String bookingDetailsEndPoint = 'booking/detail';
  static const String paymentHistoryEndPoint = 'payment/history';
  static const String bookingRequestHistoryEndPoint = 'booking-request/history';
  static const String cancelBookingEndPoint = 'booking-request/delete';
  static const String socialLogin = 'social-login';
  static const String notificationEndPoint = 'notification-logs';
  static const String countryFlagImageLink =
      'https://flagpedia.net/data/flags/h24/{countryCode}.webp';

  static const String imageUrl = '$domainUrl/assets/images';

  static const String dashBoardEndPoint = 'dashboard';
  static const String depositHistoryUrl = 'deposit/history';
  static const String depositMethodUrl = 'payment/methods';
  static const String depositInsertUrl = 'payment/insert';

  static const String registrationEndPoint = 'register';
  static const String loginEndPoint = 'login';
  static const String logoutUrl = 'logout';
  static const String deleteAccountEndPoint = 'delete-account';
  static const String forgetPasswordEndPoint = 'password/email';
  static const String passwordVerifyEndPoint = 'password/verify-code';
  static const String resetPasswordEndPoint = 'password/reset';
  static const String verify2FAUrl = 'verify-g2fa';
  static const String otpVerify = 'otp-verify';
  static const String otpResend = 'otp-resend';
  static const String verifyEmailEndPoint = 'verify-email';
  static const String verifySmsEndPoint = 'verify-mobile';
  static const String resendVerifyCodeEndPoint = 'resend-verify/';
  static const String authorizationCodeEndPoint = 'authorization';
  static const String dashBoardUrl = 'dashboard';
  static const String transactionEndpoint = 'transactions';
  static const String addWithdrawRequestUrl = 'withdraw-request';
  static const String withdrawMethodUrl = 'withdraw-method';
  static const String withdrawRequestConfirm = 'withdraw-request/confirm';
  static const String withdrawHistoryUrl = 'withdraw/history';
  static const String withdrawStoreUrl = 'withdraw/store/';
  static const String withdrawConfirmScreenUrl = 'withdraw/preview/';
  static const String kycFormUrl = 'kyc-form';
  static const String kycSubmitUrl = 'kyc-submit';
  static const String generalSettingEndPoint = 'general-setting';
  static const String privacyPolicyEndPoint = 'policies';
  static const String getProfileEndPoint = 'user-info';
  static const String updateProfileEndPoint = 'profile-setting';
  static const String profileCompleteEndPoint = 'user-data-submit';
  static const String changePasswordEndPoint = 'change-password';
  static const String countryEndPoint = 'get-countries';

  static const String deviceTokenEndPoint = 'save/device/token';
  static const String languageUrl = 'language/';

  // Base URL
  static const String carBookingDomainUrl = 'https://bookingbox.techsteck.com';
  static const String carBookingBaseUrl = '$carBookingDomainUrl/api/';

// General Endpoints
  static const String carGeneralSettingEndPoint = 'general-setting';
  static const String carCountriesEndPoint = 'get-countries';
  static const String carPopularHotelsEndPoint = 'popular-hotels';
  static const String carPopularCitiesEndPoint = 'popular-cities';
  static const String carSearchCitiesEndPoint = 'search-cities';
  static const String carFeaturedHotelsEndPoint = 'featured-hotels';
  static const String carLanguageEndPoint = 'language/';
  static const String carPoliciesEndPoint = 'policies';

// Authentication Endpoints
  static const String carLoginEndPoint = 'login';
  static const String carSocialLoginEndPoint = 'social-login';
  static const String carRegisterEndPoint = 'register';
  static const String carForgetPasswordEndPoint = 'password/email';
  static const String carPasswordVerifyEndPoint = 'password/verify-code';
  static const String carResetPasswordEndPoint = 'password/reset';

// Authorized Endpoints (Require Authentication)
  static const String carAuthorizationEndPoint = 'authorization';
  static const String carResendVerifyEndPoint = 'resend-verify/';
  static const String carVerifyEmailEndPoint = 'verify-email';
  static const String carVerifySmsEndPoint = 'verify-mobile';
  static const String carVerify2FAEndPoint = 'verify-g2fa';

// User Data and Profile
  static const String carUserDataSubmitEndPoint = 'user-data-submit';
  static const String carSaveDeviceTokenEndPoint = 'save/device/token';
  static const String carHomeEndPoint = 'home';
  static const String carDashboardEndPoint = 'dashboard';
  static const String carUserInfoEndPoint = 'user-info';
  static const String carProfileSettingEndPoint = 'profile-setting';
  static const String carChangePasswordEndPoint = 'change-password';
  static const String carBookingHistoryEndPoint = 'booking/history';
  static const String carBookingDetailsEndPoint = 'booking/detail/';
  static const String carNotificationLogsEndPoint = 'notification-logs';

// Car Booking and Payment Endpoints
  static const String carSearchEndPoint = 'carbook/search';
  static const String carFilterByCityEndPoint = 'carbook/filter-by-city/';
  static const String carFilterParametersEndPoint = 'carbook/filter-parameters';
  static const String carDetailEndPoint = 'carbook/detail/';

// Booking Requests
  static const String carBookingRequestHistoryEndPoint =
      'carbooking-request/history';
  static const String carCancelBookingEndPoint = 'carbooking-request/delete/';
  static const String carBookingRequestSendEndPoint = 'carbooking-request/send';

// Payments
  static const String carPaymentMethodsEndPoint = 'carpayment/methods/';
  static const String carPaymentInsertEndPoint = 'carpayment/insert';
  static const String carPaymentConfirmEndPoint = 'carpayment/confirm';
  static const String carManualPaymentConfirmEndPoint = 'carpayment/manual';
  static const String carManualPaymentUpdateEndPoint = 'carpayment/manual';

// Miscellaneous
  static const String carLogoutEndPoint = 'logout';
  static const String carDeleteAccountEndPoint = 'delete-account';

// Profile Image URL
  static const String carImageUrl = '$carBookingDomainUrl/assets/images';

// Example Static URL (e.g., for country flags)
  static const String carCountryFlagImageLink =
      'https://flagpedia.net/data/flags/h24/{countryCode}.webp';
}
