import 'package:flutter/material.dart';
import 'services/hive_setup.dart';
import 'weather_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupHive();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: const WeatherScreen(),
    );
  }
}



