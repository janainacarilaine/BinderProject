import 'package:flutter/material.dart';
import 'package:trabalho_sistemas/model/materias.dart';
import 'package:trabalho_sistemas/util/colors_util.dart';

class CardMateria extends StatelessWidget {
  Materia materia;

  CardMateria(this.materia);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15,right: 15),
      child: Container(
        height: 75,
        width:  MediaQuery.of(context).size.width * 0.8,
        child: Card(
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Icon(
                  Icons.library_books,
                  color: ColorUtils.accentColor,
                  size: 30.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(materia.nomeMateria),
              )
            ],
          )
        ),
      ),
    );
  }
}
