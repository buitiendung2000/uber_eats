// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../../constant/constant.dart';
import '../../../model/userAddressModel.dart';
import '../../../model/userModel.dart';
import '../../../view/signInLogicScreen/signInLogicScreen.dart';
import '../../../widgets/toastServices.dart';
import '../../provider/profileProvider/profileProvider.dart';

class UserDataCRUDServices {
  static registerUser(UserModel data, BuildContext context) async {
    try {
      await firestore
          .collection('User')
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

  static addAddress(UserAddressModel data, BuildContext context) async {
    try {
      await firestore
          .collection('Address')
          .doc(data.addressID)
          .set(data.toMap())
          .whenComplete(() {
        ToastService.sendScaffoldAlert(
          msg: 'Thêm địa chỉ thành công',
          toastStatus: 'SUCCESS',
          context: context,
        );
      });
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
  
  static editAddress(UserAddressModel data, BuildContext context) async {
    List<UserAddressModel> addresses =
        context.read<ProfileProvider>().addresses;
    for (var addressData in addresses) {
      if (addressData.addressID != data.addressID) {
        await firestore
            .collection('Address')
            .doc(addressData.addressID)
            .update(data.toMap());
      }
    }
    
  }


    static deleteAddress(UserAddressModel data, BuildContext context) async {
    try {
      await firestore
          .collection('Address')
          .doc(data.addressID)
          .delete()
          .whenComplete(() {
        ToastService.sendScaffoldAlert(
          msg: 'Xóa địa chỉ thành công',
          toastStatus: 'SUCCESS',
          context: context,
        );
      });
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  static fetchUserData() async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await firestore.collection('User').doc(auth.currentUser!.uid).get();

      UserModel data = UserModel.fromMap(snapshot.data()!);
      return data;
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  static fetchAddresses() async {
    List<UserAddressModel> addresses = [];
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection('Address')
          .where('userID', isEqualTo: auth.currentUser!.uid)
          .get();
      snapshot.docs.forEach((element) {
        addresses.add(UserAddressModel.fromMap(element.data()));
      });
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
    return addresses;
  }

  static fetchActiveAddress() async {
    List<UserAddressModel> addresses = [];
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection('Address')
          .where('userID', isEqualTo: auth.currentUser!.uid)
          .where('isActive', isEqualTo: true)
          .get();
      snapshot.docs.forEach((element) {
        addresses.add(UserAddressModel.fromMap(element.data()));
      });
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
    return addresses[0];
  }

  static setAddressAsActive(UserAddressModel data, BuildContext context) async {
    List<UserAddressModel> addresses =
        context.read<ProfileProvider>().addresses;

    for (var addressData in addresses) {
      if (addressData.addressID != data.addressID) {
        await firestore
            .collection('Address')
            .doc(addressData.addressID)
            .update({'isActive': false});
      }
    }
    await firestore
        .collection('Address')
        .doc(data.addressID)
        .update({'isActive': true});
  }
}