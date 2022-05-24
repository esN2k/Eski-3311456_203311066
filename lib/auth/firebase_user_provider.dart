import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class EsenDoFirebaseUser {
  EsenDoFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

EsenDoFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<EsenDoFirebaseUser> esenDoFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<EsenDoFirebaseUser>((user) => currentUser = EsenDoFirebaseUser(user));
