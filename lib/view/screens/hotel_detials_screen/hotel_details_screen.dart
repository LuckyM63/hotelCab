import 'dart:async';

import 'package:booking_box/core/route/route.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/core/utils/style.dart';
import 'package:booking_box/view/components/buttons/circular_back_button.dart';
import 'package:booking_box/view/components/buttons/rounded_button.dart';
import 'package:booking_box/view/components/custom_loader/custom_loader.dart';
import 'package:booking_box/view/components/custom_loader/image_loader.dart';
import 'package:booking_box/view/components/divider/custom_divider.dart';
import 'package:booking_box/view/components/divider/horizontal_divider.dart';
import 'package:booking_box/view/components/marquee_widget/marquee_widget.dart';
import 'package:booking_box/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:booking_box/view/screens/hotel_detials_screen/widget/custom_read_more.dart';
import 'package:booking_box/view/screens/hotel_detials_screen/widget/filter_section_details_screen.dart';
import 'package:booking_box/view/screens/hotel_detials_screen/widget/full_view_map.dart';
import 'package:booking_box/view/screens/hotel_detials_screen/widget/hotel_facilities_bottom_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/utils/my_images.dart';
import '../../../core/utils/util.dart';
import '../../../data/controller/hotel_details/hotel_details_screen_controller.dart';
import '../../../data/repo/hotel_details/hotel_details_repo.dart';
import '../../../data/services/api_service.dart';
import '../../components/bottom-sheet/custom_bottom_sheet.dart';

class HotelDetailsScreen extends StatefulWidget {

  final String hotelId;

  const HotelDetailsScreen({Key? key,required this.hotelId}) : super(key: key);

  @override
  State<HotelDetailsScreen> createState() => _HotelDetailsScreenState();
}

