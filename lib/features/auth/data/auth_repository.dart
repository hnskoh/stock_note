import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:googleapis_auth/googleapis_auth.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/error/app_exception.dart';
import '../domain/user_model.dart';

class AuthRepository {
  AuthRepository()
      : _googleSignIn = GoogleSignIn(
          scopes: AppConstants.driveScopes,
          clientId: kIsWeb
              ? '587400383504-7old5oilvoj9cq8qlp512nbs6glem49o.apps.googleusercontent.com'
              : null,
        );

  final GoogleSignIn _googleSignIn;

  Stream<AppUser?> get authStateChanges =>
      _googleSignIn.onCurrentUserChanged.map(
        (account) => account == null ? null : _mapToUser(account),
      );

  GoogleSignInAccount? get currentAccount => _googleSignIn.currentUser;

  Future<AppUser?> signInSilently() async {
    try {
      final account = await _googleSignIn.signInSilently();
      return account == null ? null : _mapToUser(account);
    } catch (_) {
      return null;
    }
  }

  Future<AppUser?> signIn() async {
    try {
      final existing = await _googleSignIn.signInSilently();
      if (existing != null) return _mapToUser(existing);

      final account = await _googleSignIn.signIn();
      return account == null ? null : _mapToUser(account);
    } catch (e) {
      throw AuthException('Google 로그인 실패: $e');
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }

  Future<AuthClient?> getAuthClient() async {
    try {
      return await _googleSignIn.authenticatedClient();
    } catch (e) {
      throw AuthException('인증 클라이언트 생성 실패: $e');
    }
  }

  AppUser _mapToUser(GoogleSignInAccount account) => AppUser(
        id: account.id,
        email: account.email,
        displayName: account.displayName,
        photoUrl: account.photoUrl,
      );
}
