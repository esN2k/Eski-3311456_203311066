import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../esendo/esendo_icon_button.dart';
import '../esendo/esendo_theme.dart';
import '../esendo/esendo_util.dart';
import '../esendo/esendo_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfileWidget extends StatefulWidget {
  const EditProfileWidget({
    Key key,
    this.displayName,
    this.email,
  }) : super(key: key);

  final UsersRecord displayName;
  final UsersRecord email;

  @override
  _EditProfileWidgetState createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  TextEditingController textController1;
  TextEditingController textController2;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view', parameters: {'screen_name': 'EditProfile'});
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UsersRecord>>(
      stream: queryUsersRecord(
        singleRecord: true,
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
        List<UsersRecord> editProfileUsersRecordList = snapshot.data;
        // Return an empty Container when the document does not exist.
        if (snapshot.data.isEmpty) {
          return Container();
        }
        final editProfileUsersRecord = editProfileUsersRecordList.isNotEmpty
            ? editProfileUsersRecordList.first
            : null;
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: EsenDoTheme.of(context).primaryColor,
            automaticallyImplyLeading: false,
            leading: EsenDoIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30,
              buttonSize: 48,
              icon: Icon(
                Icons.chevron_left_rounded,
                color: EsenDoTheme.of(context).tertiaryColor,
                size: 30,
              ),
              onPressed: () async {
                logFirebaseEvent('IconButton_ON_TAP');
                logFirebaseEvent('IconButton_Navigate-Back');
                Navigator.pop(context);
              },
            ),
            title: Text(
              'Profili Düzenle',
              style: EsenDoTheme.of(context).title2.override(
                    fontFamily: 'Lexend Deca',
                    color: EsenDoTheme.of(context).tertiaryColor,
                  ),
            ),
            actions: [],
            centerTitle: false,
            elevation: 0,
          ),
          backgroundColor: EsenDoTheme.of(context).darkBG,
          body: SafeArea(
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    decoration: BoxDecoration(
                      color: EsenDoTheme.of(context).secondaryColor,
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(2, 0, 0, 0),
                      child: StreamBuilder<UsersRecord>(
                        stream: UsersRecord.getDocument(currentUserReference),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: SpinKitFoldingCube(
                                  color:
                                      EsenDoTheme.of(context).primaryColor,
                                  size: 50,
                                ),
                              ),
                            );
                          }
                          final columnUsersRecord = snapshot.data;
                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 12, 0, 0),
                                child: Text(
                                  'Profil Bilgilerini Düzenle',
                                  style: EsenDoTheme.of(context).bodyText2,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 16, 16, 0),
                                child: TextFormField(
                                  controller: textController1 ??=
                                      TextEditingController(
                                    text: editProfileUsersRecord.displayName,
                                  ),
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Tam İsminiz',
                                    hintText: 'İsminiz...',
                                    hintStyle: EsenDoTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Lexend Deca',
                                          color: Color(0x9AFFFFFF),
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: EsenDoTheme.of(context)
                                            .tertiaryColor,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: EsenDoTheme.of(context)
                                            .tertiaryColor,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    filled: true,
                                    fillColor: EsenDoTheme.of(context)
                                        .tertiaryColor,
                                    prefixIcon: Icon(
                                      Icons.person_rounded,
                                      color: EsenDoTheme.of(context)
                                          .secondaryColor,
                                    ),
                                  ),
                                  style: EsenDoTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Lexend Deca',
                                        color: EsenDoTheme.of(context)
                                            .primaryColor,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 16, 16, 0),
                                child: TextFormField(
                                  controller: textController2 ??=
                                      TextEditingController(
                                    text: editProfileUsersRecord.email,
                                  ),
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'E-posta Adresi',
                                    hintText: 'E-posta adresiniz...',
                                    hintStyle: EsenDoTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Lexend Deca',
                                          color: Color(0x9AFFFFFF),
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: EsenDoTheme.of(context)
                                            .tertiaryColor,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: EsenDoTheme.of(context)
                                            .tertiaryColor,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    filled: true,
                                    fillColor: EsenDoTheme.of(context)
                                        .tertiaryColor,
                                    prefixIcon: Icon(
                                      Icons.email_outlined,
                                      color: EsenDoTheme.of(context)
                                          .secondaryColor,
                                    ),
                                  ),
                                  style: EsenDoTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Lexend Deca',
                                        color: EsenDoTheme.of(context)
                                            .primaryColor,
                                      ),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return 'Please fill in a valid email address...';
                                    }

                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 16),
                                      child: EDButtonWidget(
                                        onPressed: () async {
                                          logFirebaseEvent('Button_ON_TAP');
                                          logFirebaseEvent(
                                              'Button_Navigate-Back');
                                          Navigator.pop(context);
                                          logFirebaseEvent(
                                              'Button_Backend-Call');

                                          final usersUpdateData =
                                              createUsersRecordData(
                                            displayName:
                                                textController1?.text ?? '',
                                            email: textController2?.text ?? '',
                                          );
                                          await editProfileUsersRecord.reference
                                              .update(usersUpdateData);
                                        },
                                        text: 'Değişiklikleri Kaydet',
                                        options: EDButtonOptions(
                                          width: 230,
                                          height: 50,
                                          color: EsenDoTheme.of(context)
                                              .tertiaryColor,
                                          textStyle: EsenDoTheme.of(
                                                  context)
                                              .subtitle2
                                              .override(
                                                fontFamily: 'Lexend Deca',
                                                color:
                                                    EsenDoTheme.of(context)
                                                        .primaryColor,
                                              ),
                                          elevation: 3,
                                          borderSide: BorderSide(
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
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
