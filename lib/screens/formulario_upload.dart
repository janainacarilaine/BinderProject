import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:trabalho_sistemas/componentes/dialog_custom.dart';
import 'package:trabalho_sistemas/componentes/flushbar_custom.dart';
import 'package:trabalho_sistemas/database/dao/materia_dao.dart';
import 'package:trabalho_sistemas/model/materias.dart';
import 'package:trabalho_sistemas/util/colors_util.dart';

class Formulario extends StatefulWidget {
  @override
  _FormularioState createState() => _FormularioState();
  Materia materia = Materia();

  Formulario(this.materia);
}

class _FormularioState extends State<Formulario> {
  DateTime selectedDate;
  TextEditingController dataTextField = new TextEditingController();
  TextEditingController anotacaotField = new TextEditingController();
  var isPdfPicked = false;
  var isImagePicked = false;

  @override
  void initState() {
    super.initState();
    if (widget.materia.anotacoes != null) {
      anotacaotField.text = widget.materia.anotacoes;
    }
    if (widget.materia.dataEscolhida != null) {
      DateTime myDate = DateTime.parse(widget.materia.dataEscolhida);
      dataTextField.text = "${myDate.day}/${myDate.month}/${myDate.year}";
    }
    if (widget.materia.pathImg != null) {
      isImagePicked = true;
    }
    if (widget.materia.pathPdf != null) {
      isPdfPicked = true;
    }
    anotacaotField.addListener(() {
      widget.materia.anotacoes = anotacaotField.text;
    });
  }

  @override
  Widget build(BuildContext mContext) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.materia.nomeMateria,
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: ColorUtils.accentColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: TextFormField(
                    controller: dataTextField,
                    readOnly: true,
                    style: TextStyle(
                      color: ColorUtils.accentColor,
                    ),
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.calendar_today,
                        color: ColorUtils.accentColor,
                      ),
                      hintStyle: TextStyle(color: Colors.black12),
                      labelText: "Data",
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 2.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 2.0)),
                    ),
                    onTap: () => datePicker(context),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: GestureDetector(
                    child: Container(
                        height: 100,
                        width: 100,
                        foregroundDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(
                                width: 2.0,
                                color: ColorUtils.primaryColor)),
                        child: Icon(
                          isImagePicked
                              ? Icons.done_outline
                              : Icons.photo_camera,
                          size: 40.0,
                          color: isImagePicked
                              ? Colors.green
                              : ColorUtils.accentColor,
                        )),
                    onTap: () => saveFile(FileType.image),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: GestureDetector(
                    child: Container(
                        height: 100,
                        width: 100,
                        foregroundDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(
                                width: 2.0,
                                color: ColorUtils.primaryColor)),
                        child: Icon(
                          isPdfPicked
                              ? Icons.done_outline
                              : Icons.picture_as_pdf,
                          size: 40.0,
                          color: isPdfPicked
                              ? Colors.green
                              : ColorUtils.accentColor,
                        )),
                    onTap: () => saveFile(FileType.custom),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: TextFormField(
                    controller: anotacaotField,
                    style: TextStyle(
                      color: ColorUtils.accentColor,
                    ),
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.text_fields,
                        color: ColorUtils.accentColor,
                      ),
                      hintStyle: TextStyle(color: Colors.black12),
                      labelText: "Descrição de anotações",
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.grey, width: 2.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.grey, width: 2.0)),
                    ),
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    if (widget.materia.pathPdf == null ||
                        widget.materia.pathImg == null ||
                        widget.materia.anotacoes == null ||
                        widget.materia.dataEscolhida == null) {
                      FlusBarCustom(
                          "Preencha todos os campos.",
                          mContext,
                          Icon(
                            Icons.error,
                            color: Colors.red,
                          )).flushbar();
                    } else {
                      saveDocuments(mContext);
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 100,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Icon(
                            Icons.save,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Salvar",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  color: ColorUtils.accentColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void saveFile(FileType fileType) async {
    var file = await FilePicker.getFile(type: fileType, fileExtension: "PDF");
    setState(() {
      if (fileType == FileType.image) {
        widget.materia.pathImg = file.path;
        setState(() {
          isImagePicked = true;
        });
      } else {
        widget.materia.pathPdf = file.path;
        setState(() {
          isPdfPicked = true;
        });
      }
    });
  }

  Future<void> saveDocuments(BuildContext mContext) async {
    MateriaDao dao = MateriaDao();
    dao.update(widget.materia).then((value) {
      DialogCustom.showSaveCustomDialog(mContext, "Salvo com Sucesso",
          "Dados foram salvos no lembrete", DialogType.SUCCES);
    });
  }

  void datePicker(BuildContext mContext) async {
    DateTime date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          isMaterialAppTheme: true,
          data: ThemeData.dark(),
          child: child,
        );
      },
    );
    if (date != null) {
      selectedDate = date;
      widget.materia.dataEscolhida = date.toIso8601String();
      dataTextField.text = "${date.day}/${date.month}/${date.year}";
    }
  }
}
