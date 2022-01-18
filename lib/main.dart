import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:ginstagram_flutter/utils/colors.dart';

import 'package:ginstagram_flutter/responsive/mobile_screen_layout.dart';
import 'package:ginstagram_flutter/responsive/responsive_layout_screen.dart';
import 'package:ginstagram_flutter/responsive/web_screen_layout.dart';

void main() async {
  await dotenv.load();

  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: dotenv.get('API_KEY', fallback: 'API_KEY not found'),
        appId: dotenv.get('APP_ID', fallback: 'APP_ID not found'), 
        messagingSenderId: dotenv.get('MESSAGING_SENDER_ID', fallback: 'MESSAGING_SENDER_ID not found'), 
        projectId: dotenv.get('PROJECT_ID', fallback: 'PROJECT_ID not found'),
        storageBucket: dotenv.get('STORAGE_BUCKET', fallback: 'STORAGE_BUCKET not found')
      )
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ginstagram Demo',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor
      ),
      home: const ResponsiveLayout(
        webScreenLayout: WebScreenLayout(), 
        mobileScreenLayout: MobileScreenLayout()
      )
    );
  }
}


