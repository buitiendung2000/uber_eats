import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../../constant/constants.dart';
import '../../../model/restaurantModel.dart';
import '../../../view/signInLogicScreen/signInLogicScreen.dart';

class ResturantCRUDServices {
  static registerResturant(RestaurantModel data, BuildContext context) async {
    try {
      await firestore
          .collection('Resturant')
          .doc(auth.currentUser!.uid)
          .set(data.toMap())
          .whenComplete(() {
        Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                child: const SignInLogicScreen(),
                type: PageTransitionType.rightToLeft),
            (route) => false);
      });
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  static fetchResturantData() async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection('Resturant')
          .doc(auth.currentUser!.uid)
          .get();

      RestaurantModel data = RestaurantModel.fromMap(snapshot.data()!);
      return data;
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}