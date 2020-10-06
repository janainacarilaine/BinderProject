import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:open_file/open_file.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:trabalho_sistemas/database/dao/materia_dao.dart';
import 'package:trabalho_sistemas/model/materias.dart';
import 'package:trabalho_sistemas/util/colors_util.dart';

class CalendarCustom extends StatefulWidget {
  @override
  _CalendarCustomState createState() => _CalendarCustomState();
}

class _CalendarCustomState extends State<CalendarCustom> {
  CalendarController _controller;
  Map<DateTime, List> _events = Map();
  List<Materia> listSpecial = List();

  @override
  void initState() {
    super.initState();
    getSpecialDates().catchError((e) {
      print(e);
    });
    _controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();

    return WillPopScope(
      onWillPop: () async => false,
      child:  Scaffold(
            body: Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TableCalendar(
                  events: _events,
                  locale: 'pt_BR',
                  headerStyle: HeaderStyle(
                      centerHeaderTitle: true,
                      formatButtonVisible: false,
                      titleTextStyle: TextStyle(
                        fontSize: 25.0,
                      )),
                  initialCalendarFormat: CalendarFormat.month,
                  calendarStyle: CalendarStyle(
                    selectedColor: ColorUtils.primaryColor,
                    todayStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.white),
                    selectedStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.white),
                  ),
                  calendarController: _controller,
                  onDaySelected: _onDaySelected,
                ),
              ],
            ),
          ),
        ))

    );
  }

  void _onDaySelected(DateTime day, List events) {
    listSpecial.forEach((specialDate) {
      DateTime updateDateTime = DateTime.parse(specialDate.dataEscolhida);
      if (updateDateTime.day == day.day &&
          updateDateTime.month == day.month &&
          updateDateTime.year == day.year) {
        _modalBottomSheetMenu(day, events, specialDate);
      }
    });
  }

  Widget _modalBottomSheetMenu(DateTime day, List events, Materia specialDate) {
    showModalBottomSheet(

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        context: context,
        builder: (builder) {
          return ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                    child: Text(
                  specialDate.nomeMateria,
                  style: TextStyle(fontSize: 20, fontFamily: 'Helvetica',fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                )),
              ),
              Center(
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(specialDate.anotacoes)),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    GestureDetector(
                      child: Container(
                        height: 100,
                        width: 100,
                        foregroundDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(
                                width: 2.0, color: ColorUtils.primaryColor)),
                        child: Icon(
                          Icons.photo_camera,
                          size: 80.0,
                          color: ColorUtils.accentColor,
                        ),
                      ),
                      onTap: () =>
                          OpenFile.open(specialDate.pathImg).catchError((e) {
                        print(e);
                      }),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      foregroundDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(
                              width: 2.0, color: ColorUtils.primaryColor)),
                      child: GestureDetector(
                        child: Icon(
                          Icons.picture_as_pdf,
                          size: 80.0,
                          color: ColorUtils.accentColor,
                        ),
                        onTap: () => //
                            OpenFile.open(specialDate.pathPdf)
                                .catchError((e) {
                          print(e);
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  Future<List<Materia>> getSpecialDates() async {
    MateriaDao dao = MateriaDao();
    dao.findAll().then((datas) {
      listSpecial = datas;
      datas.forEach((data) {
        DateTime updateDateTime = DateTime.parse(data.dataEscolhida);
        setState(() {
          _events.putIfAbsent(updateDateTime, () => [data]);
        });
      });
    });
  }
}
