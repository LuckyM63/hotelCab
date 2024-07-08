import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:booking_box/core/helper/shared_preference_helper.dart';
import 'package:booking_box/core/route/route.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/data/model/auth/login/login_response_model.dart';
import 'package:booking_box/data/model/global/response_model/response_model.dart';
import 'package:booking_box/data/repo/auth/login_repo.dart';
import 'package:booking_box/view/components/snack_bar/show_custom_snackbar.dart';
import '../../../view/screens/auth/profile_complete/profile_complete_screen.dart';




class LoginController extends GetxController{
  @override
  void onInit() {
    super.onInit();
    firebaseUser.value = firebaseAuth.currentUser;
    firebaseAuth.authStateChanges().listen((user) {
      firebaseUser.value = user;
    });
  }

  LoginRepo loginRepo;
  LoginController({required this.loginRepo});

  final FocusNode emailFocusNode    = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  TextEditingController emailController    = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? email;
  String? password;

  List<String>errors = [];
  bool remember      = false;



  void forgetPassword() {
    Get.toNamed(RouteHelper.forgotPasswordScreen);
  }

  void checkAndGotoNextStep(LoginResponseModel responseModel, {bool signInWithGoogle = false}) async{

    bool needEmailVerification=responseModel.data?.user?.ev == "0" ? true :false;
    bool needSmsVerification=responseModel.data?.user?.sv   == '0' ? true :false;
    bool isTwoFactorEnable = responseModel.data?.user?.tv   == '0' ? true :false;

    if(remember){
      await loginRepo.apiClient.sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, true);
    }else{
      await loginRepo.apiClient.sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey,false);
    }

    await loginRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userIdKey,          responseModel.data?.user?.id.toString()??'-1');
    await loginRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.accessTokenKey,     responseModel.data?.accessToken??'');
    await loginRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.accessTokenType,    responseModel.data?.tokenType??'');
    await loginRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userEmailKey,       responseModel.data?.user?.email??'');
    await loginRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userPhoneNumberKey, responseModel.data!.user!.mobile??'');
    await loginRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userNameKey,        responseModel.data?.user?.username??'');
    await loginRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.firstName,        responseModel.data?.user?.firstname??'');
    await loginRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.lastName,        responseModel.data?.user?.lastname??'');
    await loginRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.socialId,        responseModel.data?.user?.socialId??'');
    await loginRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userSelectedCountryCode, responseModel.data?.user?.countryCode ?? '');

    await loginRepo.sendUserToken();
    bool isProfileCompleteEnable = responseModel.data?.user?.regStep == '0'?true:false;

    if( needSmsVerification == false && needEmailVerification == false && isTwoFactorEnable == false) {

      if(isProfileCompleteEnable){
        Get.offAndToNamed(RouteHelper.profileCompleteScreen);
        Get.to(ProfileCompleteScreen(signInWithGoogle: signInWithGoogle,));
      }else{
        Get.offAndToNamed(RouteHelper.bottomNavBar);
      }

    }else if(needSmsVerification==true&&needEmailVerification==true && isTwoFactorEnable == true){
      Get.offAndToNamed(RouteHelper.emailVerificationScreen, arguments: [true,isProfileCompleteEnable,isTwoFactorEnable]);
    }
    else if(needSmsVerification==true&&needEmailVerification==true){
      Get.offAndToNamed(RouteHelper.emailVerificationScreen, arguments: [true,isProfileCompleteEnable,isTwoFactorEnable]);
    }else if(needSmsVerification){
      Get.offAndToNamed(RouteHelper.smsVerificationScreen,   arguments: [isProfileCompleteEnable,isTwoFactorEnable]);
    }else if(needEmailVerification){
      Get.offAndToNamed(RouteHelper.emailVerificationScreen, arguments: [false,isProfileCompleteEnable,isTwoFactorEnable]);
    } else if(isTwoFactorEnable){
      Get.offAndToNamed(RouteHelper.twoFactorScreen,         arguments: isProfileCompleteEnable);
    }

    if(remember){
      changeRememberMe();
    }

  }

  bool isSubmitLoading = false;
  void loginUser() async {

    isSubmitLoading = true;
    update();

    ResponseModel model= await loginRepo.loginUser(emailController.text.toString(), passwordController.text.toString());

    if(model.statusCode==200){
      LoginResponseModel loginModel=LoginResponseModel.fromJson(jsonDecode(model.responseJson));
      if(loginModel.status.toString().toLowerCase() == MyStrings.success.toLowerCase()){


        loginRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.firstName, loginModel.data?.user?.firstname ?? 'User');
        loginRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.lastName, loginModel.data?.user?.lastname ?? '');

        checkAndGotoNextStep(loginModel);
      }else{
        CustomSnackBar.error(errorList: loginModel.message?.error??[MyStrings.loginFailedTryAgain]);
      }
    }
    else{
      CustomSnackBar.error(errorList: [model.message]);
    }

    isSubmitLoading = false;
    update();

  }

  changeRememberMe() {
    remember = !remember;
    update();
  }


  void clearTextField() {

    passwordController.text = '';
    emailController.text    = '';

    if(remember){
      remember = false;
    }
    update();

  }

//---------------login with google------------

  bool isSocialSubmitLoading = false;

  Future socialLoginUser({String? email, String? uid, String? displayName}) async {
    isSocialSubmitLoading = true;

    update();

    late ResponseModel responseModel;

    responseModel = await loginRepo.socialLoginUser(
        email: email,
        uid: uid,
        name: displayName
    );

    if (responseModel.statusCode == 200) {
      LoginResponseModel loginModel = LoginResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (loginModel.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
        checkAndGotoNextStep(loginModel,signInWithGoogle: true);
      } else {
        isSocialSubmitLoading = false;
        update();
        CustomSnackBar.error(errorList: loginModel.message?.error ?? [MyStrings.loginFailedTryAgain.tr]);
      }
    } else {
      isSocialSubmitLoading = false;
      update();
      CustomSnackBar.error(errorList: [responseModel.message]);
    }

    isSocialSubmitLoading = false;
    update();
  }


  final GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser.obs;

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        // throw Exception('Google Sign-In canceled by user');
        return;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;


      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await firebaseAuth.signInWithCredential(credential);

      await socialLoginUser(email: firebaseUser.value!.email, uid: firebaseUser.value!.uid,displayName: firebaseUser.value!.displayName);
    } catch (e) {
      debugPrint(e.toString());
      CustomSnackBar.error(errorList: [e.toString()]);
    }
  }

  Future<void> signOutGoogleAuth() async {
    try {
      await firebaseAuth.signOut();
      await googleSignIn.signOut();
    } catch (e) {
      CustomSnackBar.error(errorList: [e.toString()]);
    }
  }

}
