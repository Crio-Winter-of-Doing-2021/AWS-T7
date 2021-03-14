import 'package:flutter/material.dart';
import 'package:frontend/config/locator.dart';
import 'package:frontend/style/app_theme.dart';
import 'package:frontend/utils/preference.dart';
import 'package:frontend/view/home_page.dart';

void main() async{
  await Preference.load();
  setupLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: AppTheme.primaryColor,
        accentColor: AppTheme.accentColor,
      ),
      home: HomePage(),
    );
  }
}
