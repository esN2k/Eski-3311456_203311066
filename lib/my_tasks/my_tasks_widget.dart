import '../backend/backend.dart';
import '../create_task_page/create_task_page_widget.dart';
import '../esendo/esendo_animations.dart';
import '../esendo/esendo_icon_button.dart';
import '../esendo/esendo_theme.dart';
import '../esendo/esendo_toggle_icon.dart';
import '../esendo/esendo_util.dart';
import '../task_details/task_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyTasksWidget extends StatefulWidget {
  const MyTasksWidget({Key key}) : super(key: key);

  @override
  _MyTasksWidgetState createState() => _MyTasksWidgetState();
}

class _MyTasksWidgetState extends State<MyTasksWidget>
    with TickerProviderStateMixin {
  final animationsMap = {
    'rowOnPageLoadAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      duration: 600,
      fadeIn: true,
      initialState: AnimationState(
        offset: const Offset(0, 0),
        scale: 1,
        opacity: 0,
      ),
      finalState: AnimationState(
        offset: const Offset(0, 0),
        scale: 1,
        opacity: 1,
      ),
    ),
    'rowOnPageLoadAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      duration: 600,
      fadeIn: true,
      initialState: AnimationState(
        offset: const Offset(0, 0),
        scale: 1,
        opacity: 0,
      ),
      finalState: AnimationState(
        offset: const Offset(0, 0),
        scale: 1,
        opacity: 1,
      ),
    ),
    'floatingActionButtonOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      duration: 1000,
      fadeIn: true,
      initialState: AnimationState(
        offset: const Offset(0, 0),
        scale: 1,
        opacity: 0,
      ),
      finalState: AnimationState(
        offset: const Offset(0, 0),
        scale: 1,
        opacity: 1,
      ),
    ),
  };
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    startPageLoadAnimations(
      animationsMap.values
          .where((anim) => anim.trigger == AnimationTrigger.onPageLoad),
      this,
    );

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'myTasks'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: EsenDoTheme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          'Yapılacaklarım',
          style: EsenDoTheme.of(context).title1.override(
                fontFamily: 'Lexend Deca',
                color: EsenDoTheme.of(context).tertiaryColor,
              ),
        ),
        actions: const [],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: EsenDoTheme.of(context).darkBG,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('FloatingActionButton pressed ...');
        },
        backgroundColor: EsenDoTheme.of(context).primaryColor,
        elevation: 8,
        child: EsenDoIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          buttonSize: 48,
          icon: Icon(
            Icons.add_rounded,
            color: EsenDoTheme.of(context).tertiaryColor,
            size: 30,
          ),
          onPressed: () async {
            logFirebaseEvent('IconButton_ON_TAP');
            logFirebaseEvent('IconButton_Navigate-To');
            await Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.bottomToTop,
                duration: const Duration(milliseconds: 270),
                reverseDuration: const Duration(milliseconds: 270),
                child: const CreateTaskPageWidget(),
              ),
            );
          },
        ),
      ).animated([animationsMap['floatingActionButtonOnPageLoadAnimation']]),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 53,
                  decoration: BoxDecoration(
                    color: EsenDoTheme.of(context).darkBG,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: Image.asset(
                        'assets/images/Esen.do__6_-removebg.png',
                      ).image,
                    ),
                    shape: BoxShape.rectangle,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Zamanla Yapılacaklar:',
                    style: EsenDoTheme.of(context).bodyText2,
                  ),
                ],
              ).animated([animationsMap['rowOnPageLoadAnimation1']]),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: StreamBuilder<List<ToDoListRecord>>(
                        stream: queryToDoListRecord(
                          queryBuilder: (toDoListRecord) =>
                              toDoListRecord.orderBy('toDoDate'),
                        ),
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
                          List<ToDoListRecord> columnToDoListRecordList =
                              snapshot.data;
                          return SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                                  List.generate(columnToDoListRecordList.length,
                                      (columnIndex) {
                                final columnToDoListRecord =
                                    columnToDoListRecordList[columnIndex];
                                return Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 8),
                                  child: InkWell(
                                    onTap: () async {
                                      logFirebaseEvent('Container_ON_TAP');
                                      logFirebaseEvent('Container_Navigate-To');
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              TaskDetailsWidget(
                                            toDoNote:
                                                columnToDoListRecord.reference,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Material(
                                      color: Colors.transparent,
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color: EsenDoTheme.of(context)
                                              .primaryBlack,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(16, 0, 0, 0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      columnToDoListRecord
                                                          .toDoName,
                                                      style: EsenDoTheme.of(
                                                              context)
                                                          .title2,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                              0, 4, 0, 0),
                                                      child: Text(
                                                        dateTimeFormat(
                                                            'MMMEd',
                                                            columnToDoListRecord
                                                                .toDoDate),
                                                        style:
                                                            EsenDoTheme.of(
                                                                    context)
                                                                .bodyText2
                                                                .override(
                                                                  fontFamily:
                                                                      'Lexend Deca',
                                                                  color: EsenDoTheme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          0, 0, 12, 0),
                                                  child: ToggleIcon(
                                                    onPressed: () async {
                                                      final toDoListUpdateData =
                                                          createToDoListRecordData(
                                                        toDoState:
                                                            !columnToDoListRecord
                                                                .toDoState,
                                                      );
                                                      await columnToDoListRecord
                                                          .reference
                                                          .update(
                                                              toDoListUpdateData);
                                                    },
                                                    value: columnToDoListRecord
                                                        .toDoState,
                                                    onIcon: Icon(
                                                      Icons.check_circle,
                                                      color: EsenDoTheme.of(
                                                              context)
                                                          .primaryColor,
                                                      size: 25,
                                                    ),
                                                    offIcon: const Icon(
                                                      Icons.radio_button_off,
                                                      color: Color(0xFF2B343A),
                                                      size: 25,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ).animated([animationsMap['rowOnPageLoadAnimation2']]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
