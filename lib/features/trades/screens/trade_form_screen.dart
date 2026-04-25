import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/constants/trade_action.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../shared/widgets/loading_overlay.dart';
import '../../accounts/domain/account_model.dart';
import '../../accounts/providers/account_provider.dart';
import '../data/trade_repository.dart';
import '../domain/trade_model.dart';
import '../providers/trade_provider.dart';

class TradeFormScreen extends ConsumerStatefulWidget {
  const TradeFormScreen({this.tradeId, super.key});
  final String? tradeId;

  @override
  ConsumerState<TradeFormScreen> createState() => _TradeFormScreenState();
}

class _TradeFormScreenState extends ConsumerState<TradeFormScreen> {
  final _formKey = GlobalKey<FormState>();

  Account? _selectedAccount;
  DateTime _tradeDate = DateTime.now();
  TradeAction _action = TradeAction.buy;
  final _tickerController = TextEditingController();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();
  final _feeController = TextEditingController(text: '0');
  final _noteController = TextEditingController();

  bool _isLoading = false;
  bool _isEditMode = false;
  TradeModel? _originalTrade;

  @override
  void initState() {
    super.initState();
    _isEditMode = widget.tradeId != null;
    if (_isEditMode) _loadTrade();
  }

  Future<void> _loadTrade() async {
    setState(() => _isLoading = true);
    try {
      final trade = await ref
          .read(tradeRepositoryProvider)
          .getById(widget.tradeId!);
      if (trade != null && mounted) {
        _originalTrade = trade;
        _tradeDate = trade.tradeDate;
        _action = trade.action;
        _tickerController.text = trade.tickerName;
        _quantityController.text = formatQuantity(trade.quantity);
        _priceController.text = trade.price.toStringAsFixed(0);
        _feeController.text = trade.fee.toStringAsFixed(0);
        _noteController.text = trade.note ?? '';
        setState(() {});
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  double get _totalAmount {
    final qty = double.tryParse(_quantityController.text) ?? 0;
    final price = double.tryParse(_priceController.text) ?? 0;
    final fee = double.tryParse(_feeController.text) ?? 0;
    return TradeModel.calcTotal(
        action: _action, quantity: qty, price: price, fee: fee);
  }

  @override
  void dispose() {
    _tickerController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    _feeController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accountsAsync = ref.watch(accountListProvider);
    final tickersAsync = ref.watch(distinctTickersProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? '매매 기록 수정' : '매매 기록 추가'),
      ),
      body: LoadingOverlay(
        isLoading: _isLoading,
        child: accountsAsync.when(
          loading: () =>
              const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('오류: $e')),
          data: (accounts) {
            if (_isEditMode && _selectedAccount == null && _originalTrade != null) {
              _selectedAccount = accounts.firstWhere(
                (a) => a.id == _originalTrade!.accountId,
                orElse: () => accounts.first,
              );
            } else if (!_isEditMode && _selectedAccount == null && accounts.isNotEmpty) {
              _selectedAccount = accounts.first;
            }

            return Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  DropdownButtonFormField<Account>(
                    value: _selectedAccount,
                    decoration: const InputDecoration(labelText: '계좌 *'),
                    items: accounts
                        .map((a) => DropdownMenuItem(
                              value: a,
                              child: Text(
                                  '${a.name} (${a.typeLabel ?? a.type})'),
                            ))
                        .toList(),
                    onChanged: (v) => setState(() => _selectedAccount = v),
                    validator: (v) => v == null ? '계좌를 선택하세요.' : null,
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.calendar_today),
                    title: const Text('매매일'),
                    subtitle: Text(toDisplayDate(_tradeDate)),
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _tradeDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) {
                        setState(() => _tradeDate = picked);
                      }
                    },
                  ),
                  const Divider(),
                  const SizedBox(height: 8),
                  tickersAsync.when(
                    loading: () => TextFormField(
                      controller: _tickerController,
                      decoration: const InputDecoration(labelText: '종목명 *'),
                      validator: (v) =>
                          v?.isEmpty == true ? '종목명을 입력하세요.' : null,
                    ),
                    error: (_, __) => TextFormField(
                      controller: _tickerController,
                      decoration: const InputDecoration(labelText: '종목명 *'),
                    ),
                    data: (tickers) => Autocomplete<String>(
                      initialValue:
                          TextEditingValue(text: _tickerController.text),
                      optionsBuilder: (value) {
                        if (value.text.isEmpty) return tickers;
                        return tickers.where((t) => t
                            .toLowerCase()
                            .contains(value.text.toLowerCase()));
                      },
                      onSelected: (v) {
                        _tickerController.text = v;
                      },
                      fieldViewBuilder:
                          (ctx, ctrl, focusNode, onSubmit) =>
                              TextFormField(
                        controller: ctrl,
                        focusNode: focusNode,
                        decoration:
                            const InputDecoration(labelText: '종목명 *'),
                        validator: (v) =>
                            v?.isEmpty == true ? '종목명을 입력하세요.' : null,
                        onChanged: (v) => _tickerController.text = v,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SegmentedButton<TradeAction>(
                    segments: [
                      ButtonSegment(
                        value: TradeAction.buy,
                        label: const Text('매수'),
                        icon: const Icon(Icons.arrow_upward),
                      ),
                      ButtonSegment(
                        value: TradeAction.sell,
                        label: const Text('매도'),
                        icon: const Icon(Icons.arrow_downward),
                      ),
                    ],
                    selected: {_action},
                    onSelectionChanged: (s) =>
                        setState(() => _action = s.first),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _quantityController,
                    decoration: const InputDecoration(
                        labelText: '수량 *', suffixText: '주'),
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*'))
                    ],
                    validator: (v) {
                      if (v?.isEmpty == true) return '수량을 입력하세요.';
                      if ((double.tryParse(v!) ?? 0) <= 0) {
                        return '0보다 큰 수량을 입력하세요.';
                      }
                      return null;
                    },
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _priceController,
                    decoration: const InputDecoration(
                        labelText: '단가 *', suffixText: '원'),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: (v) {
                      if (v?.isEmpty == true) return '단가를 입력하세요.';
                      if ((double.tryParse(v!) ?? -1) < 0) {
                        return '올바른 단가를 입력하세요.';
                      }
                      return null;
                    },
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _feeController,
                    decoration: const InputDecoration(
                        labelText: '수수료', suffixText: '원'),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('총 금액'),
                        Text(
                          formatKrw(_totalAmount),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _noteController,
                    decoration: const InputDecoration(
                      labelText: '매매 사유 / 메모 (선택)',
                      alignLabelWithHint: true,
                    ),
                    maxLines: 5,
                    maxLength: AppConstants.memoMaxLength,
                  ),
                  const SizedBox(height: 24),
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
    if (_selectedAccount == null) return;

    setState(() => _isLoading = true);
    try {
      final qty = double.parse(_quantityController.text);
      final price = double.parse(_priceController.text);
      final fee = double.tryParse(_feeController.text) ?? 0;
      final now = DateTime.now();

      final trade = TradeModel(
        id: _originalTrade?.id,
        accountId: _selectedAccount!.id!,
        accountName: _selectedAccount!.name,
        tradeDate: _tradeDate,
        tickerName: _tickerController.text.trim(),
        action: _action,
        quantity: qty,
        price: price,
        fee: fee,
        totalAmount: TradeModel.calcTotal(
            action: _action, quantity: qty, price: price, fee: fee),
        note: _noteController.text.trim().isEmpty
            ? null
            : _noteController.text.trim(),
        createdAt: _originalTrade?.createdAt ?? now,
        updatedAt: now,
      );

      final repo = ref.read(tradeRepositoryProvider);
      if (_isEditMode) {
        await repo.update(trade);
      } else {
        await repo.insert(trade);
      }

      ref.invalidate(filteredTradesProvider);
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
