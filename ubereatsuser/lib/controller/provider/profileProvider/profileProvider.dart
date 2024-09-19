import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import '../../../model/userAddressModel.dart';
import '../../../model/userModel.dart';
import '../../services/imagesServices/imageServices.dart';
import '../../services/userDataCRUDServices/userDataCRUDServices.dart';

class ProfileProvider extends ChangeNotifier {
  File? profileImage;
  String? profileImageURL;
  UserModel? userData;
  List<UserAddressModel> addresses = [];
  UserAddressModel? activeAddress;

  pickFoodImageFromGallery(BuildContext context) async {
    profileImage = await ImageServices.pickSingleImage(context: context);
    notifyListeners();
  }

  uploadImageAndGetImageURL(BuildContext context) async {
    List<String> url = await ImageServices.uploadImagesToFirebaseStorageNGetURL(
      images: [profileImage!],
      context: context,
    );
    if (url.isNotEmpty) {
      profileImageURL = url[0];
      log(profileImageURL!);
    }
    notifyListeners();
  }

  fetchUserData() async {
    userData = await UserDataCRUDServices.fetchUserData();

    notifyListeners();
    log(userData!.toMap().toString());
  }

  fetchUserAddresses() async {
    addresses = await UserDataCRUDServices.fetchAddresses();
    for (var address in addresses) {
      if (address.isActive) {
        activeAddress = address;
      }
    }

    notifyListeners();
    log(activeAddress!.toMap().toString());
  }
}