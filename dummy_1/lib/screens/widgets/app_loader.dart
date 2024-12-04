import 'package:flutter/material.dart';

/// AppLoader
class AppLoader extends StatelessWidget {
  /// AppLoader
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) => Container(
    height: 30,
    width: 30,
    alignment: Alignment.center,
    child: const CircularProgressIndicator(),
  );
}