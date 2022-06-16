// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import '../backend/backend.dart';
import '../esendo/esendo_theme.dart';
import '../esendo/esendo_util.dart';
import '../esendo/esendo_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class CreateTaskWidget extends StatefulWidget {
  const CreateTaskWidget({Key? key}) : super(key: key);

  @override
  _CreateTaskWidgetState createState() => _CreateTaskWidgetState();
}

class _CreateTaskWidgetState extends State<CreateTaskWidget> {
  late DateTime datePicked;
  late TextEditingController textController1;
  late TextEditingController textController2;
  late ToDoListRecord newRecord;

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 470,
        decoration: BoxDecoration(
          color: EsenDoTheme.of(context).primaryBlack,
          boxShadow: const [
            BoxShadow(
              blurRadius: 7,
              color: Color(0x5D000000),
              offset: Offset(0, -2),
            )
          ],
          borderRadius: BorderRadius.circular(0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Yapılacak Bir Şey Ekleyin',
                    style: EsenDoTheme.of(context).title2,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Yapılacak şeyi eklemek için ayrıntıları doldurun.',
                    style: EsenDoTheme.of(context).bodyText1.override(
                          fontFamily: 'Lexend Deca',
                          color: EsenDoTheme.of(context).tertiaryColor,
                        ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
              child: TextFormField(
                controller: textController1,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Yapılacak Şeyin İsmi',
                  labelStyle: EsenDoTheme.of(context).bodyText1.override(
                        fontFamily: 'Lexend Deca',
                        color: EsenDoTheme.of(context).tertiaryColor,
                      ),
                  hintText: 'Yapılacak şeyi buraya yazın...',
                  hintStyle: EsenDoTheme.of(context).bodyText1.override(
                        fontFamily: 'Lexend Deca',
                        color: EsenDoTheme.of(context).tertiaryColor,
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
              padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
              child: TextFormField(
                controller: textController2,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Detayları',
                  labelStyle: EsenDoTheme.of(context).bodyText1.override(
                        fontFamily: 'Lexend Deca',
                        color: EsenDoTheme.of(context).tertiaryColor,
                      ),
                  hintText: 'Detayları buraya ekleyin...',
                  hintStyle: EsenDoTheme.of(context).bodyText1.override(
                        fontFamily: 'Lexend Deca',
                        color: EsenDoTheme.of(context).tertiaryColor,
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
              padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
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
                          l.name == EDLocalizations.of(context)!.languageCode,
                      orElse: () => LocaleType.en,
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
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 14, 0, 0),
                    child: Text(
                      dateTimeFormat('MMMEd', datePicked),
                      style: EsenDoTheme.of(context).bodyText1.override(
                            fontFamily: 'Lexend Deca',
                            color: EsenDoTheme.of(context).tertiaryColor,
                          ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
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
                      color: EsenDoTheme.of(context).primaryBlack,
                      textStyle: EsenDoTheme.of(context).subtitle2.override(
                            fontFamily: 'Lexend Deca',
                            color: Colors.white,
                          ),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: 8,
                      splashColor: EsenDoTheme.of(context).primaryColor,
                      disabledColor: EsenDoTheme.of(context).primaryColor,
                      padding: const EdgeInsets.all(0),
                      iconSize: 0,
                      disabledTextColor: Colors.white,
                      iconColor: Colors.white,
                      iconPadding: const EdgeInsets.all(0),
                      elevation: 0,
                    ),
                    icon: const Icon(Icons.exit_to_app),
                    iconData: Icons.exit_to_app,
                    key: const Key('exit_to_app'),
                  ),
                  EDButtonWidget(
                    onPressed: () async {
                      logFirebaseEvent('Button_ON_TAP');
                      logFirebaseEvent('Button_Backend-Call');

                      final toDoListCreateData = createToDoListRecordData(
                        toDoName: textController1.text,
                        toDoDescription: textController2.text,
                        toDoDate: datePicked,
                      );
                      var toDoListRecordReference =
                          ToDoListRecord.collection.doc();
                      await toDoListRecordReference.set(toDoListCreateData);
                      newRecord = ToDoListRecord.getDocumentFromData(
                          toDoListCreateData, toDoListRecordReference)!;
                      logFirebaseEvent('Button_Navigate-Back');
                      Navigator.pop(context);

                      setState(() {});
                    },
                    text: 'Yapılacak Ekle',
                    options: EDButtonOptions(
                      width: 130,
                      height: 50,
                      color: EsenDoTheme.of(context).primaryColor,
                      textStyle: EsenDoTheme.of(context).subtitle2.override(
                            fontFamily: 'Lexend Deca',
                            color: Colors.white,
                          ),
                      elevation: 3,
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: 8,
                      splashColor: EsenDoTheme.of(context).primaryColor,
                      disabledColor: EsenDoTheme.of(context).primaryColor,
                      padding: const EdgeInsets.all(0),
                      iconSize: 0,
                      disabledTextColor: Colors.white,
                      iconColor: Colors.white,
                      iconPadding: const EdgeInsets.all(0),
                    ),
                    icon: const Icon(Icons.exit_to_app),
                    iconData: Icons.exit_to_app,
                    key: const Key('exit_to_app'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
