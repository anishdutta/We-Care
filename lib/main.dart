import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:we_care/screens/dashboard.dart';
import 'package:we_care/screens/login_screen.dart';
import 'package:we_care/screens/signup_screen.dart';
import 'package:we_care/screens/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute:'/splash',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/splash':
              return PageTransition(
                child: SplashScreen(),
                type: PageTransitionType.leftToRight,
                settings: settings,
              );
              break;
            case '/login_screen':
              return PageTransition(
                child: LoginScreen(),
                type: PageTransitionType.leftToRight,
                settings: settings,
              );
              break;
            case '/signup_screen':
              return PageTransition(
                child: SignupScreen(),
                type: PageTransitionType.leftToRight,
                settings: settings,
              );
              break;
            case '/dashboard':
              return PageTransition(
                child:  Dashboard(),
                type: PageTransitionType.leftToRight,
                settings: settings,
              );
              break;
            default:
              return null;
          }
        });
  }
}

