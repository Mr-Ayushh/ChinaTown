import 'dart:io';

import 'package:flutter/material.dart';

class AppImageWidget extends StatelessWidget {
  const AppImageWidget(
      {super.key,
      this.type,
      this.assetFilePath,
      this.url,
      this.width,
      this.height,
      this.fit,
      this.file});
  final String? type, assetFilePath, url;
  final double? width, height;
  final BoxFit? fit;
  final File? file;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          if (type == "asset") ...[
            Image.asset(assetFilePath!, width: width, height: height, fit: fit)
          ] else if (type == "file") ...[
            Image.file(file!, width: width, height: height, fit: fit)
          ] else if (type == "network") ...[
            Image.network(url!, width: width, height: height, fit: fit)
          ],
        ],
      );
}
