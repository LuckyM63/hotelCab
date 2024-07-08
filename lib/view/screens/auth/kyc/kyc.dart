import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/utils/dimensions.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/data/controller/kyc_controller/kyc_controller.dart';
import 'package:booking_box/data/model/kyc/kyc_response_model.dart' as kyc;
import 'package:booking_box/data/repo/kyc/kyc_repo.dart';
import 'package:booking_box/data/services/api_service.dart';
import 'package:booking_box/view/components/app-bar/custom_appbar.dart';
import 'package:booking_box/view/components/buttons/rounded_button.dart';
import 'package:booking_box/view/components/buttons/rounded_loading_button.dart';
import 'package:booking_box/view/components/checkbox/custom_check_box.dart';
import 'package:booking_box/view/components/custom_drop_down_button_with_text_field.dart';
import 'package:booking_box/view/components/custom_loader/custom_loader.dart';
import 'package:booking_box/view/components/custom_no_data_found_class.dart';
import 'package:booking_box/view/components/custom_radio_button.dart';
import 'package:booking_box/view/components/form_row.dart';
import 'package:booking_box/view/components/text-form-field/custom_text_field.dart';
import 'package:booking_box/view/screens/auth/kyc/widget/already_verifed.dart';
import 'package:booking_box/view/screens/auth/kyc/widget/widget/file_item.dart';

class KycScreen extends StatefulWidget {
  const KycScreen({Key? key}) : super(key: key);

  @override
  State<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> {

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(KycRepo(apiClient: Get.find()));
    Get.put(KycController(repo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<KycController>().beforeInitLoadKycData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<KycController>(
      builder: (controller) =>
          GestureDetector(
            onTap: (){
                FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              backgroundColor: MyColor.getScreenBgColor(),
              appBar: const CustomAppBar(title: MyStrings.kyc,bgColor:MyColor.primaryColor,),
              body: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: controller.isLoading ? const Padding(padding:EdgeInsets.all(Dimensions.space15),child:CustomLoader()):controller.isAlreadyVerified?const AlreadyVerifiedWidget():controller.isAlreadyPending?const AlreadyVerifiedWidget(isPending: true,):controller.isNoDataFound? const NoDataOrInternetScreen():Center(
                    child: SingleChildScrollView(
                      padding: Dimensions.screenPaddingHV,
                      child: Form(
                        key:formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: controller.formList.length,
                              itemBuilder: (ctx,index){
                                kyc.FormModel? model=controller.formList[index];
                                return Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      model.type=='text'?
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CustomTextField(
                                            isRequired: model.isRequired=='optional'?false:true,
                                            hintText: (model.name??'').toString().capitalizeFirst,
                                            needOutlineBorder: true,
                                            labelText: model.name??'',
                                            validator: (value){
                                              if(model.isRequired != 'optional ' && value.toString().isEmpty){
                                                return '${model.name.toString().capitalizeFirst} ${MyStrings.isRequired}';
                                              }else{
                                                return null;
                                              }
                                            },
                                            onChanged: (value){
                                              controller.changeSelectedValue(value, index);
                                            }
                                          ),
                                          const SizedBox(height: Dimensions.space10),
                                        ],
                                      ):model.type=='textarea'?Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CustomTextField(
                                            isRequired: model.isRequired=='optional'?false:true,
                                            needOutlineBorder: true,
                                            labelText: model.name??'',
                                            hintText: (model.name??'').capitalizeFirst,
                                            validator: (value){
                                              if(model.isRequired != 'optional ' && value.toString().isEmpty){
                                                return '${model.name.toString().capitalizeFirst} ${MyStrings.isRequired}';
                                              }else{
                                                return null;
                                              }
                                            },
                                            onChanged: (value){
                                              controller.changeSelectedValue(value, index);
                                            }
                                          ),
                                          const SizedBox(height: Dimensions.space10),
                                        ],
                                      ):model.type=='select'?
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          FormRow(label: model.name??'', isRequired: model.isRequired=='optional'?false:true),
                                          const SizedBox(height: Dimensions.textToTextSpace,),
                                          CustomDropDownWithTextField(list: model.options??[],onChanged: (value){
                                            controller.changeSelectedValue(value,index);
                                          },selectedValue: model.selectedValue),
                                          const SizedBox(height: Dimensions.space10)
                                        ],
                                      ):
                                      model.type=='radio'?
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          FormRow(label: model.name??'', isRequired: model.isRequired=='optional'?false:true),
                                          CustomRadioButton(title:model.name,selectedIndex:controller.formList[index].options?.indexOf(model.selectedValue??'')??0,list: model.options??[],onChanged: (selectedIndex){
                                            controller.changeSelectedRadioBtnValue(index,selectedIndex);
                                          },),
                                        ],
                                      ):model.type=='checkbox'?Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          FormRow(label: model.name??'', isRequired: model.isRequired=='optional'?false:true),
                                          CustomCheckBox(selectedValue:controller.formList[index].cbSelected,list: model.options??[],onChanged: (value){
                                            controller.changeSelectedCheckBoxValue(index,value);
                                          },),
                                        ],
                                      ):model.type=='file'?Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          FormRow(label: model.name??'', isRequired: model.isRequired=='optional'?false:true),
                                          Padding(
                                              padding: const EdgeInsets.symmetric(vertical: Dimensions.textToTextSpace),
                                              child: ConfirmWithdrawFileItem(
                                                  index:index
                                              )
                                          )
                                        ],
                                      ):const SizedBox(),
                                      const SizedBox(height: Dimensions.space10),
                                    ],
                                  ),
                                );
                              }
                          ),
                            const SizedBox(height: Dimensions.space25),
                            Center(
                              child: controller.submitLoading? const RoundedLoadingBtn(): RoundedButton(
                              press: () {
                                if(formKey.currentState!.validate()){
                                  controller.submitKycData();
                                }
                              },
                              text: MyStrings.submit,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
              ),
            ),
          ),
    );
  }
}
