import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/routes.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/login_success/login_success_screen.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/screens/sign_up/sign_up_screen.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shop_app/theme.dart';
import 'package:firebase_core/firebase_core.dart';

import 'models/Cart.dart';




String userId="";
List<Cart> cartItems = [];


String routeName;

Future<String> getInitialRouteName(String userId) async {
  if (userId == "") {
    return SignInScreen.routeName;
  }

  print("userId");
  String route = await FirebaseFirestore.instance.collection('users').doc(userId).get().then(
          (doc) {
            if (doc.exists) {
              if (doc['state'] == "signUp") {
                return SignUpScreen.routeName;
              }
              else {
                if (doc['state']=="notVerfied"){
                  return HomeScreen.routeName;
                }
                else {
                  return HomeScreen.routeName;
                }
              }
            }
            else {
              return SignInScreen.routeName;
            }
          });

  return route;

}

Future<String> getUserId() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userId = (prefs.getString('userId') ?? "");
  print(userId);
  return userId;
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  userId = await getUserId();//"4lnadHg2Ejstd21XCLOR";
  routeName = await getInitialRouteName(userId);
  print(routeName);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'بضاعتي',
      theme: theme(),
      // home: SplashScreen(),
      // We use routeName so that we dont need to remember the name
      initialRoute: routeName,
    routes: routes,
    );
  }
}
