import 'package:esendo/esendo/internationalization.dart';

import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../esendo/esendo_theme.dart';
import '../esendo/esendo_util.dart';
import '../esendo/esendo_widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateTaskPageWidget extends StatefulWidget {
  const CreateTaskPageWidget({Key key}) : super(key: key);

  @override
  _CreateTaskPageWidgetState createState() => _CreateTaskPageWidgetState();
}

class _CreateTaskPageWidgetState extends State<CreateTaskPageWidget> {
  DateTime datePicked;
  TextEditingController textController1;
  TextEditingController textController2;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'createTaskPage'});
    textController1 = TextEditingController();
    textController2 = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xE6131619),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 44, 12, 12),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () async {
                    logFirebaseEvent('Card_ON_TAP');
                    logFirebaseEvent('Card_Navigate-Back');
                    Navigator.pop(context);
                  },
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: EsenDoTheme.of(context).darkBG,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                      child: Icon(
                        Icons.close_rounded,
                        color: EsenDoTheme.of(context).white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Material(
                  color: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 1,
                    decoration: BoxDecoration(
                      color: EsenDoTheme.of(context).primaryBlack,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 7,
                          color: Color(0x5D000000),
                          offset: Offset(0, -2),
                        )
                      ],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Yapılacak bir şey ekle',
                                style: EsenDoTheme.of(context).title2,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: AutoSizeText(
                                  'Yeni bir görev eklemek için aşağıdaki bölüme ayrıntıları doldurun.',
                                  style: EsenDoTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Lexend Deca',
                                        color:
                                            EsenDoTheme.of(context).white,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                          child: TextFormField(
                            controller: textController1,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Yapılacak şeyin ismi',
                              labelStyle: EsenDoTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Lexend Deca',
                                    color: EsenDoTheme.of(context)
                                        .tertiaryColor,
                                  ),
                              hintText: 'Yapılacak şeyi buraya girin...',
                              hintStyle: EsenDoTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Lexend Deca',
                                    color: EsenDoTheme.of(context)
                                        .tertiaryColor,
                                  ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: EsenDoTheme.of(context).darkBG,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: EsenDoTheme.of(context).darkBG,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: EsenDoTheme.of(context).darkBG,
                            ),
                            style: EsenDoTheme.of(context).bodyText1,
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                          child: TextFormField(
                            controller: textController2,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Detayları',
                              labelStyle: EsenDoTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Lexend Deca',
                                    color: EsenDoTheme.of(context)
                                        .tertiaryColor,
                                  ),
                              hintText: 'Detayını buraya ekleyin...',
                              hintStyle: EsenDoTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Lexend Deca',
                                    color: EsenDoTheme.of(context)
                                        .tertiaryColor,
                                  ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: EsenDoTheme.of(context).darkBG,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: EsenDoTheme.of(context).darkBG,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: EsenDoTheme.of(context).darkBG,
                            ),
                            style: EsenDoTheme.of(context).bodyText1,
                            textAlign: TextAlign.start,
                            maxLines: 3,
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                          child: InkWell(
                            onTap: () async {
                              logFirebaseEvent('Container_ON_TAP');
                              logFirebaseEvent('Container_Date-Time-Picker');
                              await DatePicker.showDateTimePicker(
                                context,
                                showTitleActions: true,
                                onConfirm: (date) {
                                  setState(() => datePicked = date);
                                },
                                currentTime: getCurrentTimestamp,
                                minTime: getCurrentTimestamp,
                                locale: LocaleType.values.firstWhere(
                                  (l) =>
                                      l.name ==
                                      EDLocalizations.of(context).languageCode,
                                  orElse: null,
                                ),
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.92,
                              height: 50,
                              decoration: BoxDecoration(
                                color: EsenDoTheme.of(context).darkBG,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: EsenDoTheme.of(context).darkBG,
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 14, 0, 0),
                                child: Text(
                                  dateTimeFormat('MMMMEEEEd', datePicked),
                                  style: EsenDoTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Lexend Deca',
                                        color: EsenDoTheme.of(context)
                                            .tertiaryColor,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              EDButtonWidget(
                                onPressed: () async {
                                  logFirebaseEvent('Button_ON_TAP');
                                  logFirebaseEvent('Button_Navigate-Back');
                                  Navigator.pop(context);
                                },
                                text: 'İptal',
                                options: EDButtonOptions(
                                  width: 130,
                                  height: 50,
                                  color: EsenDoTheme.of(context)
                                      .secondaryColor,
                                  textStyle: EsenDoTheme.of(context)
                                      .subtitle2
                                      .override(
                                        fontFamily: 'Lexend Deca',
                                        color: EsenDoTheme.of(context)
                                            .tertiaryColor,
                                      ),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: 12,
                                ),
                              ),
                              EDButtonWidget(
                                onPressed: () async {
                                  logFirebaseEvent('Button_ON_TAP');
                                  logFirebaseEvent('Button_Backend-Call');

                                  final toDoListCreateData =
                                      createToDoListRecordData(
                                    toDoName: textController1.text,
                                    toDoDescription: textController2.text,
                                    toDoDate: datePicked,
                                  );
                                  await ToDoListRecord.collection
                                      .doc()
                                      .set(toDoListCreateData);
                                  logFirebaseEvent('Button_Navigate-Back');
                                  Navigator.pop(context);
                                },
                                text: 'Yapılacak Ekle',
                                options: EDButtonOptions(
                                  width: 130,
                                  height: 50,
                                  color:
                                      EsenDoTheme.of(context).primaryColor,
                                  textStyle: EsenDoTheme.of(context)
                                      .subtitle2
                                      .override(
                                        fontFamily: 'Lexend Deca',
                                        color: Colors.white,
                                      ),
                                  elevation: 3,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: 8,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
