import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trabalho_sistemas/database/dao/materia_dao.dart';

import 'main_screen.dart';

class DialogCustom {
  static void showSaveCustomDialog(
      BuildContext context, String title, String message, DialogType type) {
    AwesomeDialog(
        context: context,
        dialogType: type,
        animType: AnimType.BOTTOMSLIDE,
        tittle: title,
        desc: message,
//btnCancelOnPress: () {},
        btnOkOnPress: () {
          Navigator.of(context, rootNavigator: true).pop();
        }).show();
  }
  static void showDeleteCustomDialog( BuildContext context,int idDelete){
    MateriaDao dao = MateriaDao();
    AwesomeDialog(
        context: context,
        headerAnimationLoop: false,
        dialogType: DialogType.WARNING,
        animType: AnimType.BOTTOMSLIDE,
        tittle: "Deseja deletar esse item?",
        desc:
        "Ao clicar Ok o item será apagado da sua lista de materias...",
        btnCancelOnPress: () {},
        dismissOnTouchOutside: true,
        btnOkOnPress: () {
          dao.delete(idDelete).then((value) {
          }).catchError((e) {
            print(e);
          });
        }).show();
  }

}
