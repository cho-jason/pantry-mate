import 'package:flutter/material.dart';
import 'package:pantry_mate/ui/theme.dart';
import 'package:pantry_mate/ui/screens/login.dart';
import 'package:pantry_mate/ui/screens/home.dart';
import 'package:pantry_mate/ui/screens/ingredient.dart';

class PantryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ingredient List',
      theme: buildTheme(),
      initialRoute: '/',
      routes: {
        // If you're using navigation routes, Flutter needs a base route.
        // We're going to change this route once we're ready with
        // implementation of HomeScreen.
        '/': (context) => HomeScreen(),
        '/ingredient': (context) => IngredientScreen(),
        '/login': (context) => LoginScreen(),
      },
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     onGenerateRoute: (settings) {
  //       if (settings.name == )
  //     },
  //   )
  // }
}
