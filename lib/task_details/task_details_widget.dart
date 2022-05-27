import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../esendo/esendo_theme.dart';
import '../esendo/esendo_util.dart';
import '../esendo/esendo_widgets.dart';
import '../main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskDetailsWidget extends StatefulWidget {
  const TaskDetailsWidget({
    Key key,
    this.toDoNote,
  }) : super(key: key);

  final DocumentReference toDoNote;

  @override
  _TaskDetailsWidgetState createState() => _TaskDetailsWidgetState();
}

class _TaskDetailsWidgetState extends State<TaskDetailsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view', parameters: {'screen_name': 'TaskDetails'});
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ToDoListRecord>(
      stream: ToDoListRecord.getDocument(widget.toDoNote),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: SpinKitFoldingCube(
                color: EsenDoTheme.of(context).primaryColor,
                size: 50,
              ),
            ),
          );
        }
        final taskDetailsToDoListRecord = snapshot.data;
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: EsenDoTheme.of(context).primaryBlack,
            automaticallyImplyLeading: false,
            leading: InkWell(
              onTap: () async {
                logFirebaseEvent('Icon_ON_TAP');
                logFirebaseEvent('Icon_Navigate-Back');
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_rounded,
                color: EsenDoTheme.of(context).white,
                size: 24,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                child: InkWell(
                  onTap: () async {
                    logFirebaseEvent('Icon_ON_TAP');
                    logFirebaseEvent('Icon_Backend-Call');
                    await widget.toDoNote.delete();
                    logFirebaseEvent('Icon_Navigate-Back');
                    Navigator.pop(context);
                  },
                  child: FaIcon(
                    FontAwesomeIcons.solidTrashAlt,
                    color: EsenDoTheme.of(context).white,
                    size: 28,
                  ),
                ),
              ),
            ],
            centerTitle: false,
            elevation: 0,
          ),
          backgroundColor: EsenDoTheme.of(context).darkBG,
          body: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Material(
                      color: Colors.transparent,
                      elevation: 3,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                        ),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.35,
                        decoration: BoxDecoration(
                          color: EsenDoTheme.of(context).primaryBlack,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(0),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16, 0, 16, 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Text(
                                      taskDetailsToDoListRecord.toDoName,
                                      style: EsenDoTheme.of(context).title1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16, 0, 16, 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: StreamBuilder<ToDoListRecord>(
                                      stream: ToDoListRecord.getDocument(
                                          taskDetailsToDoListRecord.reference),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: SizedBox(
                                              width: 50,
                                              height: 50,
                                              child: SpinKitFoldingCube(
                                                color: EsenDoTheme.of(context)
                                                    .primaryColor,
                                                size: 50,
                                              ),
                                            ),
                                          );
                                        }
                                        final textToDoListRecord =
                                            snapshot.data;
                                        return Text(
                                          textToDoListRecord.toDoDescription,
                                          style: EsenDoTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Lexend Deca',
                                                color: EsenDoTheme.of(context)
                                                    .white,
                                              ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              indent: 16,
                              endIndent: 16,
                              color: EsenDoTheme.of(context).primaryColor,
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16, 8, 16, 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Zamanı',
                                      style: EsenDoTheme.of(context)
                                          .subtitle1
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
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16, 0, 16, 4),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Text(
                                      dateTimeFormat('MMMEd',
                                          taskDetailsToDoListRecord.toDoDate),
                                      style: EsenDoTheme.of(context).title2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 16, 0, 0),
                              child: EDButtonWidget(
                                onPressed: () async {
                                  logFirebaseEvent('Button_ON_TAP');
                                  logFirebaseEvent('Button_Navigate-To');
                                  await Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.leftToRight,
                                      duration:
                                          const Duration(milliseconds: 250),
                                      reverseDuration:
                                          const Duration(milliseconds: 250),
                                      child: const NavBarPage(
                                          initialPage: 'CompletedTasks'),
                                    ),
                                  );
                                  logFirebaseEvent('Button_Backend-Call');

                                  final toDoListUpdateData =
                                      createToDoListRecordData(
                                    toDoState: true,
                                  );
                                  await widget.toDoNote
                                      .update(toDoListUpdateData);
                                },
                                text: 'Yapılmış olarak işaretle',
                                options: EDButtonOptions(
                                  width: 300,
                                  height: 56,
                                  color: EsenDoTheme.of(context).primaryColor,
                                  textStyle: EsenDoTheme.of(context)
                                      .subtitle2
                                      .override(
                                        fontFamily: 'Lexend Deca',
                                        color: Colors.white,
                                      ),
                                  elevation: 3,
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: 8,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
