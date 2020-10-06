//
//
import 'package:flushbar/flushbar.dart';
import 'package:flutter/widgets.dart';

class FlusBarCustom{
  String title;
  BuildContext context;
  Icon icon;

  FlusBarCustom(this.title, this.context, this.icon);

  Flushbar flushbar(){
    Flushbar(
      icon: icon,
      message:  title,
      duration:  Duration(seconds: 3),
    )..show(context);
  }
}
