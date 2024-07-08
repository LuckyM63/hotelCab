import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/helper/date_converter.dart';
import 'package:booking_box/core/helper/string_format_helper.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/data/controller/payment_log/payment_log_controller.dart';
import 'package:booking_box/data/repo/payment_log/payment_log_repo.dart';
import 'package:booking_box/view/components/custom_loader/custom_loader.dart';
import 'package:booking_box/view/components/custom_no_data_screen.dart';
import 'package:booking_box/view/components/divider/custom_divider.dart';
import 'package:booking_box/view/components/marquee_widget/marquee_widget.dart';
import 'package:booking_box/view/screens/payment_log/widget/payment_status_widget.dart';

import '../../../../../data/services/api_service.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/style.dart';
import '../../components/app-bar/custom_appbar.dart';
class PaymentLogScreen extends StatefulWidget implements PreferredSizeWidget {

  final bool isShowAppBar;

  const PaymentLogScreen({super.key,this.isShowAppBar = true});

  @override
  State<PaymentLogScreen> createState() => _PaymentLogScreenState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();

}

class _PaymentLogScreenState extends State<PaymentLogScreen> {

  final ScrollController scrollController = ScrollController();

  fetchData() {
    Get.find<PaymentLogController>().fetchNewBookingData();
  }

  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      if(Get.find<PaymentLogController>().hasNext()){
        fetchData();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if(widget.isShowAppBar){
      init();
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scrollController.addListener(_scrollListener);
    });
  }

  void init(){
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(PaymentLogRepo(apiClient: Get.find()));
    final paymentController = Get.put(PaymentLogController(paymentLogRepo: Get.find()));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      paymentController.loadData();

    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentLogController>(
      builder: (controller) => Scaffold(
        backgroundColor: MyColor.colorWhite,
        appBar: widget.isShowAppBar? CustomAppBar(
          statusBarColor: MyColor.colorWhite,
          bgColor: MyColor.colorWhite,
          title: MyStrings.paymentLog.tr,
        ) : null,
        body: controller.isLoading ? const CustomLoader() :  Container(
          height: double.maxFinite,
          width: double.maxFinite,
          margin: EdgeInsets.only(left: 16,right:16,bottom: 12,top:widget.isShowAppBar?15 : 5),
          child: controller.paymentLogList.isEmpty ? CustomNoDataScreen(
            title: MyStrings.noPaymentFound.tr,
          ) : ListView.builder(
            shrinkWrap: true,
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            itemCount: controller.paymentLogList.length + 1,
            itemBuilder: (context, index) {

              if(controller.paymentLogList.length == index){
                return controller.hasNext() ? SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(
                    child: CustomLoader(isPagination: true),
                  ),
                ) : const SizedBox();
              }

              var paymentLog = controller.paymentLogList[index];

              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.space5)
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.space16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("${MyStrings.trxId.tr}: ",style: boldDefault.copyWith(color: MyColor.naturalDark.withOpacity(.9)),),
                                  Expanded(child: MarqueeWidget(child: Text(paymentLog.trx ?? '',style: boldDefault.copyWith(color: MyColor.titleTextColor.withOpacity(.9)),))),
                                ],
                              ),
                              const SizedBox(height: Dimensions.space10),
                              Row(
                                children: [
                                  Text("${MyStrings.bookingId.tr} ",style: boldDefault.copyWith(color: MyColor.naturalDark.withOpacity(.9)),),
                                  Expanded(child: MarqueeWidget(child: Text(paymentLog.booking?.bookingNumber ?? '',style: mediumDefault.copyWith(color: MyColor.naturalDark.withOpacity(.9)),))),
                                ],
                              ),
                              const SizedBox(height: Dimensions.space4,),
                              Text(DateConverter.formatStringDateTime(paymentLog.updatedAt ?? ''),style: mediumLarge.copyWith(fontSize: 13,color: MyColor.naturalDark),),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('${Converter.formatNumber(paymentLog.amount ?? '')} ${paymentLog.methodCurrency}',style:boldLarge.copyWith(fontSize: 13)),
                              const SizedBox(height: Dimensions.space20,),
                              PaymentStatusWidget(
                                onlyText: true,
                                  fontSize: 12,
                                  status: paymentLog.status == '0' ? MyStrings.initiatePayment.tr :
                                      paymentLog.status == '1' ? MyStrings.successPayment.tr :
                                      paymentLog.status == '2' ? MyStrings.pendingPayment.tr:
                                      paymentLog.status == '3' ? MyStrings.rejectPayment.tr: ''
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const CustomDivider(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}





