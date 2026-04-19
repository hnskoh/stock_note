import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/loading_overlay.dart';
import '../data/account_repository.dart';
import '../domain/account_model.dart';
import '../domain/account_type_model.dart';
import '../providers/account_provider.dart';

class AccountFormScreen extends ConsumerStatefulWidget {
  const AccountFormScreen({this.accountId, super.key});
  final int? accountId;

  @override
  ConsumerState<AccountFormScreen> createState() =>
      _AccountFormScreenState();
}

class _AccountFormScreenState extends ConsumerState<AccountFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  AccountType? _selectedType;
  bool _isLoading = false;
  bool _isEditMode = false;
  Account? _originalAccount;

  @override
  void initState() {
    super.initState();
    _isEditMode = widget.accountId != null;
    if (_isEditMode) _loadAccount();
  }

  Future<void> _loadAccount() async {
    setState(() => _isLoading = true);
    try {
      final account = await ref
          .read(accountRepositoryProvider)
          .getById(widget.accountId!);
      if (account != null && mounted) {
        _originalAccount = account;
        _nameController.text = account.name;
        setState(() {});
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final typesAsync = ref.watch(accountTypeListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? '계좌 수정' : '계좌 추가'),
      ),
      body: LoadingOverlay(
        isLoading: _isLoading,
        child: typesAsync.when(
          loading: () =>
              const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('오류: $e')),
          data: (types) {
            if (_selectedType == null) {
              if (_isEditMode && _originalAccount != null) {
                _selectedType = types.firstWhere(
                  (t) => t.typeCode == _originalAccount!.type,
                  orElse: () => types.first,
                );
              } else if (types.isNotEmpty) {
                _selectedType = types.first;
              }
            }

            return Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: '계좌 별칭 *',
                      hintText: '예: 미래에셋 IRP',
                    ),
                    validator: (v) =>
                        v?.isEmpty == true ? '계좌 별칭을 입력하세요.' : null,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<AccountType>(
                    value: _selectedType,
                    decoration: const InputDecoration(labelText: '계좌 유형 *'),
                    items: types
                        .map((t) => DropdownMenuItem(
                              value: t,
                              child: Text(t.typeLabel),
                            ))
                        .toList(),
                    onChanged: (v) =>
                        setState(() => _selectedType = v),
                    validator: (v) =>
                        v == null ? '계좌 유형을 선택하세요.' : null,
                  ),
                  const SizedBox(height: 32),
                  FilledButton(
                    onPressed: _isLoading ? null : _submit,
                    child: Text(_isEditMode ? '수정 완료' : '저장'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      final now = DateTime.now();
      final account = Account(
        id: _originalAccount?.id,
        name: _nameController.text.trim(),
        type: _selectedType!.typeCode,
        isActive: true,
        sortOrder: _originalAccount?.sortOrder ?? 0,
        createdAt: _originalAccount?.createdAt ?? now,
        updatedAt: now,
      );

      final repo = ref.read(accountRepositoryProvider);
      if (_isEditMode) {
        await repo.update(account);
      } else {
        await repo.insert(account);
      }

      ref.invalidate(accountListProvider);
      ref.invalidate(allAccountListProvider);
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('저장 실패: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}
