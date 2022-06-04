import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../change_password/change_password_widget.dart';
import '../edit_profile/edit_profile_widget.dart';
import '../esendo/esendo_animations.dart';
import '../esendo/esendo_theme.dart';
import '../esendo/esendo_util.dart';
import '../esendo/esendo_widgets.dart';
import '../gestures/gestures.dart';
import '../splash_screen/splash_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProfileWidget extends StatefulWidget {
  const MyProfileWidget({
    Key key,
    this.displayName,
  }) : super(key: key);

  final UsersRecord displayName;

  @override
  _MyProfileWidgetState createState() => _MyProfileWidgetState();
}

class _MyProfileWidgetState extends State<MyProfileWidget>
    with TickerProviderStateMixin {
  final animationsMap = {
    'containerOnPageLoadAnimation': AnimationInfo(
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
    'rowOnPageLoadAnimation': AnimationInfo(
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

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'MyProfile'});
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
        List<UsersRecord> myProfileUsersRecordList = snapshot.data;
        // Return an empty Container when the document does not exist.
        if (snapshot.data.isEmpty) {
          return Container();
        }
        final myProfileUsersRecord = myProfileUsersRecordList.isNotEmpty
            ? myProfileUsersRecordList.first
            : null;
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: EsenDoTheme.of(context).primaryColor,
            automaticallyImplyLeading: false,
            title: Text(
              'Profiliniz',
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
          body: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      decoration: BoxDecoration(
                        color: EsenDoTheme.of(context).primaryColor,
                        border: Border.all(
                          color: EsenDoTheme.of(context).primaryColor,
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                        child: AuthUserStreamWidget(
                          child: Text(
                            currentUserDisplayName,
                            style: EsenDoTheme.of(context).subtitle1.override(
                                  fontFamily: 'Lexend Deca',
                                  color: EsenDoTheme.of(context).tertiaryColor,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 232,
                  decoration: BoxDecoration(
                    color: EsenDoTheme.of(context).secondaryColor,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
                        child: Text(
                          'Hesap Bilgileri',
                          style: EsenDoTheme.of(context).bodyText2,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 8),
                        child: InkWell(
                          onTap: () async {
                            logFirebaseEvent(
                                'MY_PROFILE_PAGE_Row_kthr1d0p_ON_TAP');
                            logFirebaseEvent('Row_Navigate-To');
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProfileWidget(
                                  displayName: myProfileUsersRecord,
                                  email: myProfileUsersRecord,
                                ),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16, 8, 0, 16),
                                  child: Text(
                                    'Profili Düzenle',
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
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 12, 8),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: EsenDoTheme.of(context).tertiaryColor,
                                  size: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        height: 2,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                        color: EsenDoTheme.of(context).primaryColor,
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 8),
                        child: InkWell(
                          onTap: () async {
                            logFirebaseEvent(
                                'MY_PROFILE_PAGE_Row_wwr27y1g_ON_TAP');
                            logFirebaseEvent('Row_Navigate-To');
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ChangePasswordWidget(),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16, 8, 0, 16),
                                  child: Text(
                                    'Şifre Değiştir',
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
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 12, 8),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: EsenDoTheme.of(context).tertiaryColor,
                                  size: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        height: 2,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                        color: EsenDoTheme.of(context).primaryColor,
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 8),
                        child: InkWell(
                          onTap: () async {
                            logFirebaseEvent(
                                'MY_PROFILE_PAGE_Row_mufucudx_ON_TAP');
                            logFirebaseEvent('Row_Navigate-To');
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const GesturesWidget(),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16, 8, 0, 16),
                                  child: Text(
                                    'Gesture\'lar',
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
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 12, 8),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: EsenDoTheme.of(context).tertiaryColor,
                                  size: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ).animated([animationsMap['containerOnPageLoadAnimation']]),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 0, 16),
                              child: EDButtonWidget(
                                onPressed: () async {
                                  logFirebaseEvent(
                                      'MY_PROFILE_PAGE_ÇIKIŞ_YAP_BUTTON_ON_TAP');
                                  logFirebaseEvent('Button_Navigate-To');
                                  await Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.bottomToTop,
                                      duration:
                                          const Duration(milliseconds: 250),
                                      reverseDuration:
                                          const Duration(milliseconds: 250),
                                      child: const SplashScreenWidget(),
                                    ),
                                  );
                                  logFirebaseEvent('Button_Auth');
                                  await signOut();
                                },
                                text: 'Çıkış Yap',
                                options: EDButtonOptions(
                                  width: 130,
                                  height: 50,
                                  color: EsenDoTheme.of(context).tertiaryColor,
                                  textStyle: EsenDoTheme.of(context)
                                      .subtitle2
                                      .override(
                                        fontFamily: 'Lexend Deca',
                                        color: EsenDoTheme.of(context)
                                            .primaryColor,
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
                            Text(
                              'Uygulama Versiyonu v2.0',
                              textAlign: TextAlign.center,
                              style: EsenDoTheme.of(context).bodyText2,
                            ),
                          ],
                        ),
                      ],
                    ).animated([animationsMap['rowOnPageLoadAnimation']]),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
