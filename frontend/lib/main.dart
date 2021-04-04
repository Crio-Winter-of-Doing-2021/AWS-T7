import 'package:flutter/material.dart';
import 'package:frontend/config/locator.dart';
import 'package:frontend/provider/task_provider.dart';
import 'package:frontend/style/app_theme.dart';
import 'package:frontend/utils/preference.dart';
import 'package:frontend/view/home_page.dart';
import 'package:provider/provider.dart';

void main() async {
  await Preference.load();
  setupLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => TaskProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: AppTheme.primaryColor,
          accentColor: AppTheme.accentColor,
          backgroundColor: AppTheme.scaffoldBackgroundColor,
        ),
        home: Center(child: HomePage()),
      ),
    );
  }
}
