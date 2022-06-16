// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print, depend_on_referenced_packages, unnecessary_null_comparison

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../backend/backend.dart';
import 'package:stream_transform/stream_transform.dart';
import 'firebase_user_provider.dart';

export 'anonymous_auth.dart';
export 'apple_auth.dart';
export 'email_auth.dart';
export 'google_auth.dart';

/// Tries to sign in or create an account using Firebase Auth.
/// Returns the User object if sign in was successful.
Future<User?> signInOrCreateAccount(
    BuildContext context, Future<UserCredential?> Function() signInFunc) async {
  try {
    final userCredential = await signInFunc();
    await maybeCreateUser(userCredential!.user!);
    return userCredential.user;
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text('Hata: [error]'.replaceAll('[error]', e.message!))),
    );
    return null;
  }
}

Future signOut(BuildContext context) async {
  _currentJwtToken = '';
  FirebaseAuth.instance.signOut();
}

Future deleteUser(BuildContext context) async {
  try {
    if (currentUser!.user == null) {
      print('Error: delete user attempted with no logged in user!');
      return;
    }
    await currentUser!.user.delete();
  } on FirebaseAuthException catch (e) {
    if (e.code == 'requires-recent-login') {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Too long since most recent sign in. Sign in again before deleting your account.')),
      );
    }
  }
}

Future resetPassword({String? email, BuildContext? context}) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email!);
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context!).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text('Hata: [error]'.replaceAll('[error]', e.message!))),
    );
    return null;
  }
  ScaffoldMessenger.of(context!).showSnackBar(
    SnackBar(content: Text('Şifre sıfırlama e-postası yollandı!')),
  );
}

Future sendEmailVerification() async =>
    currentUser!.user.sendEmailVerification();

String _currentJwtToken = '';

String? get currentUserEmail => currentUserDocument!.email;

String? get currentUserUid => currentUserDocument!.uid;

String get currentUserDisplayName => currentUserDocument!.displayName;

String? get currentUserPhoto => currentUserDocument!.photoUrl;

String? get currentPhoneNumber => currentUserDocument!.phoneNumber;

String get currentJwtToken => _currentJwtToken;

bool get currentUserEmailVerified {
  // Reloads the user when checking in order to get the most up to date
  // email verified status.
  if (!currentUser!.user.emailVerified) {
    currentUser!.user
        .reload()
        .then((_) => currentUser!.user = FirebaseAuth.instance.currentUser!);
  }
  return currentUser!.user.emailVerified;
}

// Set when using phone verification (after phone number is provided).
String _phoneAuthVerificationCode = "";
// Set when using phone sign in in web mode (ignored otherwise).
ConfirmationResult _webPhoneAuthConfirmationResult =
    false as ConfirmationResult;

Future beginPhoneAuth({
  BuildContext? context,
  String? phoneNumber,
  VoidCallback? onCodeSent,
}) async {
  if (kIsWeb) {
    _webPhoneAuthConfirmationResult =
        await FirebaseAuth.instance.signInWithPhoneNumber(phoneNumber!);
    onCodeSent!();
    return;
  }
  // If you'd like auto-verification, without the user having to enter the SMS
  // code manually. Follow these instructions:
  // * For Android: https://firebase.google.com/docs/auth/android/phone-auth?authuser=0#enable-app-verification (SafetyNet set up)
  // * For iOS: https://firebase.google.com/docs/auth/ios/phone-auth?authuser=0#start-receiving-silent-notifications
  // * Finally modify verificationCompleted below as instructed.
  await FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: phoneNumber!,
    timeout: Duration(seconds: 5),
    verificationCompleted: (phoneAuthCredential) async {
      await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      // If you've implemented auto-verification, navigate to home page or
      // onboarding page here manually. Uncomment the lines below and replace
      // DestinationPage() with the desired widget.
      // await Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (_) => DestinationPage()),
      // );
    },
    verificationFailed: (e) {
      ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
        content: Text('Hata: [error]'.replaceAll('[error]', e.message!)),
      ));
    },
    codeSent: (verificationId, _) {
      _phoneAuthVerificationCode = verificationId;
      onCodeSent!();
    },
    codeAutoRetrievalTimeout: (_) {},
  );
}

Future verifySmsCode({
  BuildContext? context,
  String? smsCode,
}) async {
  if (kIsWeb) {
    return signInOrCreateAccount(
        context!, () => _webPhoneAuthConfirmationResult.confirm(smsCode!));
  } else {
    final authCredential = PhoneAuthProvider.credential(
        verificationId: _phoneAuthVerificationCode, smsCode: smsCode!);
    return signInOrCreateAccount(
      context!,
      () => FirebaseAuth.instance.signInWithCredential(authCredential),
    );
  }
}

DocumentReference? get currentUserReference => currentUser!.user != null
    ? UsersRecord.collection.doc(currentUser!.user.uid)
    : null;

UsersRecord? currentUserDocument;
final authenticatedUserStream = FirebaseAuth.instance
    .authStateChanges()
    .map<String>((user) {
      // Store jwt token on user update.
      () async {
        _currentJwtToken = (await user?.getIdToken())!;
      }();
      return user?.uid ?? '';
    })
    .switchMap((uid) => queryUsersRecord(
        queryBuilder: (user) => user.where('uid', isEqualTo: uid),
        singleRecord: true))
    .map((users) =>
        currentUserDocument = (users.isNotEmpty ? users.first : null)!)
    .asBroadcastStream();

class AuthUserStreamWidget extends StatelessWidget {
  const AuthUserStreamWidget({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: authenticatedUserStream,
        builder: (context, _) => child,
      );
}
