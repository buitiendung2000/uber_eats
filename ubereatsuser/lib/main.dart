import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:ubereatsuser/controller/services/APIsNKeys/keys.dart';
import 'controller/provider/authProvider/mobileAuthProvider.dart';
import 'controller/provider/itemOrderProvider/itemOrderProvider.dart';
import 'controller/provider/profileProvider/profileProvider.dart';
import 'controller/provider/resturantProvider/resturantProvider.dart';
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
          ChangeNotifierProvider<ProfileProvider>(
            create: (_) => ProfileProvider(),
          ),
          ChangeNotifierProvider<ItemOrderProvider>(
            create: (_) => ItemOrderProvider(),
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