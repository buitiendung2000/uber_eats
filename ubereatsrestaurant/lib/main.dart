import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:ubereatsrestaurant/controller/services/APIsNKeys/keys.dart';
import 'controller/provider/FoodProvider/FoodProvider.dart';
import 'controller/provider/authProvider/mobileAuthProvider.dart';
import 'controller/provider/deliveryPartnerProvider/deliveryPartnerProvider.dart';
import 'controller/provider/resturantRegisterProvider/resturantRegisterProvider.dart';
import 'firebase_options.dart';
import 'view/signInLogicScreen/signInLogicScreen.dart';

Future main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Gemini.init(apiKey: GEMINI_API_KEY);
  runApp(const UberEats());
}

class UberEats extends StatelessWidget {
  const UberEats({super.key});
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, _, __) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<MobileAuthProvider>(
            create: (_) => MobileAuthProvider(),
          ),
          ChangeNotifierProvider<ResturantProvider>(
            create: (_) => ResturantProvider(),
          ),
          ChangeNotifierProvider<FoodProvider>(
            create: (_) => FoodProvider(),
          ),
          ChangeNotifierProvider<DeliveryPartnerProvider>(
            create: (_) => DeliveryPartnerProvider(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(),
          home: const SignInLogicScreen(),
        ),
      );
    });
  }
}