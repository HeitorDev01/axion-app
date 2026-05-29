import 'package:app_axion/firebase_options.dart';
import 'package:app_axion/presentation/injection_container.dart';
import 'package:app_axion/presentation/pages/MapsDetailsPage.dart';
import 'package:app_axion/presentation/pages/car_details_page.dart';
import 'package:app_axion/presentation/pages/car_list_screen.dart';
import 'package:app_axion/presentation/pages/onbording_page.dart';
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
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:OnbordingPage(),
    );
  }
}
