import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/date_formatter.dart';
import '../providers/sync_provider.dart';
import '../domain/sync_state.dart';

class SyncStatusChip extends ConsumerWidget {
  const SyncStatusChip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final syncState = ref.watch(syncControllerProvider);

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: switch (syncState) {
        SyncIdle(:final lastSyncedAt) => _chip(
            context,
            Icons.cloud_done_outlined,
            lastSyncedAt != null ? toDisplayDate(lastSyncedAt) : '미동기화',
            Colors.green,
          ),
        SyncCheckingOut() || SyncUploading() => _loadingChip(context),
        SyncSuccess(:final syncedAt) => _chip(
            context,
            Icons.cloud_done,
            toDisplayDate(syncedAt),
            Colors.green,
          ),
        SyncOffline() => _chip(
            context, Icons.cloud_off, '오프라인', Colors.orange),
        SyncError(:final message) => _chip(
            context, Icons.error_outline, '오류', Colors.red,
            tooltip: message),
        SyncLocked() => _chip(
            context, Icons.lock_outline, '잠김', Colors.amber),
      },
    );
  }

  Widget _chip(
    BuildContext context,
    IconData icon,
    String label,
    Color color, {
    String? tooltip,
  }) {
    final chip = Chip(
      avatar: Icon(icon, size: 16, color: color),
      label: Text(label, style: TextStyle(fontSize: 12, color: color)),
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      backgroundColor: color.withValues(alpha: 0.1),
      side: BorderSide(color: color.withValues(alpha: 0.3)),
    );
    if (tooltip != null) {
      return Tooltip(message: tooltip, child: chip);
    }
    return chip;
  }

  Widget _loadingChip(BuildContext context) => const Chip(
        avatar: SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
        label: Text('동기화 중...', style: TextStyle(fontSize: 12)),
        padding: EdgeInsets.zero,
        visualDensity: VisualDensity.compact,
      );
}
