import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'pages/home/Homescreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  runApp(const MyApp());
}

@NowaGenerated()
class MyApp extends StatelessWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FarMan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6750A4),
          primary: const Color(0xFF2196F3),
          secondary: const Color(0xFFE1CEFF),
          brightness: Brightness.light,
          onSecondary: const Color(0xFF000000),
        ),
        buttonTheme: const ButtonThemeData(alignedDropdown: false),
        iconButtonTheme: const IconButtonThemeData(style: ButtonStyle()),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            foregroundColor: Theme.of(context).colorScheme.secondary),
      ),
      home: const MyHomeScreen(
        role: 1,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
