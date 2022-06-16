// ignore_for_file: library_private_types_in_public_api

import '../esendo/esendo_theme.dart';
import '../esendo/esendo_util.dart';
import '../esendo/esendo_widgets.dart';
import '../main.dart';
import 'package:flutter/material.dart';

class GesturesWidget extends StatefulWidget {
  const GesturesWidget({Key? key}) : super(key: key);

  @override
  _GesturesWidgetState createState() => _GesturesWidgetState();
}

class _GesturesWidgetState extends State<GesturesWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view', parameters: {'screen_name': 'Gestures'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: EsenDoTheme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          'Gestures',
          style: EsenDoTheme.of(context).title2.override(
                fontFamily: 'Lexend Deca',
                color: EsenDoTheme.of(context).tertiaryColor,
                fontSize: 22,
              ),
        ),
        actions: const [],
        centerTitle: false,
        elevation: 2,
      ),
      backgroundColor: EsenDoTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: EsenDoTheme.of(context).primaryColor,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 5,
                        color: Color(0x411D2429),
                        offset: Offset(0, 2),
                      )
                    ],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        InkWell(
                          onDoubleTap: () async {
                            logFirebaseEvent(
                                'GESTURES_PAGE_GESTURES_IÇIN_BURAYA_BASINIZ_BUTTON_ON_DOUBLE_TAP');
                            logFirebaseEvent('Button_Navigate-To');
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const NavBarPage(initialPage: 'myTasks'),
                              ),
                            );
                          },
                          onLongPress: () async {
                            logFirebaseEvent(
                                'GESTURES_PAGE_GESTURES_IÇIN_BURAYA_BASINIZ_BUTTON_ON_LONG_PRESS');
                            logFirebaseEvent('Button_Navigate-To');
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const NavBarPage(
                                    initialPage: 'CompletedTasks'),
                              ),
                            );
                          },
                          child: EDButtonWidget(
                            onPressed: () async {
                              logFirebaseEvent(
                                  'GESTURES_PAGE_GESTURES_IÇIN_BURAYA_BASINIZ_BUTTON_ON_TAP');
                              logFirebaseEvent('Button_Navigate-Back');
                              Navigator.pop(context);
                            },
                            text: 'Gestures için buraya basınız',
                            options: EDButtonOptions(
                              width: 150,
                              height: 60,
                              color: EsenDoTheme.of(context).primaryColor,
                              textStyle: EsenDoTheme.of(context)
                                  .title3
                                  .override(
                                    fontFamily: 'Lexend Deca',
                                    color:
                                        EsenDoTheme.of(context).tertiaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                              elevation: 0,
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: 50,
                              disabledColor: Colors.white,
                              disabledTextColor:
                                  EsenDoTheme.of(context).primaryColor,
                              iconColor: EsenDoTheme.of(context).primaryColor,
                              iconSize: 24,
                              splashColor: Colors.white,
                              padding: const EdgeInsets.all(0),
                              iconPadding: const EdgeInsets.all(0),
                            ), key: const Key('GesturesWidget'), icon: Icon(
                              Icons.gesture,
                              color: EsenDoTheme.of(context).primaryColor,
                              size: 24,
                            ), iconData: Icons.gesture,
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
      ),
    );
  }
}
