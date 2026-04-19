import 'package:flutter/material.dart';

/// 작업 중 전체 화면을 덮어 사용자 조작을 차단하는 오버레이 위젯
class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({
    required this.isLoading,
    required this.child,
    super.key,
  });

  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.scrim.withAlpha(128);
    return Stack(
      children: [
        IgnorePointer(ignoring: isLoading, child: child),
        if (isLoading)
          Positioned.fill(
            child: Material(
              color: color,
              child: const Center(child: CircularProgressIndicator()),
            ),
          ),
      ],
    );
  }
}
