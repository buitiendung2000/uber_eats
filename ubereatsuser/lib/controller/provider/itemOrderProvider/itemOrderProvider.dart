import 'package:flutter/foundation.dart';
import 'package:ubereatsuser/controller/services/foodOrderServices/foodOrderServices.dart';
import 'package:ubereatsuser/model/foodModel.dart';

class ItemOrderProvider extends ChangeNotifier {
  List<FoodModel> cartItems = [];

  fetchCartItems() async {
    cartItems = await FoodOrderServices.fetchCartData();
    notifyListeners();
  }
}