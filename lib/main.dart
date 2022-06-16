// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'auth/firebase_user_provider.dart';
import 'auth/auth_util.dart';

import 'esendo/esendo_theme.dart';
import 'esendo/internationalization.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await EsenDoTheme.initialize();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  late Locale _locale;
  late ThemeMode _themeMode = EsenDoTheme.themeMode;

  late Stream<EsendoFirebaseUser> userStream;
  late EsendoFirebaseUser initialUser;
  late bool displaySplashImage = true;

  final authUserSub = authenticatedUserStream.listen((_) {});

  @override
  void initState() {
    super.initState();
    userStream = esendoFirebaseUserStream()
      ..listen((user) => initialUser);
    Future.delayed(
      const Duration(seconds: 1),
      () => setState(() => displaySplashImage = false),
    );
  }

  @override
  void dispose() {
    authUserSub.cancel();

    super.dispose();
  }

  void setLocale(Locale value) => setState(() => _locale = value);
  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
        EsenDoTheme.saveThemeMode(mode);
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Esendo',
      localizationsDelegates: const [
        EDLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: const [
        Locale('tr', ''),
      ],
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: _themeMode,
      home: displaySplashImage
          ? Container(
              color: Colors.transparent,
              child: Builder(
                builder: (context) => Image.asset(
                  'assets/images/Adsz_tasarm_(4).png',
                  fit: BoxFit.cover,
                ),
              ),
            )
          : currentUser!.loggedIn
              ? const NavBarPage(initialPage: '',)
              : const SplashScreenWidget(),
    );
  }
}

class NavBarPage extends StatefulWidget {
  const NavBarPage({Key? key, required this.initialPage}) : super(key: key);

  final String initialPage;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPage = 'myTasks';

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'CompletedTasks': CompletedTasksWidget(),
      'myTasks':  MyTasksWidget(),
      'MyProfile': MyProfileWidget(displayName: null,),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPage);
    return Scaffold(
      body: tabs[_currentPage],
      bottomNavigationBar: GNav(
        selectedIndex: currentIndex,
        onTabChange: (i) =>
            setState(() => _currentPage = tabs.keys.toList()[i]),
        backgroundColor: EsenDoTheme.of(context).secondaryColor,
        color: EsenDoTheme.of(context).tertiaryColor,
        activeColor: EsenDoTheme.of(context).primaryColor,
        tabBackgroundColor: const Color(0x00000000),
        tabActiveBorder: Border.all(
          color: EsenDoTheme.of(context).primaryColor,
          width: 2,
        ),
        tabBorderRadius: 100,
        tabMargin: const EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
        padding: const EdgeInsetsDirectional.fromSTEB(3, 3, 3, 3),
        gap: 0,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        duration: const Duration(milliseconds: 500),
        haptic: true,
        tabs: [
          GButton(
            icon: currentIndex == 0 ? Icons.alarm_on : Icons.alarm_on,
            text: 'Yaptıklarım',
            iconSize: 32,
          ),
          GButton(
            icon: currentIndex == 1 ? Icons.playlist_add : Icons.playlist_add,
            text: 'Yapılacaklarım',
            iconSize: 32,
          ),
          GButton(
            icon: currentIndex == 2 ? Icons.person_sharp : Icons.person_outline,
            text: 'Profil',
            iconSize: 32,
          )
        ],
      ),
    );
  }
}
