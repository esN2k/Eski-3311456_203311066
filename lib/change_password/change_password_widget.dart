import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../esendo/esendo_icon_button.dart';
import '../esendo/esendo_theme.dart';
import '../esendo/esendo_util.dart';
import '../esendo/esendo_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePasswordWidget extends StatefulWidget {
  const ChangePasswordWidget({Key key}) : super(key: key);

  @override
  _ChangePasswordWidgetState createState() => _ChangePasswordWidgetState();
}

class _ChangePasswordWidgetState extends State<ChangePasswordWidget> {
  TextEditingController emailTextController;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    emailTextController = TextEditingController();
    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'ChangePassword'});
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
        List<UsersRecord> changePasswordUsersRecordList = snapshot.data;
        // Return an empty Container when the document does not exist.
        if (snapshot.data.isEmpty) {
          return Container();
        }
        final changePasswordUsersRecord =
            changePasswordUsersRecordList.isNotEmpty
                ? changePasswordUsersRecordList.first
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
              'Şifre Değiştir',
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
                    height: 200,
                    decoration: BoxDecoration(
                      color: EsenDoTheme.of(context).secondaryColor,
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(2, 0, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
                            child: Text(
                              'E-postanızı girin, size güncellemeniz için e-postanıza bir şifre sıfırlama bağlantısı göndereceğiz.',
                              style: EsenDoTheme.of(context)
                                  .bodyText2
                                  .override(
                                    fontFamily: 'Lexend Deca',
                                    color: EsenDoTheme.of(context)
                                        .primaryColor,
                                  ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                            child: TextFormField(
                              controller: emailTextController,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'E-posta adresiniz',
                                hintText: 'E-posta\'nıza link yollayacağız...',
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
                                fillColor:
                                    EsenDoTheme.of(context).tertiaryColor,
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
                                        .secondaryColor,
                                  ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Please fill in a new password..';
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
                                      logFirebaseEvent('emailAddress_ON_TAP');
                                      logFirebaseEvent(
                                          'emailAddress_Navigate-Back');
                                      Navigator.pop(context);
                                      logFirebaseEvent('emailAddress_Auth');
                                      if (emailTextController.text.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'E-posta gerekiyor.',
                                            ),
                                          ),
                                        );
                                        return;
                                      }
                                      await resetPassword(
                                        email: emailTextController.text,
                                        context: context,
                                      );
                                    },
                                    text: 'Link Yolla',
                                    options: EDButtonOptions(
                                      width: 230,
                                      height: 50,
                                      color: EsenDoTheme.of(context)
                                          .tertiaryColor,
                                      textStyle: EsenDoTheme.of(context)
                                          .subtitle2
                                          .override(
                                            fontFamily: 'Lexend Deca',
                                            color: EsenDoTheme.of(context)
                                                .secondaryColor,
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
