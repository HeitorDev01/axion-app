import 'package:app_axion/firebase_options.dart';
import 'package:app_axion/presentation/injection_container.dart';
import 'package:app_axion/presentation/pages/onbording_page.dart';
import 'package:app_axion/presentation/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Axion',
      debugShowCheckedModeBanner: false,
      theme: buildAxionTheme(),
      home:OnbordingPage(),
    );
  }
}
