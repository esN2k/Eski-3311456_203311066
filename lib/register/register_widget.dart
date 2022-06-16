// ignore_for_file: library_private_types_in_public_api, unnecessary_null_comparison, use_build_context_synchronously, prefer_const_constructors

import '../auth/auth_util.dart';
import '../esendo/esendo_animations.dart';
import '../esendo/esendo_theme.dart';
import '../esendo/esendo_util.dart';
import '../esendo/esendo_widgets.dart';
import '../login/login_widget.dart';
import '../main.dart';
import 'package:flutter/material.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget>
    with TickerProviderStateMixin {
  late TextEditingController confirmPasswordTextController;
  late bool passwordVisibility2;
  late TextEditingController emailTextController;
  late TextEditingController fullNameController;
  late TextEditingController passwordTextController;
  late bool passwordVisibility1;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final animationsMap = {
    'columnOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      duration: 1500,
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
    'textFieldOnPageLoadAnimation': AnimationInfo(
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

  @override
  void initState() {
    super.initState();
    startPageLoadAnimations(
      animationsMap.values
          .where((anim) => anim.trigger == AnimationTrigger.onPageLoad),
      this,
    );

    confirmPasswordTextController = TextEditingController();
    passwordVisibility2 = false;
    emailTextController = TextEditingController();
    fullNameController = TextEditingController();
    passwordTextController = TextEditingController();
    passwordVisibility1 = false;
    logFirebaseEvent('screen_view', parameters: {'screen_name': 'Register'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: EsenDoTheme.of(context).primaryColor,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                    color: EsenDoTheme.of(context).secondaryColor,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.asset(
                        'assets/images/Esen.do_(7)_preview_rev_1.png',
                      ).image,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 36),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            TextFormField(
                              controller: fullNameController,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Tam İsminiz',
                                hintText: 'İsim buraya girilir...',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        EsenDoTheme.of(context).tertiaryColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        EsenDoTheme.of(context).tertiaryColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor:
                                    EsenDoTheme.of(context).tertiaryColor,
                              ),
                              style: EsenDoTheme.of(context).bodyText1.override(
                                    fontFamily: 'Lexend Deca',
                                    color:
                                        EsenDoTheme.of(context).secondaryColor,
                                  ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 20, 0, 0),
                              child: TextFormField(
                                controller: emailTextController,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'E-posta Adresiniz',
                                  hintText: 'E-posta buraya girlir...',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          EsenDoTheme.of(context).tertiaryColor,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          EsenDoTheme.of(context).tertiaryColor,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor:
                                      EsenDoTheme.of(context).tertiaryColor,
                                ),
                                style:
                                    EsenDoTheme.of(context).bodyText1.override(
                                          fontFamily: 'Lexend Deca',
                                          color: EsenDoTheme.of(context)
                                              .secondaryColor,
                                        ),
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 20, 0, 0),
                              child: TextFormField(
                                controller: passwordTextController,
                                obscureText: !passwordVisibility1,
                                decoration: InputDecoration(
                                  labelText: 'Şifreniz',
                                  hintText: 'Şifre buraya girilir...',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          EsenDoTheme.of(context).tertiaryColor,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          EsenDoTheme.of(context).tertiaryColor,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor:
                                      EsenDoTheme.of(context).tertiaryColor,
                                  suffixIcon: InkWell(
                                    onTap: () => setState(
                                      () => passwordVisibility1 =
                                          !passwordVisibility1,
                                    ),
                                    child: Icon(
                                      passwordVisibility1
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: EsenDoTheme.of(context)
                                          .secondaryColor,
                                      size: 22,
                                    ),
                                  ),
                                ),
                                style:
                                    EsenDoTheme.of(context).bodyText1.override(
                                          fontFamily: 'Lexend Deca',
                                          color: EsenDoTheme.of(context)
                                              .secondaryColor,
                                        ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 20, 0, 0),
                              child: TextFormField(
                                controller: confirmPasswordTextController,
                                obscureText: !passwordVisibility2,
                                decoration: InputDecoration(
                                  labelText: 'Şifrenizi Onaylayın',
                                  hintText:
                                      'Hataya müsait olanlar bir kez daha girsinler...',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          EsenDoTheme.of(context).tertiaryColor,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          EsenDoTheme.of(context).tertiaryColor,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor:
                                      EsenDoTheme.of(context).tertiaryColor,
                                  suffixIcon: InkWell(
                                    onTap: () => setState(
                                      () => passwordVisibility2 =
                                          !passwordVisibility2,
                                    ),
                                    child: Icon(
                                      passwordVisibility2
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: EsenDoTheme.of(context)
                                          .secondaryColor,
                                      size: 22,
                                    ),
                                  ),
                                ),
                                style:
                                    EsenDoTheme.of(context).bodyText1.override(
                                          fontFamily: 'Lexend Deca',
                                          color: EsenDoTheme.of(context)
                                              .secondaryColor,
                                        ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 24, 0, 0),
                              child: EDButtonWidget(
                                onPressed: () async {
                                  logFirebaseEvent('Button_ON_TAP');
                                  logFirebaseEvent('Button_Auth');
                                  if (passwordTextController.text !=
                                      confirmPasswordTextController.text) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Şifreler uymuyor',
                                        ),
                                      ),
                                    );
                                    return;
                                  }

                                  final user = await createAccountWithEmail(
                                    context,
                                    emailTextController.text,
                                    passwordTextController.text,
                                  );
                                  if (user == null) {
                                    return;
                                  }
                                  await Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const NavBarPage(
                                          initialPage: 'myTasks'),
                                    ),
                                    (r) => false,
                                  );
                                },
                                text: 'Hesap Yarat',
                                options: EDButtonOptions(
                                  width: 200,
                                  height: 50,
                                  color: EsenDoTheme.of(context).darkBG,
                                  textStyle: EsenDoTheme.of(context)
                                      .subtitle2
                                      .override(
                                        fontFamily: 'Lexend Deca',
                                        color: EsenDoTheme.of(context)
                                            .tertiaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                  elevation: 3,
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: 0,
                                  disabledColor:
                                      EsenDoTheme.of(context).primaryColor,
                                  disabledTextColor:
                                      EsenDoTheme.of(context).secondaryColor,
                                  splashColor:
                                      EsenDoTheme.of(context).primaryColor,
                                  iconColor: Colors.transparent,
                                  padding: const EdgeInsets.all(0),
                                  iconPadding: const EdgeInsets.all(0),
                                  iconSize: 0,
                                ),
                                icon: Icon(Icons.arrow_forward_ios),
                                iconData: Icons.arrow_forward_ios,
                                key: const Key('signUpButton'),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 6),
                                    child: Text(
                                      'Hesabın varsa niye bu ekrandasın?',
                                      style: EsenDoTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Lexend Deca',
                                            color:
                                                EsenDoTheme.of(context).darkBG,
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 8, 0, 0),
                                    child: EDButtonWidget(
                                      onPressed: () async {
                                        logFirebaseEvent('Button_ON_TAP');
                                        logFirebaseEvent('Button_Navigate-To');
                                        await Navigator.push(
                                          context,
                                          PageTransition(
                                            type: PageTransitionType.fade,
                                            duration: const Duration(
                                                milliseconds: 200),
                                            reverseDuration: const Duration(
                                                milliseconds: 200),
                                            child: LoginWidget(),
                                          ),
                                        );
                                      },
                                      text: 'Giriş Yap',
                                      options: EDButtonOptions(
                                        width: 85,
                                        height: 30,
                                        color: EsenDoTheme.of(context)
                                            .primaryColor,
                                        textStyle: EsenDoTheme.of(context)
                                            .subtitle2
                                            .override(
                                              fontFamily: 'Lexend Deca',
                                              color: EsenDoTheme.of(context)
                                                  .tertiaryColor,
                                            ),
                                        elevation: 0,
                                        borderSide: const BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: 0,
                                        disabledColor: EsenDoTheme.of(context)
                                            .primaryColor,
                                        disabledTextColor:
                                            EsenDoTheme.of(context)
                                                .secondaryColor,
                                        splashColor: EsenDoTheme.of(context)
                                            .primaryColor,
                                        iconColor: Colors.transparent,
                                        padding: const EdgeInsets.all(0),
                                        iconPadding: const EdgeInsets.all(0),
                                        iconSize: 0,
                                      ),
                                      key: const Key('loginButton'),
                                      iconData: Icons.arrow_forward_ios,
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        color: EsenDoTheme.of(context)
                                            .secondaryColor,
                                        size: 20,
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
          ],
        ));
  }
}
