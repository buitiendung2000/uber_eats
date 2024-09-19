
import 'package:flutter/widgets.dart';
import '../../../model/deliveryPartnerModel/deliveryPartnerLocationModel.dart';
import '../../../model/deliveryPartnerModel/driverModel.dart';
import '../../../model/foodOrderModel/foodOrderModel.dart';
import '../../services/deliveryPartnerServices/deliveryPartnerServices.dart';
import '../../services/pushNotificationServices/pushNotificationServices.dart';

class DeliveryPartnerProvider extends ChangeNotifier {
  List<DeliveryPartnerLocationModel> deliveryPartnerLocations = [];

  addDeliveryPartner(DeliveryPartnerLocationModel data) {
    deliveryPartnerLocations.add(data);
    notifyListeners();
  }

  removeDeliveryPartner(String deliveryPartnerID) {
    int index = deliveryPartnerLocations
        .indexWhere((element) => element.id == deliveryPartnerID);
    deliveryPartnerLocations.removeAt(index);
    notifyListeners();
  }

  sendDeliveryRequestToNearbyDeliveryPartner(FoodOrderModel foodData) async {
    for (var deliveryPartnerLocationData in deliveryPartnerLocations) {
      DeliveryPartnerModel deliveryPartnerData =
          await DeliveryPartnerServices.getDeliveryPartnerProfileData(
              deliveryPartnerLocationData.id);
      PushNotificationServices.sendPushNotificationToNearbyDeliveryPartners(
        deliveryPartnerData,foodData
      );
    }
  }
}
