import 'dart:io';
import 'package:flutter/material.dart';
import '../../../model/restaurantModel.dart';
import '../../services/imagesServices/imagesServices.dart';
import '../../services/resturantCRUDServices/resturantCRUDServices.dart';

class ResturantProvider extends ChangeNotifier {
  List<File> resturantBannerImages = [];
  List<String> resturantBannerImagesURL = [];
  RestaurantModel? resturantData;

  getResturatantBannerImages(BuildContext context) async {
    resturantBannerImages = await ImageServices.getImagesFromGallery(
      context: context,
    );
    notifyListeners();
  }

  updateResturantBannerImagesURL(BuildContext context) async {
    resturantBannerImagesURL =
        await ImageServices.uploadImagesToFirebaseStorageNGetURL(
      images: resturantBannerImages,
      context: context,
    );
    notifyListeners();
  }

  getResturantData() async {
    resturantData = await ResturantCRUDServices.fetchResturantData();
    notifyListeners();
  }
}