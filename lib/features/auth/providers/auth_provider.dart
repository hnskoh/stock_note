import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/auth_repository.dart';
import '../domain/user_model.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (_) => AuthRepository(),
  // keepAlive by default for Provider
);

final authStateProvider = StreamProvider<AppUser?>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  repo.signInSilently().ignore();
  return repo.authStateChanges;
});
