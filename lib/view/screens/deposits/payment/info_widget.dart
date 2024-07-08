import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_strings.dart';
import '../../../../data/controller/deposit/add_new_deposit_controller.dart';
import '../../../components/row_widget/custom_row.dart';

class InfoWidget extends StatelessWidget {

  final AddNewDepositController controller;

  const InfoWidget({Key? key,required this.controller}) : super(key: key,);

  @override
  Widget build(BuildContext context) {
    bool showRate = controller.isShowRate();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: Dimensions.space20,),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
              border: Border.all(color: MyColor.primaryColor.withOpacity(.2))
          ),
          child: Column(
            children: [
              const SizedBox(height: 15,),
              CustomRow(firstText: MyStrings.gatewayLimit.tr, lastText: controller.depositLimit,),
              CustomRow(firstText: MyStrings.gatewayCharge.tr, lastText: controller.charge,),
              CustomRow(firstText: MyStrings.payable.tr, lastText: controller.payableText,showDivider: showRate,),
              showRate?CustomRow(firstText: MyStrings.conversionRate.tr, lastText: controller.conversionRate,showDivider: showRate,): const SizedBox.shrink(),
              showRate?CustomRow(firstText: 'in ${controller.paymentMethod?.currency}'.tr, lastText: controller.inLocal,showDivider: false,):const SizedBox.shrink()
            ],
          ),
        ),
      ],
    );

  /*  return GetBuilder<AddNewDepositController>(builder: (controller){
      bool showRate = controller.isShowRate();
    return ;
    }
    );*/
  }
}
