import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/account_repository.dart';
import '../data/account_type_repository.dart';
import '../domain/account_model.dart';
import '../domain/account_type_model.dart';

final accountTypeListProvider = FutureProvider<List<AccountType>>(
  (ref) => ref.watch(accountTypeRepositoryProvider).getAll(),
);

final accountListProvider = FutureProvider<List<Account>>(
  (ref) => ref.watch(accountRepositoryProvider).getAll(),
);

final allAccountListProvider = FutureProvider<List<Account>>(
  (ref) => ref.watch(accountRepositoryProvider).getAll(activeOnly: false),
);
