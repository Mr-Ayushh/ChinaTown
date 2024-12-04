import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class ScreenLayout extends StatefulWidget {
  const ScreenLayout({
    super.key,
    required this.title,
    required this.child,
    this.showBackIcon = true,
    this.onBackPressed,
  });

  final String title;
  final Widget child;
  final bool showBackIcon;
  final void Function()? onBackPressed;

  @override
  State<ScreenLayout> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<ScreenLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    if (widget.showBackIcon)
                      IconButton(
                        onPressed: widget.onBackPressed,
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                        style: IconButton.styleFrom(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.white,
                          size: 25,
                        ),
                      ),
                    Expanded(
                      child: Center(
                        child: Text(
                          widget.title,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    if (widget.showBackIcon) const SizedBox(width: 25)
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 1.2,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.kF2F2F2,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: widget.child,
            ),
          ],
        ),
      ),
    );
  }
}
