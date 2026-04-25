import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/error/app_exception.dart';
import '../domain/user_model.dart';

class AuthRepository {
  AuthRepository()
      : _auth = FirebaseAuth.instance,
        _googleSignIn = GoogleSignIn();

  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  Stream<AppUser?> get authStateChanges => _auth.authStateChanges().map(
        (user) => user == null ? null : _mapToUser(user),
      );

  Future<AppUser?> signInSilently() async {
    final user = _auth.currentUser;
    return user == null ? null : _mapToUser(user);
  }

  Future<AppUser?> signIn() async {
    try {
      if (kIsWeb) {
        final result = await _auth.signInWithPopup(GoogleAuthProvider());
        return result.user == null ? null : _mapToUser(result.user!);
      } else {
        final googleUser = await _googleSignIn.signIn();
        if (googleUser == null) return null;
        final googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final result = await _auth.signInWithCredential(credential);
        return result.user == null ? null : _mapToUser(result.user!);
      }
    } catch (e) {
      throw AuthException('Google 로그인 실패: $e');
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    if (!kIsWeb) await _googleSignIn.signOut();
  }

  AppUser _mapToUser(User user) => AppUser(
        id: user.uid,
        email: user.email ?? '',
        displayName: user.displayName,
        photoUrl: user.photoURL,
      );
}
