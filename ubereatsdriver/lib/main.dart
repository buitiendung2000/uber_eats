import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:ubereatsdriver/controller/provider/authProvider/mobileAuthProvider.dart';
import 'package:ubereatsdriver/controller/provider/orderProvider/orderProvider.dart';
import 'package:ubereatsdriver/controller/provider/profileProvider/profileProvider.dart';
import 'package:ubereatsdriver/controller/provider/rideProvider/rideProvider.dart';
import 'package:ubereatsdriver/firebase_options.dart';

import 'controller/services/APIsNKeys/credential.dart';
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
          ChangeNotifierProvider<ProfileProvider>(
            create: (_) => ProfileProvider(),
          ),
          ChangeNotifierProvider<RideProvider>(
            create: (_) => RideProvider(),
          ),
          ChangeNotifierProvider<OrderProvider>(
            create: (_) => OrderProvider(),
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