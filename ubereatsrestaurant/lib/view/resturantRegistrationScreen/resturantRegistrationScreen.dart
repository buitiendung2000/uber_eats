// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../constant/constants.dart';
import '../../controller/provider/resturantRegisterProvider/resturantRegisterProvider.dart';
import '../../controller/services/locationServices/locationServices.dart';
import '../../controller/services/resturantCRUDServices/resturantCRUDServices.dart';
import '../../model/address.dart';
import '../../model/restaurantModel.dart';
import '../../utils/colors.dart';
import '../../utils/testStyles.dart';
import '../../widgets/widget/commonTextField.dart';

class ResturantRegistrationScreen extends StatefulWidget {
  const ResturantRegistrationScreen({super.key});

  @override
  State<ResturantRegistrationScreen> createState() =>
      _ResturantRegistrationScreenState();
}

class _ResturantRegistrationScreenState
    extends State<ResturantRegistrationScreen> {
  TextEditingController resturantNameController = TextEditingController();
  TextEditingController resturantLicenceNumberController =
      TextEditingController();
  CarouselController controller = CarouselController();
  TextEditingController searchResturantController = TextEditingController();
  bool pressedResturantRegistrationButton = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
        children: [
          SizedBox(
            height: 2.h,
          ),
          Consumer<ResturantProvider>(
              builder: (context, registrationProvider, child) {
            if (registrationProvider.resturantBannerImages.isEmpty) {
              return InkWell(
                onTap: () async {
                  await registrationProvider
                      .getResturatantBannerImages(context);
                },
                child: Container(
                  height: 20.h,
                  width: 94.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.sp),
                    color: greyShade3,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 5.h,
                        width: 5.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: black,
                          ),
                        ),
                        child: FaIcon(
                          FontAwesomeIcons.plus,
                          size: 3.h,
                          color: black,
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        'Thêm',
                        style: AppTextStyles.body14,
                      )
                    ],
                  ),
                ),
              );
            } else {
              List<File> bannerImages =
                  registrationProvider.resturantBannerImages;
              return Container(
                height: 23.h,
                width: 94.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      5.sp,
                    ),
                    border: Border.all(color: greyShade3)),
                child: CarouselSlider(
                  carouselController: controller,
                  options: CarouselOptions(
                    height: 23.h,
                    autoPlay: true,
                    viewportFraction: 1,
                  ),
                  items: bannerImages
                      .map(
                        (image) => Container(
                          width: 94.w,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(image),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              );
            }
          }),
          SizedBox(
            height: 4.h,
          ),
          CommonTextfield(
            controller: resturantNameController,
            title: 'Tên Nhà hàng',
            hintText: 'Nhập tên Nhà hàng của bạn',
            keyboardType: TextInputType.name,
          ),
          SizedBox(
            height: 2.h,
          ),
          CommonTextfield(
            controller: resturantLicenceNumberController,
            title: 'Số đăng ký',
            hintText: 'Nhập số đăng ký nhà hàng của bạn',
            keyboardType: TextInputType.name,
          ),
          SizedBox(
            height: 2.h,
          ),
          SizedBox(
            height: 30.h,
          ),
          ElevatedButton(
              onPressed: () async {
                setState(() {
                  pressedResturantRegistrationButton = true;
                });
                await context
                    .read<ResturantProvider>()
                    .updateResturantBannerImagesURL(context);
                Position currentAddress =
                    await LocationServices.getCurretnLocation();
                LocationServices.registerResturantLocationInGeofire();
                RestaurantModel data = RestaurantModel(
                  restaurantName: resturantNameController.text.trim(),
                  restaurantLicenseNumber:
                      resturantLicenceNumberController.text.trim(),
                  restaurantUID: auth.currentUser!.uid,
                  bannerImages: context
                      .read<ResturantProvider>()
                      .resturantBannerImagesURL,
                  address: AddressModel(
                      latitude: currentAddress.latitude,
                      longitude: currentAddress.longitude),
                );
                ResturantCRUDServices.registerResturant(data, context);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: black, minimumSize: Size(90.w, 6.h)),
              child: pressedResturantRegistrationButton
                  ? CircularProgressIndicator(
                      color: white,
                    )
                  : Text(
                      'Đăng ký',
                      style: AppTextStyles.body16Bold.copyWith(color: white),
                    ))
        ],
      ),
    ));
  }
}