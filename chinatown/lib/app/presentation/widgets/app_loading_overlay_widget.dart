import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({
    super.key,
    required this.child,
    this.isLoading,
  });
  final Widget child;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) => isLoading!
      ? const Center(
          child: CircularProgressIndicator(
          color: primaryColor,
        ))
      : child;
}
