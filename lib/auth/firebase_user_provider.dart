import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class SampleFirebaseUser {
  SampleFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

SampleFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<SampleFirebaseUser> sampleFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<SampleFirebaseUser>((user) => currentUser = SampleFirebaseUser(user));