class _HotelDetailsScreenState extends State<HotelDetailsScreen> {

  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  final Map<String,Marker> _markers = {};

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(HotelDetailsRepo(apiClient: Get.find()));
    final controller = Get.put(HotelDetailsScreenController(hotelDetailsRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData(widget.hotelId);
    });
  }

  @override
  void dispose() {
    MyUtils.allScreen();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return GetBuilder<HotelDetailsScreenController>(
      builder: (controller) {

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value:  const SystemUiOverlayStyle(
              statusBarColor: MyColor.transparentColor,
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.light
          ),
          child: Scaffold(
            body: controller.isLoading ? const CustomLoader() : Stack(
              children: [
                SingleChildScrollView(
                  child: Stack(
                      children: [
                        SizedBox(
                          height: size.height * .4,
                          child: PageView.builder(
                            controller: controller.pageController,
                            itemCount: controller.hotel?.coverPhotos?.length ?? 1,
                            itemBuilder: (context, index) {
                              return  GestureDetector(
                                onTap: (){
                                  List<String>imageList = [];
                                  controller.hotel?.coverPhotos?.forEach((element) {
                                    imageList.add(element.coverPhotoUrl ?? '');
                                  });

                                  if(imageList.isEmpty)return;

                                  Get.toNamed(RouteHelper.photoViewScreen,arguments: [ imageList,index]);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: MyColor.colorWhite,
                                      borderRadius: BorderRadius.circular(7)
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: controller.hotel?.coverPhotos?[index].coverPhotoUrl.toString() ??  MyImages.defaultImageNetwork,
                                    imageBuilder: (context, imageProvider) => Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(7),
                                          image: DecorationImage(
                                              image: imageProvider, fit: BoxFit.cover),
                                        )
                                    ),
                                    placeholder: (context, url) => const CustomImageLoader(),
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                  ),
                                ),
                              );
                            },
                            onPageChanged: (int page) {
                              controller.setCurrentPage(page);
                            },
                          ),
                        ),
                        SafeArea(
                          child: Container(
                            margin: EdgeInsets.only(top: size.height * .31),
                            padding: const EdgeInsets.all(16),
                            width: double.maxFinite,
                            decoration: const BoxDecoration(
                                color: MyColor.bgColor2,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(controller.hotelSetting?.name.toString().tr ?? '',style: boldOverLarge.copyWith(color: MyColor.titleTextColor),),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                MarqueeWidget(
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(MyImages.location,colorFilter: const ColorFilter.mode(MyColor.primaryColor, BlendMode.srcIn),),
                                      const SizedBox(width: 5,),
                                      Text(controller.hotelSetting?.address.toString().tr ?? '',style: regularDefault.copyWith(color: MyColor.titleTextColor),),
                                      const HorizontalDivider(),
                                      Text("${controller.hotelSetting?.starRating} ${MyStrings.starHotel.tr}",style: regularDefault.copyWith(color: MyColor.titleTextColor),)
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 7,),
                                const CustomDivider(space: 5,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${MyStrings.facilities.tr} ',style: boldLarge.copyWith(color: MyColor.titleTextColor),),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: List.generate(controller.hotelFacilitiesList.length, (index) => Container(
                                                margin: const EdgeInsets.only(right: 8),
                                                padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 6),
                                                decoration: BoxDecoration(
                                                    color: MyColor.primaryColor.withOpacity(.15),
                                                    borderRadius: BorderRadius.circular(50)
                                                ),
                                                child: Row(
                                                  children: [
                                                    CachedNetworkImage(
                                                      height: 10,
                                                      width: 10,
                                                      fit: BoxFit.cover,
                                                      imageUrl: controller.hotelFacilitiesList[index].imageUrl ?? MyImages.defaultImageNetwork,
                                                      color: MyColor.colorBlack,
                                                      placeholder: (context, url) => const CustomImageLoader(loaderSize: 7,),
                                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Text(controller.hotelFacilitiesList[index].name?.tr ?? '',style: boldSmall.copyWith(color: MyColor.colorBlack),),
                                                  ],
                                                ),
                                              )),
                                            ),
                                          ),
                                        ),

                                        GestureDetector(
                                          onTap: () {
                                            CustomBottomSheet(
                                              child: GetBuilder<HotelDetailsScreenController>(
                                                builder: (controller) => const Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    // BottomSheetHeaderRow(bottomSpace: 0,),
                                                    HotelFacilitiesBottomSheet()
                                                  ],
                                                ),
                                              ),
                                            ).customBottomSheet(context);
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(8),
                                            decoration:  const BoxDecoration(
                                              color: MyColor.bgColor2,
                                            ),
                                            child: Column(
                                              children: [
                                                Text('+${controller.hotelAmenitiesList.length}',style: boldSmall.copyWith(color: MyColor.primaryColor)),
                                                Text(MyStrings.more.tr,style: boldSmall.copyWith(color: MyColor.primaryColor)),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),

                                FilterSectionDetailsScreen(hotelId: widget.hotelId,controller: controller),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(MyStrings.description.tr,style: boldLarge.copyWith(color: MyColor.titleTextColor),),
                                    const SizedBox(height: 5,),
                                    CustomReadMoreText(
                                      '${controller.hotelSetting?.description ?? ''} ',
                                      trimLines: 4,
                                      colorClickableText: MyColor.primaryColor,
                                      trimMode: TrimMode.Line,
                                      trimCollapsedText: MyStrings.seeMore.tr,
                                      trimExpandedText: MyStrings.seeLess.tr,
                                      moreStyle:regularLarge.copyWith(color: MyColor.primaryColor,fontWeight: FontWeight.w600),
                                      lessStyle: regularLarge.copyWith(color: MyColor.primaryColor,fontWeight: FontWeight.w600),
                                      style: regularLarge.copyWith(color: MyColor.bodyTextColor2),
                                    ),
                                    const CustomDivider(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(MyStrings.whereYouWillBe.tr,style: boldLarge.copyWith(color: MyColor.titleTextColor),),
                                        GestureDetector(
                                            onTap: () {
                                              Get.to(FullViewMap(lat: double.parse(controller.hotelSetting?.latitude??'30.24547964829555'), long: double.parse(controller.hotelSetting?.longitude??'69.39220622056193'),));
                                            },
                                            child: Text(MyStrings.fullView.tr,style: mediumDefault.copyWith(color: MyColor.bodyTextColor),)),
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                    Container(
                                      width: double.maxFinite,
                                      height: size.height * .19,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30)
                                      ),
                                      child: GoogleMap(
                                          zoomControlsEnabled: true,
                                          zoomGesturesEnabled: true,
                                          initialCameraPosition: CameraPosition(
                                              target: LatLng(
                                                double.parse(controller.hotelSetting?.latitude??MyStrings.defaultLat),
                                                double.parse(controller.hotelSetting?.longitude??MyStrings.defaultLong),),
                                              zoom: 14.4746
                                          ),
                                          markers: _markers.values.toSet(),
                                          onMapCreated: (GoogleMapController mapController) {
                                            _controller.complete(mapController);
                                            addMarker(
                                                MyStrings.hotel,
                                                LatLng(
                                                  double.parse(controller.hotelSetting?.latitude??MyStrings.defaultLat),
                                                  double.parse(controller.hotelSetting?.longitude??MyStrings.defaultLong),
                                                ),
                                                MyStrings.hotel
                                            );
                                          }
                                      ),
                                    ),
                                    SizedBox(height: size.height * .02)
                                  ],
                                ),
                                SizedBox(height: size.height * .06,)
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: controller.modifiedFromDetails == true && controller.isLoading  == true? const CustomLoader(loaderColor: Colors.red,) : const SizedBox.shrink(),
                        ),
                        Positioned(
                          left: 30,
                          top: size.height * .32,
                          child: Center(
                            child: Row(
                                children: List.generate(controller.hotel?.coverPhotos?.length??0, (index) => Container(
                                  width: 7,
                                  height: 7,
                                  margin: const EdgeInsets.only(right: 6),
                                  decoration: BoxDecoration(
                                      color: controller.hotel!.coverPhotos!.length < 2 ? MyColor.transparentColor : controller.currentPage == index ? MyColor.primaryColor : MyColor.colorWhite.withOpacity(.8),
                                      shape: BoxShape.circle
                                  ),
                                ))
                            ),
                          ),
                        )
                      ]
                  ),
                ),
                Positioned(
                    top: 30,
                    left: MyUtils.isRtl(context) ? null : 10,
                    right: MyUtils.isRtl(context) ? 10 : null,
                    child: const CircularBackButton()
                ),
              ],
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: controller.isLoading ? const SizedBox.shrink() : Container(

              margin: const EdgeInsets.only(bottom: 15),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: RoundedButton(
                  verticalPadding: size.height * .021,
                  text: MyStrings.chooseRoom.tr,
                  color: controller.isRoomAvailable ? MyColor.primaryColor : MyColor.primaryColor.withOpacity(.5),
                  textColor: controller.isRoomAvailable ? MyColor.colorWhite : MyColor.colorWhite.withOpacity(.7),
                  press: (){
                    if(controller.homeController.checkOutDate == MyStrings.checkOutDate){
                      CustomSnackBar.error(errorList: [MyStrings.selectCheckOut.tr]);
                    }
                    else if(controller.isRoomAvailable){
                      Get.toNamed(RouteHelper.selectRoomScreen);
                    }else{
                      CustomSnackBar.error(errorList: [MyStrings.roomNotAvailable.tr]);
                    }
                  }
              ),
            ),
          ),
        );
      },
    );
  }


  addMarker(String id,LatLng location,String title) async{

    var marker = Marker(
      markerId: MarkerId(id),
      position: location,
      infoWindow: InfoWindow(title: title),
      icon: BitmapDescriptor.defaultMarker,
    );
    _markers[id] = marker;
    setState(() {});
  }
}