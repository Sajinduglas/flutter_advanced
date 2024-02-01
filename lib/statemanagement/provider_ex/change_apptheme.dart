import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/theme_controller.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => ThemeProvider(),child:MyApp1()));
}

class MyApp1  extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: Provider.of<ThemeProvider>(context).isDarkTheme
            ? ThemeData.dark()
            : ThemeData.light(),
        home: App_theme_changer()
    );
  }
}

class App_theme_changer extends StatelessWidget {
  const App_theme_changer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ElevatedButton(
                onPressed: () {
                  Provider.of<ThemeProvider>(context, listen: false).SwitchTheme();
                },
                child: Text("Switch theme")),
            ),
        );
    }
}
