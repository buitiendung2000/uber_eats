import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../../constant/constants.dart';
import '../../../model/deliveryPartnerModel/driverModel.dart';
import '../../../model/foodOrderModel/foodOrderModel.dart';
import '../APIsNKeys/APIs.dart';
import '../APIsNKeys/keys.dart';
import 'package:http/http.dart' as http;

class PushNotificationServices {
  static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  static Future initializeFirebaseMessaging() async {
    await firebaseMessaging.requestPermission();
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen(firebaseMessagingForegroundHandler);
  }

  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    log(message.toMap().toString());
  }

  static Future<void> firebaseMessagingForegroundHandler(
      RemoteMessage message) async {
    log(message.toMap().toString());
  }

  static Future getToken() async {
    String? token = await firebaseMessaging.getToken();
    log('FCM token : \n$token');
    await firestore
        .collection('Resturant')
        .doc(auth.currentUser!.uid)
        .update({'cloudMessagingToken': token});
  }

  static subscribeToNotification() {
    firebaseMessaging.subscribeToTopic('RESTURANT_PARTNER');
  }

  static initializeFCM() {
    initializeFirebaseMessaging();
    getToken();
    subscribeToNotification();
  }

  static sendPushNotificationToUserAfterFoodOutForDelivery(
      String fcmToken, String foodName) async {
    try {
      final api = Uri.parse(APIs.pushNotificationAPI());
      var body = jsonEncode(
{
        "message":{
          "token":fcmToken ,
          "notification":
          {
            "title":"New Order for $foodName is out for delivery",
            "body":"Out for Delivery"
          },
          "data":{
            "foodName":foodName
          }
          // "data":
          // {
          //   "foodName":{"Noodles"}
          // }
        }
      }
      );
      var headers = {
      "Content-Type":"application/json",
      "Authorization":"Bearer $fcmToken"
    };
      var response =
          await http.post(api, headers: headers, body: body).then((value) {
        log('Successfully Send the Push Notification');
      }).timeout(const Duration(seconds: 60), onTimeout: () {
        log('Connection Timed out');
        throw TimeoutException('Connection Timed out');
      }).onError((error, stackTrace) {
        log(error.toString());
        throw Exception(error);
      });
    } catch (error) {
      log(error.toString());
      throw Exception(error);
    }
  }

  static sendPushNotificationToNearbyDeliveryPartners(
      DeliveryPartnerModel deliveryPartner,
      FoodOrderModel foodOrderData) async {
    try {
      final api = Uri.parse(APIs.pushNotificationAPI());
      var body = jsonEncode(
         {
        "message":{
          "token":deliveryPartner.cloudMessagingToken,
          "notification":
          {
            "title":"New Delivery Requests",
            "body":"Delivery Requests"
          },
          "data":
          {
            "data":{foodOrderData.orderID}
          }
        }
      }     
      );
     var headers = {
      "Content-Type":"application/json",
      "Authorization":"Bearer $fcmServerKey"
    };
      var response =
          await http.post(api, headers: headers, body: body).then((value) {
        log(value.statusCode.toString());
        log(value.body.toString());
        log('Successfully Send the Push Notification');
      }).timeout(const Duration(seconds: 60), onTimeout: () {
        log('Connection Timed out');
        throw TimeoutException('Connection Timed out');
      }).onError((error, stackTrace) {
        log(error.toString());
        throw Exception(error);
      });
    } catch (error) {
      log(error.toString());
      throw Exception(error);
    }
  }
}