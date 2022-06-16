// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison, library_private_types_in_public_api

import '../auth/auth_util.dart';
import '../esendo/esendo_animations.dart';
import '../esendo/esendo_theme.dart';
import '../esendo/esendo_util.dart';
import '../esendo/esendo_widgets.dart';
import '../main.dart';
import '../register/register_widget.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget>
    with TickerProviderStateMixin {
  late TextEditingController emailTextController;
  late TextEditingController passwordTextController;
  late bool passwordVisibility;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final animationsMap = {
    'formOnPageLoadAnimation': AnimationInfo(
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
  };

  @override
  void initState() {
    super.initState();
    startPageLoadAnimations(
      animationsMap.values
          .where((anim) => anim.trigger == AnimationTrigger.onPageLoad),
      this,
    );

    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    passwordVisibility = false;
    logFirebaseEvent('screen_view', parameters: {'screen_name': 'Login'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: EsenDoTheme.of(context).primaryColor,
        body: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
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
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              24, 0, 24, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              TextFormField(
                                controller: emailTextController,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'E-posta Adresi',
                                  hintText: 'E-posta buraya girilir...',
                                  hintStyle: EsenDoTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Lexend Deca',
                                        color: const Color(0x9AFFFFFF),
                                      ),
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
                                  prefixIcon: Icon(
                                    Icons.email_outlined,
                                    color: EsenDoTheme.of(context).primaryColor,
                                  ),
                                ),
                                style:
                                    EsenDoTheme.of(context).bodyText1.override(
                                          fontFamily: 'Lexend Deca',
                                          color: EsenDoTheme.of(context)
                                              .secondaryColor,
                                        ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Please fill in a valid email address...';
                                  }

                                  return null;
                                },
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 20, 0, 0),
                                child: TextFormField(
                                  controller: passwordTextController,
                                  obscureText: !passwordVisibility,
                                  decoration: InputDecoration(
                                    labelText: 'Şifre',
                                    hintText: 'Şifre de buraya girer...',
                                    hintStyle: EsenDoTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Lexend Deca',
                                          color: const Color(0x9AFFFFFF),
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
                                      Icons.lock_outline,
                                      color:
                                          EsenDoTheme.of(context).primaryColor,
                                    ),
                                    suffixIcon: InkWell(
                                      onTap: () => setState(
                                        () => passwordVisibility =
                                            !passwordVisibility,
                                      ),
                                      child: Icon(
                                        passwordVisibility
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: EsenDoTheme.of(context)
                                            .secondaryColor,
                                        size: 22,
                                      ),
                                    ),
                                  ),
                                  style: EsenDoTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Lexend Deca',
                                        color: EsenDoTheme.of(context)
                                            .secondaryColor,
                                      ),
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return 'That password doesn\'t match.';
                                    }

                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 24, 0, 0),
                                child: EDButtonWidget(
                                  onPressed: () async {
                                    logFirebaseEvent('Button_ON_TAP');
                                    logFirebaseEvent('Button_Auth');

                                    final user = await signInWithEmail(
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
                                  text: 'Giriş Yap',
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
                                    borderRadius: 8,
                                    disabledColor: Colors.white,
                                    disabledTextColor:
                                        EsenDoTheme.of(context).primaryColor,
                                    iconColor:
                                        EsenDoTheme.of(context).primaryColor,
                                    iconSize: 24,
                                    splashColor: Colors.white,
                                    padding: const EdgeInsets.all(0),
                                    iconPadding: const EdgeInsets.all(0),
                                  ),
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: EsenDoTheme.of(context).primaryColor,
                                  ),
                                  iconData: Icons.arrow_forward_ios,
                                  key: const Key('loginButton'),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 8, 0, 30),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 0, 6),
                                        child: Text(
                                          'Hesabın yoksa hemen oluştur?',
                                          style: EsenDoTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Lexend Deca',
                                                color: EsenDoTheme.of(context)
                                                    .darkBG,
                                              ),
                                        ),
                                      ),
                                      EDButtonWidget(
                                        onPressed: () async {
                                          logFirebaseEvent('Button_ON_TAP');
                                          logFirebaseEvent(
                                              'Button_Navigate-To');
                                          await Navigator.push(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType.fade,
                                              duration: const Duration(
                                                  milliseconds: 200),
                                              reverseDuration: const Duration(
                                                  milliseconds: 200),
                                              child: const RegisterWidget(),
                                            ),
                                          );
                                        },
                                        text: 'Hesap Oluştur',
                                        options: EDButtonOptions(
                                          width: 126,
                                          height: 32,
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
                                          borderRadius: 8,
                                          disabledColor: Colors.white,
                                          disabledTextColor:
                                              EsenDoTheme.of(context)
                                                  .primaryColor,
                                          iconColor: EsenDoTheme.of(context)
                                              .primaryColor,
                                          iconSize: 24,
                                          splashColor: Colors.white,
                                          padding: const EdgeInsets.all(0),
                                          iconPadding: const EdgeInsets.all(0),
                                        ),
                                        icon: Icon(
                                          Icons.arrow_forward_ios,
                                          color: EsenDoTheme.of(context)
                                              .tertiaryColor,
                                        ),
                                        iconData: Icons.arrow_forward_ios,
                                        key: const Key('registerButton'),
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
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
