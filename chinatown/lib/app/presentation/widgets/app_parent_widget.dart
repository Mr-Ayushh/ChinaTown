import 'package:flutter/material.dart';

class AppParentWidget extends StatelessWidget {
  final bool? safeAreaTop, resizeToAvoidBottomInset;
  final PreferredSizeWidget? appBar;
  final Color? bgColor;
  final Widget? bodyWidget,
      bottomNavigationBar,
      bottomWidget,
      floatingActionButton;
  const AppParentWidget({
    super.key,
    this.safeAreaTop,
    this.resizeToAvoidBottomInset,
    this.appBar,
    this.bgColor,
    this.bottomWidget,
    this.bodyWidget,
    this.bottomNavigationBar,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) => SafeArea(
        top: safeAreaTop ?? false,
        child: Scaffold(
          backgroundColor: bgColor,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          appBar: appBar,
          body: bodyWidget,
          bottomSheet: bottomWidget,
          bottomNavigationBar: bottomNavigationBar,
          floatingActionButton: floatingActionButton,
        ),
      );
}
