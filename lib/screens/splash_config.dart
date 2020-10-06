

import 'package:flutter/material.dart';
import 'package:trabalho_sistemas/componentes/main_screen.dart';
import 'package:trabalho_sistemas/screens/splash_screen.dart';

class SplashConfig extends StatefulWidget {
  @override
  _SplashConfigState createState() => _SplashConfigState();
}

class _SplashConfigState extends State<SplashConfig> {
  bool needUpdate = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 1)),
      builder: (context, snapshot) {
        switch(snapshot.connectionState){

          case ConnectionState.none:
            // TODO: Handle this case.
            break;
          case ConnectionState.waiting:
            return SplashScreen();
            break;
          case ConnectionState.active:
            // TODO: Handle this case.
            break;
          case ConnectionState.done:
            return BottomNavBar();
            break;
        }
        return null;
      },

    );
  }

}
