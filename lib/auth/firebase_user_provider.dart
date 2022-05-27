import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class EsendoFirebaseUser {
  EsendoFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

EsendoFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<EsendoFirebaseUser> esendoFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<EsendoFirebaseUser>((user) => currentUser = EsendoFirebaseUser(user));
