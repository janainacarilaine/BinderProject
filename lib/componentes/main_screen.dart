import 'dart:convert';
import 'dart:io';


import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trabalho_sistemas/screens/calendar.dart';
import 'package:trabalho_sistemas/screens/lista_materias.dart';
import 'package:trabalho_sistemas/util/colors_util.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
  static int pos = 0;
  int positionSelector;


  BottomNavBar({this.positionSelector});
}

class _BottomNavBarState extends State<BottomNavBar> {




  @override
  void initState() {
    super.initState();
    if(widget.positionSelector != null){
      setState(() {
      BottomNavBar.pos = widget.positionSelector;
      });
    }
  }


  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: context,
      builder: (BuildContext context) => new CupertinoAlertDialog(
        title: new Text(title),
        content: new Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: new Text('Ok'),
//            onPressed: () async {
//              Navigator.of(context, rootNavigator: true).pop();
//              await Navigator.push(
//                context,
//                new MaterialPageRoute(
//                  builder: (context) => new SecondScreen(payload),
//                ),
//              );
//            },
          )
        ],
      ),
    );
  }



  List<TabItem> tabItems = List.of([
    new TabItem(Icons.calendar_today, "Calendario", Colors.black54,
        labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w300)),
    new TabItem(Icons.book, "Materias", ColorUtils.primaryColor,
        labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w300)),

  ]);

  CircularBottomNavigationController _navigationController =
  CircularBottomNavigationController(BottomNavBar.pos);

  Widget page;

  @override
  Widget build(BuildContext context) {
    page ??= CalendarCustom();
    return Scaffold(
        body: page,
        bottomNavigationBar: CircularBottomNavigation(
          tabItems,
          controller: _navigationController,
          selectedCallback: (int selectedPos) {
            callPage(selectedPos);
          },
          barBackgroundColor: Colors.white70,
        ),
    );
  }

  void callPage(int selectedPos) {
    setState(() {
      BottomNavBar.pos = selectedPos;
      switch (BottomNavBar.pos) {
        case 0:
          page = CalendarCustom();
          break;
        case 1:
          page = ListaMaterias();
          break;

      }
    });
  }
}
