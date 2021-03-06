//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/widgets.dart';
//import 'package:google_sign_in/google_sign_in.dart';
//
//enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }
//
//class UserRepository with ChangeNotifier {
//  FirebaseAuth _auth;
//  GoogleSignIn _googleSignIn;
//  FirebaseUser _user;
//  Status _status = Status.Uninitialized;
//
//  UserRepository.instance() : _auth = FirebaseAuth.instance {
//    _auth.onAuthStateChanged.listen(_onAuthStateChanged);
//    _googleSignIn = _googleSignIn ?? GoogleSignIn();
//  }
//
//  Status get status => _status;
//
//  FirebaseUser get user => _user;
//
//  Future<AuthResult> signIn({String email, String password}) async {
//    try {
//      _status = Status.Authenticating;
//      notifyListeners();
//      var x = await _auth.signInWithEmailAndPassword(
//          email: email, password: password);
//      return x;
//    } catch (e) {
//      _status = Status.Unauthenticated;
//      notifyListeners();
//      return null;
//    }
//  }
//
//  Future<AuthResult> signInWithGoogle() async {
//    _status = Status.Authenticating;
//    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
//    final GoogleSignInAuthentication googleAuth =
//        await googleUser.authentication;
//    final AuthCredential credential = GoogleAuthProvider.getCredential(
//      accessToken: googleAuth.accessToken,
//      idToken: googleAuth.idToken,
//    );
//    var x = await _auth.signInWithCredential(credential);
//    print(_auth.currentUser());
//    notifyListeners();
//    return x;
//  }
//
//  Future<AuthResult> createUser({String email, String password}) async {
//    try {
//      _status = Status.Authenticating;
//      notifyListeners();
//      return await _auth.createUserWithEmailAndPassword(
//          email: email, password: password);
//    } catch (e) {
//      _status = Status.Unauthenticated;
//      notifyListeners();
//      return null;
//    }
//  }
//
//  Future signOut() async {
//    _googleSignIn.signOut();
//    _auth.signOut();
//    _status = Status.Unauthenticated;
//    notifyListeners();
//    return Future.delayed(Duration.zero);
//  }
//
//  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
//    if (firebaseUser == null) {
//      _status = Status.Unauthenticated;
//    } else {
//      _user = firebaseUser;
//      _status = Status.Authenticated;
//    }
//    notifyListeners();
//  }
//
//  Future<void> resetPassword(String email) async {
//    await _auth.sendPasswordResetEmail(email: email);
//  }
//}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;

  // Only taking the first part of the name, i.e., First Name

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

  return 'signInWithGoogle succeeded: $user';
}

void signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Sign Out");
}
