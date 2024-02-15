import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:flutter_tiktok_shashwat/features/app/splash_screen/splash_screen.dart';
import 'package:flutter_tiktok_shashwat/features/user_auth/presentation/pages/home_page.dart';
import 'package:flutter_tiktok_shashwat/features/user_auth/presentation/pages/login_page.dart';
import 'package:flutter_tiktok_shashwat/features/user_auth/presentation/pages/sign_up_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyAEhzs4liL0k0_Sawn3DM2JaDUGXYDR_Vs",
        appId: "1:581041793774:web:d95bb71974b88cceff21ff",
        messagingSenderId: "581041793774",
        projectId: "shashwat-flutter",
        // Your web Firebase config options
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase',
      routes: {
        '/': (context) => SplashScreen(
              // Here, you can decide whether to show the LoginPage or HomePage based on user authentication
              child: LoginPage(),
            ),
        '/login': (context) => LoginPage(),
        '/signUp': (context) => SignUpPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
