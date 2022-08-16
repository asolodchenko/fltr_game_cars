import 'package:flame/flame.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game/screens/main_menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Set the game full
  Flame.device.fullScreen();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const MainMenu(),
    );
  }
}
