// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:ubereatsuser/controller/services/imagesServices/imageServices.dart';
import '../../constant/constant.dart';
import '../../controller/provider/profileProvider/profileProvider.dart';
import '../../controller/services/locationServices/locationServices.dart';
import '../../controller/services/userDataCRUDServices/userDataCRUDServices.dart';
import '../../model/userAddressModel.dart';
import '../../model/userModel.dart';
import '../../utils/colors.dart';
import '../../utils/textStyles.dart';
import '../../widgets/commonElevetedButton.dart';
import '../../widgets/commonTextField.dart';

class UserRegistraionScreen extends StatefulWidget {
  const UserRegistraionScreen({super.key});

  @override
  State<UserRegistraionScreen> createState() => _UserRegistraionScreenState();
}

class _UserRegistraionScreenState extends State<UserRegistraionScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController houseNoController = TextEditingController();
  TextEditingController apartmentController = TextEditingController();
  TextEditingController savaeAddressAsController = TextEditingController();
  CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(37.4, -122),
    zoom: 14,
  );
  Completer<GoogleMapController> googleMapController = Completer();
  GoogleMapController? mapController;
  bool registerButoonPressed = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: Text(
          'Đăng ký',
          style: AppTextStyles.body16Bold,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 3.w,
          vertical: 2.h,
        ),
        children: [
          SizedBox(
            height: 2.h,
          ),
          Consumer<ProfileProvider>(builder: (context, profileProvider, child) {
            return InkWell(
              onTap: () async {
                await context
                    .read<ProfileProvider>()
                    .pickFoodImageFromGallery(context);
              },
              child: CircleAvatar(
                radius: 5.h,
                backgroundColor: black,
                child: CircleAvatar(
                    backgroundColor: white,
                    radius: 5.h - 2,
                    backgroundImage: profileProvider.profileImage != null
                        ? FileImage(profileProvider.profileImage!)
                        : null,
                    child: profileProvider.profileImage == null
                        ? FaIcon(
                            FontAwesomeIcons.user,
                            size: 4.h,
                            color: black,
                          )
                        : null),
              ),
            );
          }),
          SizedBox(
            height: 4.h,
          ),
          CommonTextfield(
            controller: nameController,
            title: 'Tên',
            hintText: 'Họ tên',
            keyboardType: TextInputType.name,
          ),
          SizedBox(
            height: 4.h,
          ),
          Text(
            'Địa chỉ',
            style: AppTextStyles.heading22Bold,
          ),
          SizedBox(
            height: 2.h,
          ),
          SizedBox(
            height: 40.h,
            width: 100.w,
            child: GoogleMap(
              initialCameraPosition: initialCameraPosition,
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              onMapCreated: (GoogleMapController controller) async {
                googleMapController.complete(controller);
                mapController = controller;
                Position crrPositon =
                    await LocationServices.getCurretnLocation();
                LatLng crrLatLng = LatLng(
                  crrPositon.latitude,
                  crrPositon.longitude,
                );
                CameraPosition cameraPosition = CameraPosition(
                  target: crrLatLng,
                  zoom: 14,
                );
                mapController!.animateCamera(
                    CameraUpdate.newCameraPosition(cameraPosition));
              },
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          CommonTextfield(
            controller: houseNoController,
            title: 'Số nhà',
            hintText: '123aA',
            keyboardType: TextInputType.name,
          ),
          SizedBox(
            height: 2.h,
          ),
          CommonTextfield(
            controller: apartmentController,
            title: 'Căn hộ',
            hintText: 'Căn hộ/ Đường',
            keyboardType: TextInputType.name,
          ),
          SizedBox(
            height: 2.h,
          ),
          CommonTextfield(
            controller: savaeAddressAsController,
            title: 'Lưu địa chỉ',
            hintText: 'Công ty/ Nhà riêng / Nhà gia đình',
            keyboardType: TextInputType.name,
          ),
          SizedBox(
            height: 4.h,
          ),
          CommonElevatedButton(
              onPressed: () async {
                setState(() {
                  registerButoonPressed = true;
                });
                List<String> urls =
                    await ImageServices.uploadImagesToFirebaseStorageNGetURL(
                  images: [context.read<ProfileProvider>().profileImage!],
                  context: context,
                );

                UserModel userData = UserModel(
                  name: nameController.text.trim(),
                  profilePicURL: urls[0],
                  userID: auth.currentUser!.uid,
                );
                Position location = await LocationServices.getCurretnLocation();
                String addressID = uuid.v1().toString();
                UserAddressModel addressData = UserAddressModel(
                  addressID: addressID,
                  userID: auth.currentUser!.uid,
                  latitude: location.latitude,
                  longitude: location.longitude,
                  roomNo: houseNoController.text.trim(),
                  apartment: apartmentController.text.trim(),
                  addressTitle: savaeAddressAsController.text.trim(),
                  uploadTime: DateTime.now(),
                  isActive: true,
                );
                await UserDataCRUDServices.addAddress(addressData, context);
                UserDataCRUDServices.registerUser(
                  userData,
                  context,
                );
              },
              color: black,
              child: registerButoonPressed
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